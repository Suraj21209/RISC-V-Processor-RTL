module Data_Memory(clk,rst,Ena,Data_in,Address,Data_out);
    input clk,rst,Ena;
    input[31:0] Data_in,Address;
    output reg [31:0] Data_out;
    reg [31:0] mem [1023:0];
   
    always@(*)
    begin
        if(rst)
        Data_out<=32'h00000000;
        else if(Ena)
        mem[Address]<=Data_in;
        else
        Data_out<=mem[Address];
    end
    
    initial begin
        mem[0]=32'h00000000;
        mem[1]= 32'd2;
        mem[2] = 32'd3;
        mem[3] = 32'hFFFFFFFD;
        mem[4] = 32'hFFFFFFFE;
        mem[5] = 32'h00004000;
        mem[6] = 32'd45;
    end

endmodule