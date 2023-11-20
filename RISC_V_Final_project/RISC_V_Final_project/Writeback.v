// `include "Mux.v"
module Writeback(Result_SrcW, AluResultW, ReadDataW, PCPlus4W, Immediate_valueW, PCPlus_offsetW, Result_writeback);
input [2:0] Result_SrcW;
input [31:0] AluResultW,ReadDataW,PCPlus4W,Immediate_valueW,PCPlus_offsetW;

output [31:0]Result_writeback;
Mux_5x1 Mux_writeback(.I0(AluResultW),.I1(ReadDataW),.I2(Immediate_valueW),.I3(PCPlus_offsetW),.I4(PCPlus4W),.s(Result_SrcW),
.out(Result_writeback));



endmodule