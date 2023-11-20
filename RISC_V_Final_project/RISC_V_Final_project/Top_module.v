`include "Mux.v"
`include "PC.v"
`include "PC_adder.v"
`include "Instruction_Memory.v"
`include "Data_Memory.v"
`include "Sign_extenddecode.v"
`include "Register_file.v"
`include "Main_Decoder.v"
`include "ALU_decoder.v"
`include "ALU.v"
`include "Sign_extendmemory.v"
`include "Execute_Cycle.v"
`include "Decode_cycle.v"
`include "Memory_stage.v"
`include "Writeback.v"
`include "Fetch_Cycle.v"
`include "Memory_map.v"
`include "Hazard_unit.v"
`include "fsm_for_branch_prediction.v"
module riscV_pipeline(clk,rst);
input clk,rst;

wire PC_selectorE, RegwriteW, branchE, jumpE, ALUsrcE, MemWriteE, RegWriteE, MuxsignE, MUXWDMemwriteE, MemWriteM,
RegWriteM, MuxsignM, MUXWDMemwriteM, Memory_selectorE, Memory_selectorM, prediction;

wire [31:0]PC_plusoffsetE, InstructionD, PCD, PC_plus4D, DataW, Immediate_valueE, Read_data1E, Read_data2E,
PCE, PCplus4E, ALU_ResultM, WriteDataM, PCPlus4M, Immediate_valueM, PC_plusoffsetM, AluResultW, ReadDataW, PCPlus4W,
Immediate_valueW, PCPlus_offsetW;

wire [4:0] RDW, RDE, RDM, Reg_Source1, Reg_Source2;

wire [2:0] ResultSrcE, ResultSrcM, Result_SrcW;

wire [1:0] SignExME, SignExM, Hazardmux_sel2, Hazardmux_sel1;

wire [3:0] ALUcontrolE;
wire prediction_result;


fetch_cycle fetch(.clk(clk), .rst(rst), .PC_Sel(PC_selectorE), .PC_branch(PC_plusoffsetE), .InstrD(InstructionD), .PCD(PCD), .PCNextD(PC_plus4D));

decode_stage decode(.clk(clk), .rst(rst), .PCSrcE(PC_selectorE), .InstructionD(InstructionD), .Write_EnaW(RegwriteW), .Write_DataW(DataW), .Write_addrW(RDW),
.PCD(PCD), .PCplus4D(PC_plus4D), .Immediate_valueE(Immediate_valueE), .Read_data1E(Read_data1E), .Read_data2E(Read_data2E), 
.branchE(branchE), .jumpE(jumpE), .ALUsrcE(ALUsrcE), .ResultsrcE(ResultSrcE), .MemwriteE(MemWriteE), .RegwriteE(RegWriteE),
.SignExME(SignExME), .MuxsignE(MuxsignE), .MUXWDMemwriteE(MUXWDMemwriteE), .ALUcontrolE(ALUcontrolE), .PCE(PCE), .PCplus4E(PCplus4E), .RDE(RDE)
, .Memory_selectorE(Memory_selectorE), .Reg_Source1(Reg_Source1), .Reg_Source2(Reg_Source2));




execute_cycle execute(.clk(clk), .rst(rst), .Hazardmux_sel1(Hazardmux_sel1), .Hazardmux_sel2(Hazardmux_sel2),
.Result_writeback(DataW),.Memory_selectorE(Memory_selectorE), .RegWriteE(RegWriteE), .ALUSrcE(ALUsrcE), .AluResultM(ALU_ResultM),
.MemWriteE(MemWriteE), .ResultSrcE(ResultSrcE),
.BranchE(branchE), .jumpE(jumpE), .ALUControlE(ALUcontrolE), .SignExME(SignExME), .MuxsignE(MuxsignE), .MUXWDMemwriteE(MUXWDMemwriteE),
.RD1_E(Read_data1E), .RD2_E(Read_data2E), .Imm_Ext_E(Immediate_valueE), .RD_E(RDE), .PCE(PCE), .PCPlus4E(PCplus4E), 
.PCSrcE(PC_selectorE), .PCTargetE(PC_plusoffsetE), .RegWriteM(RegWriteM), .MemWriteM(MemWriteM), .ResultSrcM(ResultSrcM),
.RD_M(RDM), .PCPlus4M(PCPlus4M), .WriteDataM(WriteDataM), .ALU_ResultM(ALU_ResultM),
.SignExM(SignExM), .MuxsignM(MuxsignM), .MUXWDMemwriteM(MUXWDMemwriteM), .Immediate_valueM(Immediate_valueM), 
.Memory_selectorM(Memory_selectorM), .PCPlus_offsetM(PC_plusoffsetM));

Hazard_unit hazard( .clk(clk), 
.rst(rst), .RegWriteM(RegWriteM), .RegWriteW(RegwriteW), .Reg_Source1(Reg_Source1), .Reg_Source2(Reg_Source2), .RD_M(RDM), .Hazardmux_sel1(Hazardmux_sel1), 
.Hazardmux_sel2(Hazardmux_sel2), .RD_W(RDW));

memory_stage memory(.clk(clk), .rst(rst), .MemwriteM(MemWriteM), .Memory_selectorM(Memory_selectorM), .RegwriteM(RegWriteM), .MuxsignM(MuxsignM),
.Mux_WD_memwriteM(MUXWDMemwriteM), .Writedata_M(WriteDataM), .PCPlus4M(PCPlus4M), .AluResultM(ALU_ResultM),
.Immediate_valueM(Immediate_valueM), .PCPlus_offsetM(PC_plusoffsetM), .RDM(RDM), .Result_SrcM(ResultSrcM), 
.SignEXM(SignExM), .RegwriteW(RegwriteW), .Result_SrcW(Result_SrcW), .AluResultW(AluResultW), .ReadDataW(ReadDataW),
.PCPlus4W(PCPlus4W), .Immediate_valueW(Immediate_valueW), .PCPlus_offsetW(PCPlus_offsetW), .RDW(RDW));

Writeback writeback(.Result_SrcW(Result_SrcW), .AluResultW(AluResultW), .ReadDataW(ReadDataW),
.PCPlus4W(PCPlus4W), .Immediate_valueW(Immediate_valueW), .PCPlus_offsetW(PCPlus_offsetW), .Result_writeback(DataW));

branchpredictor branch( .clk(clk), .rst(rst), .PCSrC(PC_selectorE), .branch(branchE), .prediction(prediction));
assign prediction_result = ~(prediction ^ PC_selectorE);





endmodule