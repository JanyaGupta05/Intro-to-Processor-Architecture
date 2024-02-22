module writeback(clk,icode,cnd,rA,rB,ValE,ValM,rax,rcx,rdx,rbx,rsp,rbp,rsi,rdi,r8,r9,r10,r11,r12,r13,r14,reg0,reg1,reg2,reg3,reg4,reg5,reg6,reg7,reg8,reg9,reg10,reg11,reg12,reg13,reg14);
    
    input clk;
    input [3:0] icode ;
    input cnd; 
    input [3:0] rA; 
    input [3:0] rB; 
    input [63:0] ValE;
    input [63:0] ValM;
    input [63:0] rax;
    input [63:0] rcx;
    input [63:0] rdx;
    input [63:0] rbx;
    input [63:0] rsp;
    input [63:0] rbp;
    input [63:0] rsi;
    input [63:0] rdi;
    input [63:0] r8;
    input [63:0] r9;
    input [63:0] r10;
    input [63:0] r11;
    input [63:0] r12;
    input [63:0] r13;
    input [63:0] r14; 

    output [63:0] reg0;
    output [63:0] reg1;
    output [63:0] reg2;
    output [63:0] reg3;
    output [63:0] reg4;
    output [63:0] reg5;
    output [63:0] reg6;
    output [63:0] reg7;
    output [63:0] reg8;
    output [63:0] reg9;
    output [63:0] reg10;
    output [63:0] reg11;
    output [63:0] reg12;
    output [63:0] reg13;
    output [63:0] reg14;

    reg [63:0] register_file[0:15];
    always @(negedge clk)
    begin
        register_file[0] = rax;
        register_file[1] = rcx;
        register_file[2] = rdx;
        register_file[3] = rbx;
        register_file[4] = rsp;
        register_file[5] = rbp;
        register_file[6] = rsi;
        register_file[7] = rdi;
        register_file[8] = r8;
        register_file[9] = r9;
        register_file[10] = r10;
        register_file[11] = r11;
        register_file[12] = r12;
        register_file[13] = r13;
        register_file[14] = r14;

        if (icode==4'b0010)//cmov
        begin
            if (cnd==1'b1)
            begin
                register_file[rB] = ValE;
            end
        end
        if (icode==4'b0011)//irmov
        begin
            register_file[rB] = ValE;
        end
        if (icode==4'b0101)//mrmov
        begin
            register_file[rA] = ValM;
        end
        if (icode==4'b0110)//op
        begin
            register_file[rB] = ValE;
        end
        if (icode==4'b1000)//call
        begin
            register_file[4] = ValE;
        end
        if (icode==4'b1001)//return
        begin
            register_file[4] = ValE;
        end
        if (icode==4'b1010)//push
        begin
            register_file[4] = ValE;
        end
        if (icode==4'b1011)//pop
        begin
            register_file[4] = ValE;
            register_file[rA] = ValM;
        end
    end
    assign reg0 = register_file[0];
    assign reg1 = register_file[1];
    assign reg2 = register_file[2];
    assign reg3 = register_file[3];
    assign reg4 = register_file[4];
    assign reg5 = register_file[5];
    assign reg6 = register_file[6];
    assign reg7 = register_file[7];
    assign reg8 = register_file[8];
    assign reg9 = register_file[9];
    assign reg10 = register_file[10];
    assign reg11 = register_file[11];
    assign reg12 = register_file[12];
    assign reg13 = register_file[13];
    assign reg14 = register_file[14];

endmodule

