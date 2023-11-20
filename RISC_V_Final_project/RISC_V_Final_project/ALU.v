module alu(
    input [31:0]In1,In2,
    input [3:0]ALU_CTRL,
    output reg Greater,Greater_Unsigned,Less,Less_Unsigned,Equal,Overflow,Carry,Negative,
    output wire Zero,
    output reg [31:0]Out);
    reg [31:0]Sum;
    reg [31:0]ShiftRight,ShiftRighta,ShiftLeft;
    wire signed [31:0] In1_signed ;
    wire signed [31:0] In2_signed ;
    assign Zero = &(~Out);
    assign In1_signed = $signed(In1);
    assign In2_signed = $signed(In2);
    always @(*) begin
        Sum = In1 + In2;
        Overflow = (In1[31]&In2[31]&(~Sum[31])) | ((~In1[31])&(~In2[31])&Sum[31]);
        //Zero = &(~Out);
        Negative = Out[31];
        ShiftRight = In1>>In2;
        ShiftRighta = In1_signed>>>In2_signed;
        ShiftLeft = In1<<In2;
        Less =0;
        Greater=0;
        Greater_Unsigned=0;
        Less_Unsigned =0;
        Equal=0;
        //pow = (2**In2 - 1)*(2**(32-In2));
        case (ALU_CTRL)
           4'b0001 : Out = (In1 - In2);
        //     if(In1==In2)
        //     Zero = 1;
        //     else
        //     Zero = 0;
        //    end
           4'b0010 : begin Less = (In1_signed < In2_signed);
                Out=Less;
           end
           4'b0011 : begin
            Greater = (In1_signed >= In2_signed);
           Out=Greater;
           end
           4'b0100 : begin Greater_Unsigned = (In1 >= In2);
           Out=Greater_Unsigned;
           end
           4'b0101 : begin Less_Unsigned = (In1 < In2);
           Out=Less_Unsigned;
           end
           4'b0110 : {Carry,Out}=In1 + In2;
           4'b0111 : {Carry,Out}={{1'b0},{In1 ^ In2}};
           4'b1000 : {Carry,Out}={{1'b0},{In1 | In2}};
           4'b1001 : {Carry,Out}={{1'b0},{In1 & In2}};
           4'b1010 : {Carry,Out}={{1'b0},ShiftLeft};
           4'b1011 : {Carry,Out}={{1'b0},ShiftRight};
           4'b1100 : {Carry,Out}={{1'b0},ShiftRighta};
           4'b1101 : {Carry,Out}=In1 + ((~In2)+1);
           4'b1110 : Equal = (In1 != In2);
        default: {Carry,Out}={33{1'b0}};
        endcase
    end
endmodule