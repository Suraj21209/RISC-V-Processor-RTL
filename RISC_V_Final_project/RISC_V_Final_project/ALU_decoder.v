module alu_decoder(ALUop, funct3, opcode5, funct76, ALUcontrol);
input [2:0]ALUop, funct3;
input opcode5, funct76;
output [3:0]ALUcontrol;
assign ALUcontrol = ((ALUop == 3'b001)&&(funct3 == 3'b000)) ? 4'b0001 :
                    ((ALUop == 3'b001)&&(funct3 == 3'b001)) ? 4'b1110 :
                    ((ALUop == 3'b001)&&(funct3 == 3'b100)) ? 4'b0010 :
                    ((ALUop == 3'b001)&&(funct3 == 3'b101)) ? 4'b0011 :
                    ((ALUop == 3'b001)&&(funct3 == 3'b110)) ? 4'b0101 :
                    ((ALUop == 3'b001)&&(funct3 == 3'b111)) ? 4'b0100 :
                    (ALUop == 3'b010) ? 4'b0110 :
                    ((ALUop == 3'b011)&&(funct3 == 3'b000)) ? 4'b0110 :
                    ((ALUop == 3'b011)&&(funct3 == 3'b001)&&(opcode5 == 1'b0)) ? 4'b0110 :
                    ((ALUop == 3'b011)&&(funct3 == 3'b010)&&(opcode5 == 1'b0)) ? 4'b0110 :
                    ((ALUop == 3'b011)&&(funct3 == 3'b010)&&(opcode5 == 1'b1)) ? 4'b0010 :
                    ((ALUop == 3'b011)&&(funct3 == 3'b100)&&(opcode5 == 1'b0)) ? 4'b0110 :
                    ((ALUop == 3'b011)&&(funct3 == 3'b100)&&(opcode5 == 1'b1)) ? 4'b0111 :
                    ((ALUop == 3'b011)&&(funct3 == 3'b101)&&(opcode5 == 1'b0)) ? 4'b0110 :
                    ((ALUop == 3'b011)&&(funct3 == 3'b011)) ? 4'b0101 :
                    ((ALUop == 3'b011)&&(funct3 == 3'b110)) ? 4'b1000 :
                    ((ALUop == 3'b011)&&(funct3 == 3'b111)) ? 4'b1001 :
                    ((ALUop == 3'b100)&&(funct3 == 3'b001)) ? 4'b1010 :
                    ((ALUop == 3'b100)&&(funct3 == 3'b101)&&(opcode5 == 1'b1)&&(funct76 == 1'b0)) ? 4'b1011 :
                    ((ALUop == 3'b100)&&(funct3 == 3'b101)&&(opcode5 == 1'b1)&&(funct76 == 1'b1)) ? 4'b1100 :
                    ((ALUop == 3'b011)&&(funct3 == 3'b101)&&(opcode5 == 1'b1)&&(funct76 == 1'b0)) ? 4'b1011 :
                    ((ALUop == 3'b011)&&(funct3 == 3'b101)&&(opcode5 == 1'b1)&&(funct76 == 1'b1)) ? 4'b1100 :
                    ((ALUop == 3'b100)&&(funct3 == 3'b000)&&(opcode5 == 1'b1)&&(funct76 == 1'b0)) ? 4'b0110 :
                    ((ALUop == 3'b100)&&(funct3 == 3'b000)&&(opcode5 == 1'b1)&&(funct76 == 1'b1)) ? 4'b1101 :
                    ((ALUop == 3'b100)&&(funct3 == 3'b010)) ? 4'b0010 :
                    ((ALUop == 3'b100)&&(funct3 == 3'b011)) ? 4'b0101 :
                    ((ALUop == 3'b100)&&(funct3 == 3'b100)) ? 4'b0111 :
                    ((ALUop == 3'b011)&&(funct3 == 3'b001)&&(opcode5 == 1'b1)) ? 4'b1010 :
                    ((ALUop == 3'b100)&&(funct3 == 3'b110)) ? 4'b1000 :
                    ((ALUop == 3'b100)&&(funct3 == 3'b111)) ? 4'b1001 : 4'b0000;



endmodule