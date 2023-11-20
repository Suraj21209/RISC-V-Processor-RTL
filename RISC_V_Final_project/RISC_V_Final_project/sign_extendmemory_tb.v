//`include "Sign_extendmemory.v"
module sign_extendmemory_tb();
reg [31:0]data_from_execute;
reg [1:0]SignEXM;
wire [31:0]output_data;
sign_extendmemory tb0(.data_from_execute(data_from_execute), .SignEXM(SignEXM), .output_data(output_data));
//initial
//begin
//$dumpfile("extendmemory.vcd");
//$dumpvars(0);
//end
initial
begin
	SignEXM = 2'b00; data_from_execute = 32'h0;
	#5 SignEXM = 2'b00; data_from_execute = 32'h0000_00A0;
	//#5 SignEXM = 2'b00; data_from_execute = 32'h0000_0404;
	#5 SignEXM = 2'b01; data_from_execute = 32'h0000_F000;
	#5 SignEXM = 2'b10; data_from_execute = 32'hFFFF_FFFF;
	#5 SignEXM = 2'b11; data_from_execute = 32'hFFFF_0000;	
end
endmodule
