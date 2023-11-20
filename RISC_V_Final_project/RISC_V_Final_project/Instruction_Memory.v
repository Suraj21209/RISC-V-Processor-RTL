
module Instruction_Memory(rst,Address,Data);

  input rst;
  input [31:0]Address;
  output [31:0]Data;

  reg [31:0] mem [1023:0];
  
  assign Data = (rst == 1'b1) ? {32{1'b0}} : mem[Address[31:2]];

  initial begin
    $readmemh("memfile.hex",mem);
  end

endmodule

