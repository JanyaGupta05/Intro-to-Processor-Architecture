`include "fetch.v"
`include "f.v"
`include "selectpc.v"
`include "decode.v"
`include "execute.v"
`include "memory.v"
`include "writeback.v"
`include "pipe_ctrl.v"
module final;

reg clk;
reg [63:0] pc;

wire F_stall;
wire [63:0] F_predPC ,f_pc , newPc;

wire D_stall,D_bubble;
wire [1:0] D_stat;
wire [3:0] D_icode,D_ifun,D_rA,D_rB,d_srcA,d_srcB;
wire [63:0] D_valC,D_valP,d_valA,d_valB;

reg [63:0] rax, rcx, rdx, rbx, rsp, rbp ,rsi, rdi ,r8 ,r9 ,r10 ,r11 ,r12 ,r13 ,r14;


wire E_bubble,set_cc ,e_cnd;
wire [1:0] E_stat;
wire [3:0] E_icode, E_ifun , E_srcA, E_srcB, E_dstE ,E_dstM ,e_dstE;
wire [63:0] E_valA , E_valB ,E_valC, e_valE;

wire M_cnd;
wire [1:0] M_stat, m_stat;
wire [3:0] M_icode, M_ifun ,M_dstE ,M_dstM;
wire [63:0] M_valA, M_valE, m_valM ,data;

wire W_cnd;
wire [1:0] W_stat;
wire [3:0] W_icode , W_ifun , W_dstE, W_dstM;
wire [63:0] W_valE,W_valM;
wire [63:0] reg0,reg1,reg2,reg3,reg4,reg5,reg6,reg7,reg8,reg9,reg10,reg11,reg12,reg13,reg14;





freg f(clk,f_pc,F_predPC);

selectpc select(clk,F_predPC,M_cnd ,M_valA,W_valM,M_icode,W_icode,newPc);

fetchmodule fetch(clk,pc,M_cnd,M_valA,W_valM,F_stall,D_stall,D_bubble,M_icode,W_icode,f_pc,D_icode,D_ifun,D_rA,D_rB,D_valC,D_valP,D_stat);

decodemodule decode(clk,D_icode,D_ifun,D_rA,D_rB,D_valC,D_valP,D_stat,e_dstE,M_dstE,M_dstM,W_dstM,W_dstE,e_valE,M_valE,m_valM,W_valM,
W_valE,rax,rcx,rdx,rbx,rsp,rbp,rsi,rdi,r8,r9,r10,r11,r12,r13,r14,E_bubble,E_icode,E_ifun,E_valA,E_valB,E_valC,E_dstE,E_dstM,E_srcA,E_srcB,
E_stat,d_valA,d_valB,d_srcA,d_srcB);

execute exec(clk,E_icode,E_ifun,E_valA,E_valB ,E_valC ,E_dstE ,E_dstM ,E_stat ,set_cc,M_stat ,M_icode,M_ifun,
M_cnd ,M_valA ,M_valE ,M_dstE ,M_dstM , e_valE ,e_dstE ,e_cnd);

memory mem(clk ,M_stat ,M_icode,M_ifun ,M_cnd ,M_dstE,M_dstM,M_valA ,M_valE ,W_stat ,W_icode,W_ifun ,W_valE ,W_valM ,W_dstE ,W_dstM
,m_stat ,m_valM,data ,W_cnd);

writeback wb(clk , W_icode ,W_ifun , W_cnd ,W_dstM , W_dstE , W_valE , W_valM,m_stat,rax,rcx,rdx,rbx,rsp,rbp,rsi,rdi,r8,r9,r10,r11,r12,r13,
r14,W_stat,reg0,reg1,reg2,reg3,reg4,reg5,reg6,reg7,reg8,reg9,reg10,reg11,reg12,reg13,reg14);

pipe_logic pl(D_icode,d_srcA,d_srcB,E_icode, E_dstM,M_icode,m_stat,W_stat,e_cnd,
W_stall,M_bubble,set_cc,E_bubble, D_bubble,D_stall,F_stall);


always #10 clk=~clk;
initial
begin
rax=0;
rcx=0;
rdx=0;
rbx=0;
rsp=8192;
rbp=0;
rsi=0;
rdi=0;
r8=0;
r9=0;
r10=0;
r11=0;
r12=0;
r13=0;
r14=0;
end

always @(*)
begin
   pc = newPc;
end
initial
begin
$dumpfile("final.vcd");
$dumpvars(0,final);
pc = 0;
clk=0;
end

   always @(W_stat)
   begin
     if(W_stat==2'd1)
     begin
       $finish;
     end
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

always @*
   begin

//     $monitor("clk=%d\n icode=%difun=%d\nrA=%d rB=%d\n valC=%dvalP=%d\n ins_address=%d adr_address=%d hlt=%d\n valA=%d valB=%d \n valE=%d \n cnd=%d zf=%d sf=%d of=%d\n valM=%d data=%d \n newPc=%d \nAOK=%d HLT=%d ADR=%d INS=%d\nreg0=%d reg1=%d reg2=%d reg3=%d reg4=%d reg5=%d reg6=%d reg7=%d reg8=%d reg9=%d reg10=%d reg11=%d reg12=%d reg13=%d reg14=%d rax=%d rcx=%d rdx=%d rbx=%d rsp=%d rbp=%d rsi=%d rdi=%d r8=%d r9=%d r10=%d r11=%d r12=%d r13=%d r14=%d\n\n",clk,icode,ifun,rA,rB,valC,valP,ins_address,adr_address,hlt,valA,valB,valE,cnd,zf,sf,of,valM,data,newPc,AOK,HLT,ADR,INS, rax, rcx, rdx, rbx, rsp, rbp, rsi, rdi, r8,r9,r10,r11,r12,r13,r14);
//    end
   $monitor("time = %d , e_cnd = %d ,d_valA = %d, d_valB = %d , e_valE = %d , m_valM = %d , W_valM = %d ,W_valE =%d ,M_valE= %d, pc = %d reg0=%d reg1=%d reg2=%d reg3=%d reg4=%d reg5=%d reg6=%d reg7=%d reg8=%d reg9=%d reg10=%d reg11=%d reg12=%d reg13=%d reg14=%d \n\n",$time,e_cnd,d_valA,d_valB,e_valE,m_valM,W_dstM,W_valE,M_valE,pc,rax,rcx,rdx,rbx,rsp,rbp,rsi,rdi,r8,reg9,r10,r11,r12,r13,r14);
   end
endmodule




