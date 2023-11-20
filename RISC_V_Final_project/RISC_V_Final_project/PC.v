
module PC_Module(clk,rst,PC_Next,PC);
    input clk,rst;
    input [31:0]PC_Next;
    output reg[31:0]PC;
    

    always @(posedge clk)
    begin
        if(rst == 1'b1)
            PC <= {32{1'b0}};
        else
            PC <= PC_Next;
    end
endmodule

