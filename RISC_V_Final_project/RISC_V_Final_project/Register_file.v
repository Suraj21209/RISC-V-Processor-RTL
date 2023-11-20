module Register_File(

    input clk,rst,Write_Ena,
    input [4:0]Read_addr1,Read_addr2,Write_addr,
    input [31:0]Write_data,
    output [31:0]Read_data1,Read_data2);

    reg [31:0] Register [31:0];
    
    initial begin
        Register[0] = 32'h00000000;
        Register[29] = 32'h00004010;
        Register[30] = 32'h00000001;
    end
	
    always @ (posedge clk)
    begin
        if(Write_Ena & (Write_addr != 5'h00))
            Register[Write_addr] <= Write_data;
    end

    assign Read_data1 = (rst==1'b1) ? 32'd0 : Register[Read_addr1];
    assign Read_data2 = (rst==1'b1) ? 32'd0 : Register[Read_addr2];

 
endmodule
