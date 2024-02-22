`include "execute.v"
module testbench;

reg clk;
reg [3:0] icode;
reg [3:0] ifun;
reg [63:0] ValA;
reg [63:0] ValB;
reg [63:0] ValC;
wire[63:0] ValE;
wire zf;
wire sf;
wire of;
wire cnd;

execute execute(clk,icode,ifun,ValA,ValB,ValC,ValE,cnd,zf,sf,of);


initial
begin
clk=0;
icode=4'b0110;//sub
ifun=4'b0001;
ValA= 64'd91;
ValB= 64'd100;
#10 clk=~clk;
icode=4'b0110;
ifun=4'b0001;
ValA= 64'd0;
ValB= 64'd1;
#10 clk=~clk;//add
icode=4'b0110;
ifun=4'b0000;
ValA=-64'd4;
ValB= 64'd5;
#10 clk=~clk;
icode=4'b0110;
ifun=4'b0000;
ValA=-64'd4;
ValB= 64'd3;
#10clk=~clk;//and
icode=4'b0110;
ifun=4'b0010;
ValA=64'd10;
ValB=64'd7;
#10clk=~clk;
icode=4'b0110;
ifun=4'b0010;
ValA=64'd10;
ValB=64'd7;
#10clk=~clk;//xor
icode=4'b0110;
ifun=4'b0011;
ValA=64'd10;
ValB=64'd5;
#10clk=~clk;
icode=4'b0110;
ifun=4'b0011;
ValA=64'd10;
ValB=64'd5;

#10clk=~clk;//cmp(A-B)
icode=4'b0110;
ifun=4'b0001;
ValA=64'd100;
ValB=64'd102;
#10clk=~clk;
icode=4'b0110;
ifun=4'b0001;
ValA=64'd100;
ValB=64'd102;

#10clk=~clk;//cmovle
icode=4'b0010;
ifun=4'b0001;
ValA=64'd9;
#10clk=~clk;
icode=4'b0010;
ifun=4'b0001;
ValA=64'd9;

#10clk=~clk;//cmovge
icode=4'b0010;
ifun=4'b0101;
ValA=64'd7;
#10clk=~clk;
icode=4'b0010;
ifun=4'b0101;
ValA=64'd7;

#10clk=~clk;//cmp(A-B)
icode=4'b0110;
ifun=4'b0001;
ValA=64'd3;
ValB=64'd3;
#10clk=~clk;
icode=4'b0110;
ifun=4'b0001;
ValA=64'd3;
ValB=64'd3;

#10clk=~clk;//je
icode=4'b0111;
ifun=4'b0011;
#10clk=~clk;//je
icode=4'b0111;
ifun=4'b0011;

#10clk=~clk;//irmov
icode=4'b0011;
ValC=64'd20;
#10clk=~clk;
icode=4'b0011;
ValC=64'd20;

#10clk=~clk;//rmmov
icode=4'b0100;
ValB=64'd13;
ValC=64'd31;
#10clk=~clk;
icode=4'b0100;
ValB=64'd13;
ValC=64'd31;

#10clk=~clk;//mrmov
icode=4'b0101;
ValB=64'd90;
ValC=64'd18;
#10clk=~clk;
icode=4'b0101;
ValB=64'd90;
ValC=64'd18;

#10clk=~clk;//call ,works the same for pushq
icode=4'b1000;
ValB=64'd20;
#10clk=~clk;
icode=4'b1000;
ValB=64'd20;

#10clk=~clk;//ret , works the same for popq
icode=4'b1001;
ValB=64'd11;
#10clk=~clk;
icode=4'b1001;
ValB=64'd11;




















end

initial
begin
$monitor("valE =%d sf=%d zf=%d of=%d cnd = %d\n", ValE,sf,zf,of,cnd);
end
endmodule