module sign_extend(
input [31:0]Instruction,
input [2:0]ImmSrc,
output [31:0]Immediate_value);

assign Immediate_value = (ImmSrc == 3'b010) ? {{11{Instruction[31]}}, Instruction[31], Instruction[19:12], Instruction[20], Instruction[30:21], 1'b0} : 
                         (ImmSrc == 3'b001) ? {Instruction[31:12], {12{1'b0}} } :
                         (ImmSrc == 3'b011) ? {{19{Instruction[31]}}, Instruction[31], Instruction[7], Instruction[30:25], Instruction[11:8], 1'b0 } :
                         (ImmSrc == 3'b100) ? {{20{Instruction[31]}}, Instruction[31:25], Instruction[11:7] } :
                         (ImmSrc == 3'b101) ? {{20{Instruction[31]}}, Instruction[31:20] } : 
                         (ImmSrc == 3'b110) ? {{27{1'b0}}, Instruction[24:20]} : 32'h00000000;
                         
endmodule