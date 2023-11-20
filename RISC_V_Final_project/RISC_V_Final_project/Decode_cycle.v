// `include "Sign_extenddecode.v"
// `include "Register_file.v"
// `include "Main_Decoder.v"
// `include "ALU_decoder.v"

module decode_stage(clk, rst, PCSrcE, InstructionD, Write_EnaW, Write_DataW, Write_addrW, PCD, PCplus4D, Immediate_valueE, Read_data1E, Read_data2E, 
branchE, jumpE, ALUsrcE, ResultsrcE, MemwriteE, RegwriteE, SignExME, MuxsignE, MUXWDMemwriteE, ALUcontrolE, PCE, PCplus4E, RDE, Memory_selectorE, 
Reg_Source1, Reg_Source2);
input clk, rst, Write_EnaW, PCSrcE; 
input [31:0]InstructionD, Write_DataW, PCD, PCplus4D; 
input [4:0]Write_addrW;

wire [31:0]Immediate_valueD, Read_data1D, Read_data2D, PCD, PCplus4D; 
wire branchD, jumpD, ALUsrcD, MemwriteD, RegwriteD, MuxsignD, MUXWDMemwriteD,Memory_selector; 
wire [2:0]ResultsrcD;
wire [1:0]SignExMD;
wire [3:0]ALUcontrolD;

output reg [31:0]Immediate_valueE, Read_data1E, Read_data2E, PCE, PCplus4E; 
output reg branchE, jumpE, ALUsrcE, MemwriteE, RegwriteE, MuxsignE, MUXWDMemwriteE, Memory_selectorE; 
output reg [2:0]ResultsrcE;
output reg [1:0]SignExME;
output reg [3:0]ALUcontrolE;
output reg [4:0]RDE, Reg_Source1, Reg_Source2;

wire [2:0]ImmSrcD, ALUop;
wire [31:0] Instruction;

assign Instruction = (PCSrcE) ? 32'h00000033 : InstructionD ;



main_decoder M1(.opcode(Instruction[6:0]), .funct3(Instruction[14:12]), .branch(branchD), .jump(jumpD), 
.ALUsrc(ALUsrcD), .ALUop(ALUop), .Resultsrc(ResultsrcD), .Memwrite(MemwriteD), .Regwrite(RegwriteD), .ImmSrc(ImmSrcD), 
.SignEXM(SignExMD), .MuxsignD(MuxsignD), .MUXWDMemwrite(MUXWDMemwriteD), .Memory_selector(Memory_selector));

alu_decoder A1(.ALUop(ALUop), .funct3(Instruction[14:12]), .opcode5(Instruction[4]), .funct76(Instruction[30]), .ALUcontrol(ALUcontrolD));

Register_File R1(.clk(clk), .rst(rst), .Write_Ena(Write_EnaW), .Write_data(Write_DataW), .Read_addr1(Instruction[19:15]),
.Read_addr2(Instruction[24:20]), .Write_addr(Write_addrW), .Read_data1(Read_data1D), .Read_data2(Read_data2D));

sign_extend S1(.Instruction(Instruction), .ImmSrc(ImmSrcD), .Immediate_value(Immediate_valueD));


always@(posedge clk or posedge rst)
begin
    if(rst==1'b1)
    begin
        Immediate_valueE <= 32'h00000000;
        Read_data1E <= 32'h00000000;
        Read_data2E <= 32'h00000000;
        PCE <= 32'h00000000;
        PCplus4E <= 32'h00000000;
        branchE <= 1'b0;
        jumpE <= 1'b0;
        ALUsrcE <= 1'b0;
        MemwriteE <= 1'b0;
        RegwriteE <= 1'b0;
        MuxsignE <= 1'b0;
        MUXWDMemwriteE <= 1'b0;
        ResultsrcE <= 3'b000;
        SignExME <= 2'b00;
        ALUcontrolE <= 4'b0000;
        RDE <= 5'b00000;
        Memory_selectorE <= 1'b0;
        Reg_Source1 <= 5'b00000;
        Reg_Source2 <= 5'b00000;
    end

    else
    begin
        Immediate_valueE <= Immediate_valueD;
        Read_data1E <= Read_data1D;
        Read_data2E <= Read_data2D;
        PCE <= PCD;
        PCplus4E <= PCplus4D;
        branchE <= branchD;
        jumpE <= jumpD;
        ALUsrcE <= ALUsrcD;
        MemwriteE <= MemwriteD;
        RegwriteE <= RegwriteD;
        MuxsignE <= MuxsignD;
        MUXWDMemwriteE <= MUXWDMemwriteD;
        ResultsrcE <= ResultsrcD;
        SignExME <= SignExMD;
        ALUcontrolE <= ALUcontrolD;
        RDE <= Instruction[11:7];
        Memory_selectorE <=Memory_selector; 
        Reg_Source1 <= Instruction[19:15];
        Reg_Source2 <= Instruction[24:20];
    end
end        

endmodule