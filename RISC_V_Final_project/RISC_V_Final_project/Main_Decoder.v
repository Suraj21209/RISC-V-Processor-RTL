module main_decoder(
input [6:0]opcode,
input [2:0]funct3,
output branch, jump, ALUsrc, Memwrite, Regwrite, MuxsignD, MUXWDMemwrite, Memory_selector,
output [1:0]SignEXM,
output [2:0]ALUop, Resultsrc, ImmSrc);

assign branch = (opcode == 7'b1100011) ? 1'b1 : 1'b0;
assign jump = (opcode == 7'b1101111) ? 1'b1 : 1'b0;
assign ALUsrc = ((opcode == 7'b0010011)|(opcode == 7'b0000011)|(opcode == 7'b0100011)) ? 1'b1 : 1'b0;
assign ALUop = (opcode == 7'b0110011) ? 3'b100 :
               ((opcode == 7'b0010011)|(opcode == 7'b0000011)) ? 3'b011 :
               (opcode == 7'b0100011) ? 3'b010 :
               (opcode == 7'b1100011) ? 3'b001 : 3'b000;
assign Resultsrc = ((opcode == 7'b0010011)|(opcode == 7'b0110011)) ? 3'b001 :
                   (opcode == 7'b0000011) ? 3'b010 :
                   (opcode == 7'b0110111) ? 3'b011 :
                   (opcode == 7'b0010111) ? 3'b100 :
                   (opcode == 7'b1101111) ? 3'b101 : 3'b000;
assign Memwrite = (opcode == 7'b0100011) ? 1'b1 : 1'b0;
assign Regwrite = ((opcode == 7'b0110011)|(opcode == 7'b0010011)|(opcode == 7'b0000011)|(opcode == 7'b0110111)|(opcode == 7'b0010111)|(opcode == 7'b1101111)) ? 1'b1 : 1'b0;
assign ImmSrc = (opcode == 7'b0110011) ? 3'b000 :
                ((opcode == 7'b0010011)&&((funct3 == 3'b001)|(funct3 == 3'b101))) ? 3'b110 :
                ((opcode == 7'b0010011)&&((funct3 == 3'b000)|(funct3 == 3'b010)|(funct3 == 3'b011)|(funct3 == 3'b100)|(funct3 == 3'b110)|(funct3 == 3'b111))) ? 3'b101:
                (opcode == 7'b0000011) ? 3'b101 :
                (opcode == 7'b0100011) ? 3'b100 :
                (opcode == 7'b1100011) ? 3'b011 :
                ((opcode == 7'b0110111)|(opcode == 7'b0010111)) ? 3'b001 :
                (opcode == 7'b1101111) ? 3'b010 : 3'b000;
assign SignEXM = ((opcode == 7'b0000011)&&(funct3 == 3'b000)) ? 2'b00 :
                 ((opcode == 7'b0000011)&&(funct3 == 3'b001)) ? 2'b01 :
                 (((opcode == 7'b0000011)&&(funct3 == 3'b100))|((opcode == 7'b0100011)&&(funct3 == 3'b000))) ? 2'b10 :
                 (((opcode == 7'b0000011)&&(funct3 == 3'b101))|((opcode == 7'b0100011)&&(funct3 == 3'b001))) ? 2'b11 : 2'b00;
assign MuxsignD = ((opcode == 7'b0000011)&&((funct3 == 3'b000)|(funct3 == 3'b001)|(funct3 == 3'b100)|(funct3 == 3'b101))) ? 1'b1 : 1'b0;
assign MUXWDMemwrite = ((opcode == 7'b0100011)&&((funct3 == 3'b000)|(funct3 == 3'b001))) ? 1'b1 : 1'b0;
assign Memory_selector = ((opcode == 7'b0100011)&&((funct3 == 3'b011)|(funct3 == 3'b100))) ? 1'b0 : 1'b1;

endmodule