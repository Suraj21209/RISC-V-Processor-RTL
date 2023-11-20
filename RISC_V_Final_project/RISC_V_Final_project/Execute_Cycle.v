// `include "ALU.v"
// `include "PC_adder.v"
// `include "Mux.v"

module execute_cycle(clk, rst, Hazardmux_sel1, Hazardmux_sel2, AluResultM, Result_writeback, RegWriteE, Memory_selectorE, ALUSrcE, MemWriteE, ResultSrcE, BranchE, jumpE, ALUControlE, SignExME, MuxsignE, MUXWDMemwriteE,
    RD1_E, RD2_E, Imm_Ext_E, RD_E, PCE, PCPlus4E, PCSrcE, PCTargetE, RegWriteM, MemWriteM, ResultSrcM, RD_M, PCPlus4M, WriteDataM,ALU_ResultM,
    SignExM, MuxsignM, MUXWDMemwriteM, Immediate_valueM, PCPlus_offsetM, Memory_selectorM);

    // Declaration I/Os
    input clk, rst, RegWriteE,ALUSrcE,MemWriteE,BranchE, MuxsignE, MUXWDMemwriteE, jumpE, Memory_selectorE ;
    input [2:0] ResultSrcE;
    input [31:0] RD1_E, RD2_E, Imm_Ext_E;
    input [4:0] RD_E ;
    input [3:0] ALUControlE;
    input [31:0] PCE, PCPlus4E, AluResultM, Result_writeback;
    input [1:0] SignExME, Hazardmux_sel1, Hazardmux_sel2;

    output reg  RegWriteM, MemWriteM,MuxsignM, MUXWDMemwriteM, Memory_selectorM;
    output reg [4:0] RD_M; 
    output reg [31:0] PCPlus4M, WriteDataM, ALU_ResultM, PCPlus_offsetM;
    output reg [31:0] Immediate_valueM;
    output reg [1:0] SignExM;
    output reg[2:0] ResultSrcM;

    output PCSrcE; 
    output [31:0] PCTargetE; 
    wire [31:0] ALU_ResultMw, PCPlus_offsetMw, result_hazardmux1, result_hazardmux2;

    // Declaration of Interim Wires
    wire midjump,midjump_not_equal,midjump_bge,midjump_bgeu,midjump_blt,midjump_bltu;
    wire [31:0] Src_B;
    wire [31:0] ResultE;

    //use these wire where needed
    wire ZeroE,Greater_E,Greater_Unsigned_E,Less_E,Less_Unsigned_E,Equal_E,Overflow_E,Carry_E;

    reg [31:0] Result_writebacknew;
    always @(posedge clk or posedge rst) begin
        if(rst)
        Result_writebacknew <= 32'd0;
        else
        Result_writebacknew <= Result_writeback;
    end
   

    
    Mux alu_src_mux (
            .I0(result_hazardmux2),
            .I1(Imm_Ext_E),
            .s(ALUSrcE),
            .out(Src_B)
            );

    // ALU Unit
    alu ALU (.In1(result_hazardmux1),.In2(Src_B),.Out(ResultE),.ALU_CTRL(ALUControlE),.Greater(Greater_E),.Greater_Unsigned(Greater_Unsigned_E),
    .Less(Less_E),.Less_Unsigned(Less_Unsigned_E),.Equal(Equal_E),.Overflow(Overflow_E),.Carry(Carry_E),.Zero(ZeroE),.Negative(Negative_E));
            

    // Adder
    adder branch_adder (
            .a(PCE),
            .b(Imm_Ext_E),
            .out(PCTargetE)
            );

    Mux3x1 hazardmux1( .I0(RD1_E), .I1(AluResultM), .I2(Result_writeback), .I3(Result_writebacknew), .s(Hazardmux_sel1), .out(result_hazardmux1));
    Mux3x1 hazardmux2( .I0(RD2_E), .I1(AluResultM), .I2(Result_writeback), .I3(Result_writebacknew), .s(Hazardmux_sel2), .out(result_hazardmux2));


    
    assign midjump = ZeroE & BranchE;
    
    assign midjump_not_equal = Equal_E & BranchE;

    assign midjump_blt = Less_E & BranchE;

    assign midjump_bge = Greater_E & BranchE;

    assign midjump_bltu = Less_Unsigned_E & BranchE;

    assign midjump_bgeu = Greater_Unsigned_E & BranchE;

    assign PCSrcE = jumpE | midjump | midjump_not_equal | midjump_blt |midjump_bge |midjump_bltu | midjump_bgeu;

    always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
    RegWriteM <= 1'b0;
    MemWriteM <= 1'b0; 
    ResultSrcM <= 3'b000;
    MuxsignM <= 1'b0;
    MUXWDMemwriteM <= 1'b0;
    RD_M <= 5'b00000; 
    PCPlus4M <= 32'h00000000;
    WriteDataM <= 32'h00000000;
    ALU_ResultM <= 32'h00000000; 
    PCPlus_offsetM <= 32'h00000000;
    Immediate_valueM <= 32'h00000000;
    SignExM <= 2'b00;
    Memory_selectorM <= 1'b0;
    end

    else
    begin
    RegWriteM <= RegWriteE;
    MemWriteM <= MemWriteE; 
    ResultSrcM <= ResultSrcE;
    MuxsignM <= MuxsignE;
    MUXWDMemwriteM <= MUXWDMemwriteE;
    RD_M <= RD_E; 
    PCPlus4M <= PCPlus4E;
    WriteDataM <= result_hazardmux2;
    ALU_ResultM <= ResultE; 
    PCPlus_offsetM <= PCTargetE;
    Immediate_valueM <= Imm_Ext_E;
    SignExM <= SignExME;
    Memory_selectorM <= Memory_selectorE;

    end
end
 

endmodule