module branchpredictor(input clk, input rst, input branch, input PCSrC, output reg prediction);
reg [1:0] present_state, next_state;
parameter SNT = 2'b00, WNT = 2'b01, WT = 2'b10, ST = 2'b11;


always @(posedge clk or posedge rst)
    begin
        if(rst == 1)
            present_state <= SNT; // Initialized to SNT
        else if (branch)
            present_state <= next_state; 
        else 
            present_state <= present_state;
    end

always @(*)
    begin
        case(present_state)
            SNT: if(PCSrC)
                    next_state <= WNT;
                 else
                    next_state <= SNT;
            WNT: if(PCSrC)
                    next_state <= WT;
                 else
                    next_state <= SNT;
            WT: if(PCSrC)
                    next_state <= ST;
                 else
                    next_state <= WNT;
            ST: if(PCSrC)
                    next_state <= ST;
                 else
                    next_state <= WT;
            default next_state <= SNT;
        endcase
    end

always @(*)
    begin
        if((present_state == SNT) || (present_state == WNT))
            prediction = 0;
        else
            prediction = 1;
    end


endmodule