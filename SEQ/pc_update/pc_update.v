module pc_update(input wire clk, input cnd, input [3:0] icode, input [63:0] ValP, input [63:0] ValC, input [63:0] ValM, output reg [63:0] newPc);

always @(*)
begin
    if (icode==4'b0000)//halt
    begin
        newPc = 0;
    end
    else if (icode==4'b0111)//jump
    begin
        if (cnd==1)
        begin
            newPc = ValC;
        end
        else
        begin
            newPc = ValP;
        end
    end
    else if (icode==4'b1000)//call
    begin
        newPc = ValC;
    end
    else if (icode==4'b1001)//ret
    begin
        newPc = ValM;
    end
    else//base case
    begin 
        newPc = ValP;
    end

end
endmodule

