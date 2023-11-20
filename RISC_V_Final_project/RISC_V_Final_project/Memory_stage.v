// `include "Data_Memory.v"
// `include "Mux.v"
// `include "Sign_extendmemory.v"
module memory_stage(clk,rst,MemwriteM,RegwriteM,Memory_selectorM,MuxsignM,Mux_WD_memwriteM,Writedata_M,PCPlus4M,AluResultM,Immediate_valueM,
PCPlus_offsetM,RDM,Result_SrcM,SignEXM,RegwriteW,Result_SrcW,AluResultW,ReadDataW,PCPlus4W,Immediate_valueW,PCPlus_offsetW,RDW);
    input clk,rst,MemwriteM,RegwriteM,MuxsignM,Mux_WD_memwriteM, Memory_selectorM;
    input [31:0] Writedata_M,PCPlus4M,AluResultM,Immediate_valueM,PCPlus_offsetM;
    input [4:0] RDM;
    input [2:0] Result_SrcM;
    input [1:0] SignEXM;
    output reg RegwriteW;
    output reg [2:0] Result_SrcW;
    output reg [31:0] AluResultW,ReadDataW,PCPlus4W,Immediate_valueW,PCPlus_offsetW;
    output reg [4:0] RDW;
    wire [31:0] Data_mem,Write_data_Muxout,Write_data_Sign1,Write_data_Sign2,ReadDatawire;
    Mux Mux1(.I0(Writedata_M),.I1(Write_data_Sign1),.s(Mux_WD_memwriteM),.out(Write_data_Muxout));
    sign_extendmemory s1(.data_from_execute(Writedata_M),.SignEXM(SignEXM),.output_data(Write_data_Sign1));
    Data_Memory M1(.clk(clk),.rst(rst),.Ena(out_1_demux),.Data_in(Write_data_Muxout),.Address(AluResultM),.Data_out(Data_mem));
    sign_extendmemory s2(.data_from_execute(Data_mem), .SignEXM(SignEXM),.output_data(Write_data_Sign2));
    Mux Mux2(.I0(Data_mem),.I1(Write_data_Sign2),.s(MuxsignM),.out(ReadDatawire));
    memory_map mem(.clk(clk), .rst(rst), .Write_Ena(out_0_demux), .Write_addr(AluResultM), .Write_data(Write_data_Muxout));
    Demux de_mux(.In(MemwriteM), .sel(Memory_selectorM), .out1(out_0_demux), .out2(out_1_demux));
    always@(posedge clk or posedge rst)
    begin
        if(rst)
        begin
        AluResultW<=32'h00000000;
        ReadDataW<=32'h00000000;
        PCPlus4W<=32'h00000000;
        Immediate_valueW<=32'h00000000;
        PCPlus_offsetW<=32'h00000000;
        RDW<=5'b00000;
        Result_SrcW<=3'b000;
        RegwriteW<=1'b0;
        end
        else
        begin
        AluResultW<=AluResultM;
        ReadDataW<=ReadDatawire;
        PCPlus4W<=PCPlus4M;
        Immediate_valueW<=Immediate_valueM;
        PCPlus_offsetW<=PCPlus_offsetW;
        RDW<=RDM;
        Result_SrcW<=Result_SrcM;
        RegwriteW<=RegwriteM;
        end
    end




endmodule