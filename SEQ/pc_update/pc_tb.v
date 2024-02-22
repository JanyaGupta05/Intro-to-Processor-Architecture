`include "pc_update.v"
module testbench;

reg clk;
reg cnd;
reg [3:0] icode;
reg [63:0] ValP;
reg [63:0] ValC;
reg [63:0] ValM;
wire [63:0] newPc;

pc_update pc_update(clk,cnd,icode,ValP,ValC,ValM,newPc);

initial
begin

clk=0;
#10clk=~clk;//halt
icode=4'b0000;
#10clk=~clk;
icode=4'b0000;

#10clk=~clk;//jump taken
icode=4'b0111;
cnd=1;
ValP=10;
ValC=20;
#10clk=~clk;
icode=4'b0111;
cnd=1;
ValP=10;
ValC=20;

#10clk=~clk;//jump not taken
icode=4'b0111;
cnd=0;
ValP=12;
ValC=73;
#10clk=~clk;
icode=4'b0111;
cnd=0;
ValP=12;
ValC=73;

#10clk=~clk;//call
icode=4'b1000;
ValC=100;
#10clk=~clk;
icode=4'b1000;
ValC=100;

#10clk=~clk;//return
icode=4'b1001;
ValM=95;
#10clk=~clk;
icode=4'b1001;
ValM=95;

#10clk=~clk;//base case
icode=4'b0101;
ValP=25;
ValC=37;
ValM=19;

#10clk=~clk;
icode=4'b0101;
ValP=25;
ValC=37;
ValM=19;




















end
initial
begin
$monitor("newPc = %d",newPc);
end

endmodule








