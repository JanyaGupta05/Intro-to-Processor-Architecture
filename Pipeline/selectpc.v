module selectpc(input clk, input [63:0] F_predPC ,input M_cnd ,input [63:0] M_valA , input [63:0] W_valM , input [3:0] M_icode, input [3:0] W_icode 
, output reg [63:0] newPc );

always @(*)
begin
if(M_icode== 4'd7 && M_cnd==0)
    begin
        newPc= M_valA;
    end
    else if(W_icode== 4'd9)
    begin
        newPc= W_valM;
    end
    else
    begin
        newPc= F_predPC;
    end
end
endmodule
