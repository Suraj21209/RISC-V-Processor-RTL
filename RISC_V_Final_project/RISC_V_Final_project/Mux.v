
module Mux (I0,I1,s,out);

    input [31:0]I0,I1;
    input s;
    output [31:0]out;

    assign out = (~s) ? I0 : I1 ;
    
endmodule

module Mux3x1(I0,I1, I2, I3, s,out);

    input [31:0]I0,I1, I2, I3;
    input [1:0]s;
    output [31:0]out;

    assign out = (s == 2'b00) ? I0 : 
                 (s == 2'b01) ? I1 :
                 (s == 2'b10) ? I2 : 
                 (s == 2'b11) ? I3 : 32'd0;
    
endmodule


module Mux_5x1(I0,I1,I2,I3,I4,s,out);
    
    input [31:0]I0,I1,I2,I3,I4;
    input [2:0]s;
    output [31:0]out;
    assign out=(s==3'b001)?I0:
    	       (s==3'b010)?I1:
    	       (s==3'b011)?I2:
    	       (s==3'b100)?I3:
    	       (s==3'b101)?I4:32'd0;
endmodule
    	       	
module Demux (input In, input sel, output out1, output out2);

assign out1 = (~sel) ? In : 1'b0;
assign out2 = (sel) ? In : 1'b0;    
endmodule