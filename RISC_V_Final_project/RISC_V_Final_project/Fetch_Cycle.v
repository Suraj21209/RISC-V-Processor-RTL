// `include "Mux.v"
// `include "PC.v"
// `include "PC_adder.v"
// `include "Instruction_Memory.v"

module fetch_cycle(clk, rst, PC_Sel, PC_branch, InstrD, PCD, PCNextD);

    // Declare input & outputs
    input clk, rst;
    input PC_Sel;
    input [31:0] PC_branch;
    output reg [31:0] InstrD,PCD, PCNextD;
   

    // Declaring interim wires
    wire [31:0] PC_mux_out, PC_counter_out, PCPlus4F,InstrF;
    wire [31:0] Instruction;


    // Initiation of Modules
    // Declare PC Mux
    Mux PC_MUX (.I0(PCPlus4F),
                .I1(PC_branch),
                .s(PC_Sel),
                .out(PC_mux_out)
                );

    // Declare PC Counter
    PC_Module Program_Counter (
                .clk(clk),
                .rst(rst),
		.PC_Next(PC_mux_out),
                .PC(PC_counter_out)
                );

    // Declare Instruction Memory
    Instruction_Memory IMEM (
                .rst(rst),
                .Address(PC_counter_out),
                .Data(InstrF)
                );

    assign Instruction = (PC_Sel) ? 32'h00000033 : InstrF ;



    // Declare PC adder
    adder add_module(
                .a(PC_counter_out),
                .b(32'h00000004),
                .out(PCPlus4F)
                );

    // Fetch Cycle Register Logic
    always @(posedge clk or posedge rst) begin
        if(rst == 1'b1) begin
            InstrD <= 32'h00000000;
            PCD <= 32'h00000000;
            PCNextD <= 32'h00000000;
        end
        else begin
            InstrD <= Instruction;
            PCD <= PC_counter_out;
            PCNextD <= PCPlus4F;
        end
    end


endmodule
