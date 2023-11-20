module sign_extendmemory(data_from_execute, SignEXM,output_data);
input [31:0]data_from_execute;
input [1:0]SignEXM;
output [31:0]output_data;

assign output_data = (SignEXM == 2'b00) ? {{24{data_from_execute[7]}}, data_from_execute[7:0]} :
                     (SignEXM == 2'b01) ? {{16{data_from_execute[15]}}, data_from_execute[15:0]} :
                     (SignEXM == 2'b10) ? {{24{1'b0}}, data_from_execute[7:0]} :
                     (SignEXM == 2'b11) ? {{16{1'b0}}, data_from_execute[15:0]}: 32'h00000000;
endmodule