`include "alu.v"
module execute(input wire clk,input [3:0]E_icode, input [3:0]E_ifun , input [63:0] E_valA , input [63:0] E_valB , input [63:0] E_valC ,
input [3:0] E_dstE , input [3:0] E_dstM ,input [1:0] E_stat ,input set_cc, output reg [1:0] M_stat , output reg [3:0] M_icode, output reg [3:0] M_ifun,
output reg M_cnd , output reg [63:0] M_valA , output reg [63:0] M_valE , output reg [3:0] M_dstE , output reg [3:0] M_dstM , 
output reg [63:0] e_valE , output reg [3:0] e_dstE , output reg e_cnd);



always @(*)
begin
    if (icode==4'b0110 && clk ==1)
    begin
        zf = (res==1'b0)&&(ifun==4'b0000||ifun==4'b0001);
        sf = (res[63]==1);
        if (ifun == 4'b0000)
        begin
            of = (a[63]==b[63])&&(res[63]!=a[63]);
        end
        else if (ifun == 4'b0001)
        begin
            of = (a[63]!=b[63])&&(res[63] != a[63]);
        end
    end
end
reg of;
reg zf;
reg sf;
reg [63:0] ValA;
reg [63:0] ValB;
reg [63:0] ValC;
reg [3:0] icode;
reg [3:0] ifun;
reg signed [63:0] ValE;
reg cnd;
wire [63:0] res;
wire overfl ;
wire [63:0] anded;
wire [63:0] movand;
wire [63:0] incand;
wire [63:0] decand;
wire [63:0] xored;
wire [63:0] movxor;
wire [63:0] incxor;
wire [63:0] decxor;
reg signed [63:0] result;
reg signed [63:0] a;
reg signed [63:0] b;
reg S0;
reg S1;
wire signed [63:0] vinc;
wire signed [63:0] vdec;
wire signed [63:0] vmov;
alu alu1(a,b,S0,S1,res,overfl,anded,xored);
alu alu2(ValB,ValC,1'b0,1'b0,vmov,overfl,movand,movxor);
alu alu3(ValB,64'd8,1'b0,1'b0,vinc,overfl,incand,incxor);
alu alu4(ValB,64'd8,1'b1,1'b0,vdec,overfl,decand,decxor);
initial
begin
    S0=0;
    S1=0;
    a = 64'b0;
    b = 64'b0;
end

always @(*)
begin
    ValA = E_valA;
    ValB = E_valB;
    ValC = E_valC;
    icode = E_icode;
    ifun = E_ifun;
    e_dstE = E_dstE;
    e_valE = ValE;
    e_cnd = cnd;
end


always @(*)
begin
    if(clk==1)
    begin
        cnd = 0;
        if (icode==4'b0010 || icode==4'b0111)//cmov //jump
        begin
            if(ifun==4'b0000)//uncon
            begin
                cnd = 1;
            end
            else if(ifun==4'b0001)//le
            begin
                cnd = (sf^of)|(zf);
            end
            else if (ifun==4'b0010)//l
            begin
                cnd = (sf^of);
            end
            else if (ifun==4'b0011)//e
            begin
                cnd = zf;
            end
            else if (ifun==4'b0100)//ne
            begin
                cnd = ~zf;
            end
            else if (ifun==4'b0101)//ge
            begin
                cnd = ~(sf^of);
            end
            else if (ifun==4'b0110)//g
            begin
                cnd = ~(sf^of)&(~zf);
            end
            ValE = 64'd0 + ValA;
        end
        else if (icode==4'b0011) //irmov
        begin
            ValE = 64'd0 + ValC;
        end
        else if (icode==4'b0100 || icode == 4'b0101) //rmmov //mrmov
        begin
            ValE = vmov;
        end
        else if (icode==4'b0110)//OP
        begin
            if(ifun==4'b0000)//add
            begin
                S0=0;
                S1=0;
                a = ValA;
                b = ValB;
                assign result = res;
            end
            else if (ifun==4'b0001)//sub
            begin
                S0=1;
                S1=0;
                a = ValA;
                b = ValB;
                assign result = res;
            end
            else if (ifun==4'b0010)//and
            begin
                S0=0;
                S1=1;
                a = ValA;
                b = ValB;
                assign result = anded;
            end
            else if (ifun==4'b0011)//xor
            begin
                S0=1;
                S1=1;
                a = ValA;
                b = ValB;
                assign result = xored;
            end
            ValE = result;
        end
        else if (icode==4'b1000 || icode==4'b1010)//call //push
        begin
            ValE = vdec;
        end
        else if (icode==4'b1001 || icode==4'b1011)//ret //pop
        begin
            ValE = vinc;
        end
        else 
        begin
            ValE = 64'd0;//default case
        end
    end
end

always@(posedge clk)
begin
    M_stat <= E_stat;
    M_icode <= E_icode;
    M_cnd <= e_cnd;
    M_valE <= e_valE;
    M_valA <= E_valA;
    M_dstE <= e_dstE;
    M_dstM <= E_dstM;
end

endmodule