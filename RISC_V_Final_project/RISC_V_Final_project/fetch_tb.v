//`include "Fetch_Cycle.v"
module fetch_tb();
reg clk=1,rst,PC_Sel;
reg [31:0] PC_branch;
wire [31:0] InstrD,PCD,PCNextD;
fetch_cycle dut(.clk(clk),.rst(rst),.PC_Sel(PC_Sel),.PC_branch(PC_branch),.InstrD(InstrD),.PCD(PCD),.PCNextD(PCNextD));
initial
begin
$dumpfile("dump.vcd");
$dumpvars(0);
end
always begin
clk=~clk;
#50;
end
initial 
begin
rst<=1'b1;
#100;
rst<=1'b0;
PC_Sel<=1'b0;
PC_branch<=32'd0;
#500;
$finish;
end
endmodule
