module testbench();


reg clk = 0, rst;
riscV_pipeline DUT(.clk(clk), .rst(rst));
always
begin
#5 clk = ~clk;    
end

initial 
begin
rst <= 1'b1;
#5 rst <=1'b0;
#600;
$finish;    
end

initial
begin
    $dumpfile("dump.vcd");
    $dumpvars(0);
end

endmodule