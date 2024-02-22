
`include "fetch.v"
`include "decode.v"
`include "execute.v"
`include "memory.v"
`include "writeback.v"
`include "pc_update.v"
module finalmodule;
    reg clk;
    reg [63:0]pc;

    wire[3:0]icode;
    wire[3:0]ifun;
    wire[3:0]rA;
    wire[3:0]rB;
    wire signed [63:0]valC;
    wire [63:0]valP;
    wire ins_address;
    wire adr_address;
    wire hlt;
    wire signed [63:0]valA;
    wire signed [63:0]valB;
    wire signed [63:0]valE;
    wire cnd;
    wire zf;
    wire sf;
    wire of;
    wire signed [63:0]valM;
    wire adr_memory;
    wire signed [63:0]data;
    wire[63:0]newPc;

    reg AOK;
    reg HLT;
    reg ADR;
    reg INS;

    reg signed [63:0] rax;
    reg signed [63:0] rcx;
    reg signed [63:0] rdx;
    reg signed [63:0] rbx;
    reg signed [63:0] rsp;
    reg signed [63:0] rbp;
    reg signed [63:0] rsi;
    reg signed [63:0] rdi;
    reg signed [63:0] r8;
    reg signed [63:0] r9;
    reg signed [63:0] r10;
    reg signed [63:0] r11;
    reg signed [63:0] r12;
    reg signed [63:0] r13;
    reg signed [63:0] r14; 


    wire signed [63:0] reg0;
    wire signed [63:0] reg1;
    wire signed [63:0] reg2;
    wire signed [63:0] reg3;
    wire signed [63:0] reg4;
    wire signed [63:0] reg5;
    wire signed [63:0] reg6;
    wire signed [63:0] reg7;
    wire signed [63:0] reg8;
    wire signed [63:0] reg9;
    wire signed [63:0] reg10;
    wire signed [63:0] reg11;
    wire signed [63:0] reg12;
    wire signed [63:0] reg13;
    wire signed [63:0] reg14;

    fetchmodule fetchmodule1(clk,pc,icode,ifun,rA,rB,valC,valP,ins_address,hlt,adr_address);
    decodemodule decodemodule1(clk,rA,rB,icode,rax,rcx,rdx,rbx,rsp,rbp,rsi,rdi,r8,r9,r10,r11,r12,r13,r14, valA,valB);
    execute execute1(clk,icode,ifun,valA,valB,valC,valE,cnd,zf,sf,of);
    memory memory1(clk,icode ,valA, valE,valP,data ,valM,adr_memory);
    writeback writeback1(clk,icode,cnd,rA,rB,valE,valM,rax,rcx,rdx,rbx,rsp,rbp,rsi,rdi,r8,r9,r10,r11,r12,r13,r14,reg0,reg1,reg2,reg3,reg4,reg5,reg6,reg7,reg8,reg9,reg10,reg11,reg12,reg13,reg14);
    pc_update pc_update1(clk,cnd,icode,valP,valC,valM,newPc);

    initial 
    begin
      pc=0;
      AOK=1;
      HLT=0;
      ADR=0;
      INS=0;
      clk=1;
      rsp=8192;
    end
     always #5 clk=~clk;
    always @*
    begin
        if(hlt==1)
        begin
            HLT=1'b1;
            AOK=1'b0;
            #1 $finish;
        end
        if(adr_address==1)
        begin
            AOK= 1'b0;
            ADR= 1'b1;
            $finish;
        end
        if(ins_address==1)
        begin
            INS= 1'b1;
            AOK= 1'b0;
        end
    end
       
    always #10 pc=newPc;

   
   always @*
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
   $monitor("clk=%d\n icode=%difun=%d\nrA=%d rB=%d\n valC=%dvalP=%d\n ins_address=%d adr_address=%d hlt=%d\n valA=%d valB=%d \n valE=%d \n cnd=%d zf=%d sf=%d of=%d\n valM=%d data=%d adr_memory=%d\n newPc=%d \nAOK=%d HLT=%d ADR=%d INS=%d\nreg0=%d reg1=%d reg2=%d reg3=%d reg4=%d reg5=%d reg6=%d reg7=%d reg8=%d reg9=%d reg10=%d reg11=%d reg12=%d reg13=%d reg14=%d \n\n",clk,icode,ifun,rA,rB,valC,valP,ins_address,adr_address,hlt,valA,valB,valE,cnd,zf,sf,of,valM,data,adr_memory,newPc,AOK,HLT,ADR,INS,rax,rcx,rdx,rbx,rsp,rbp,rsi,rdi,r8,r9,r10,r11,r12,r13,r14);
   end
endmodule
