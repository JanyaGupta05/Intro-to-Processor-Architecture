`include "writeback.v"
module testbench;

    reg clk;
    reg [3:0] icode ;
    reg cnd; 
    reg [3:0] rA; 
    reg [3:0] rB; 
    reg [63:0] ValE;
    reg [63:0] ValM;
    reg [63:0] rax;
    reg [63:0] rcx;
    reg [63:0] rdx;
    reg [63:0] rbx;
    reg [63:0] rsp;
    reg [63:0] rbp;
    reg [63:0] rsi;
    reg [63:0] rdi;
    reg [63:0] r8;
    reg [63:0] r9;
    reg [63:0] r10;
    reg [63:0] r11;
    reg [63:0] r12;
    reg [63:0] r13;
    reg [63:0] r14; 


    wire [63:0] reg0;
    wire [63:0] reg1;
    wire [63:0] reg2;
    wire [63:0] reg3;
    wire [63:0] reg4;
    wire [63:0] reg5;
    wire [63:0] reg6;
    wire [63:0] reg7;
    wire [63:0] reg8;
    wire [63:0] reg9;
    wire [63:0] reg10;
    wire [63:0] reg11;
    wire [63:0] reg12;
    wire [63:0] reg13;
    wire [63:0] reg14;




   writeback writeback(clk,icode,cnd,rA,rB,ValE,ValM,rax,rcx,rdx,rbx,rsp,rbp,rsi,rdi,r8,r9,r10,r11,r12,r13,r14,reg0,reg1,reg2,reg3,reg4,reg5,reg6,reg7,reg8,reg9,reg10,reg11,reg12,reg13,reg14);
    

initial
begin
clk=1;
icode=4'b0011;//irmov
rB=4'b0011;
cnd=1;
ValE=20;


#10 clk=~clk;
icode=4'b0011;
rB=4'b0011;
cnd=1;
ValE=20;

#10 clk=~clk;
icode = 4'b0010;//cmov
rB = 4'b0000;
cnd = 1;
ValE = 12;

#10 clk=~clk;
icode = 4'b0010;
rB = 4'b0000;
cnd = 1;
ValE = 12;

#10clk=~clk;//mrmov
icode=4'b0101;
rA=4'b0010;
ValM=64'd15;

#10clk=~clk;
icode=4'b0101;
rA=4'b0010;
ValM=64'd15;

#10clk=~clk;//op
icode=4'b0110;
rB=4'b0001;
ValE=64'd78;

#10clk=~clk;
icode=4'b0110;
rB=4'b0001;
ValE=64'd78;


#10clk=~clk;//call also works same for push
icode=4'b1000;
ValE=64'd90;

#10clk=~clk;
icode=4'b1000;
ValE=64'd90;

#10clk=~clk;//ret
icode=4'b1001;
ValE=64'd84;

#10clk=~clk;
icode=4'b1001;
ValE=64'd84;

#10clk=~clk;//pop
icode=4'b1011;
ValE=64'd99;
ValM=64'd100;
rA=4'b101;

#10clk=~clk;
icode=4'b1011;
ValE=64'd99;
ValM=64'd100;
rA=4'b101;




















// icode=4'b0010;
// rB=4'b0111;
// cnd=1;
// ValE=20;


// #10 clk=~clk;
// icode=4'b0010;
// rA=4'b0001;
// rB=4'b0010;
// cnd=1;
// ValE=20;


end
always @(*)
begin
    rax=reg0;
    rcx=reg1;
    rdx=reg2;
    rbx=reg3;
    rsp=reg4;
    rbp=reg5;
    rsi=reg6;
    rdi=reg7;
    r8=reg8;
    r9=reg9;
    r10=reg10;
    r11=reg11;
    r12=reg12;
    r13=reg13;
    r14=reg14;
end


initial
begin
$monitor("rax=%drcx=%drdx=%drbx=%drsp=%drbp=%d",reg0,reg1,reg2,reg3,reg4,reg5);
end


endmodule