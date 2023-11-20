module memory_map(

    input clk,rst,Write_Ena,
    input [31:0]Write_addr,
    input [31:0]Write_data);

    reg [31:0] Register [4:0];
    reg [1:0] Write_Addr_MM;
    //initial begin
    //    Register[0] = 32'h00000000;
    //end
	
    always @ (posedge clk)
    begin
        case(Write_addr)
        32'h00004000: Write_Addr_MM = 0;
        32'h00004004: Write_Addr_MM = 1;
        32'h00004008: Write_Addr_MM = 2;
        32'h0000400C: Write_Addr_MM = 3;
        32'h00004010: Write_Addr_MM = 4;

        endcase
        if(Write_Ena )
            Register[Write_Addr_MM] <= Write_data;
    end

    //assign Read_data1 = (rst==1'b1) ? 32'd0 : Register[Read_addr1];
    //assign Read_data2 = (rst==1'b1) ? 32'd0 : Register[Read_addr2];

 
endmodule