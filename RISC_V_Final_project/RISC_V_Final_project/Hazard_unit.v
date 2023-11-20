module Hazard_unit(
input clk, rst, RegWriteM, RegWriteW,
input [4:0] Reg_Source1, Reg_Source2, RD_M, RD_W ,
output [1:0] Hazardmux_sel1, Hazardmux_sel2); // Added clk, 

reg RegWriteWnew;
reg [4:0] RD_Wnew;

always @(posedge clk or posedge rst)
    begin
        if (rst) begin
            RD_Wnew <= 5'b00000;
            RegWriteWnew <= 1'b0;
        end

        else begin
            RD_Wnew <= RD_W;
            RegWriteWnew <= RegWriteW;
        end
         
    end

assign Hazardmux_sel1 = (rst == 1'b1) ? 2'b00 :
                        ((RegWriteM == 1'b1)&&(RD_M == Reg_Source1)) ? 2'b01 :
                        ((RegWriteW == 1'b1)&&(RD_W == Reg_Source1)) ? 2'b10 : 
                        ((RegWriteWnew == 1'b1) && (RD_Wnew == Reg_Source1)) ? 2'b11 : 2'b00; 

assign Hazardmux_sel2 = (rst == 1) ? 2'b00 :
                        ((RegWriteM == 1'b1)&&(RD_M == Reg_Source2)) ? 2'b01 :
                        ((RegWriteW == 1'b1)&&(RD_W == Reg_Source2)) ? 2'b10 :
                        ((RegWriteWnew == 1'b1) && (RD_Wnew == Reg_Source2)) ? 2'b11 : 2'b00;





endmodule