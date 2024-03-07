`include "ander.v"
`include "proadder.v"
`include "xorer.v"
module alu(A,B,S0,S1,ADD,OF,anded,xored);
input signed [63:0] A;
input signed [63:0] B;
input S0;
input S1;
output signed [63:0] ADD;
output [63:0] anded;
output [63:0] xored;
output OF;
wire [63:0]ADDx;
wire [63:0]xorx;
wire [63:0]andx;
wire over;
wire e3,e4;
and G1(e3,S1,~S0);
and G2(e4,S1,S0);
genvar i;
    proadder A1(A,B,S0,ADDx,over);
    xorer C1(A,B,xorx);
    ander D1(A,B,andx);
    generate
        for(i=0;i<64;i=i+1)
        begin : Enable_OP
          and H1(ADD[i],ADDx[i],~S1);
          and H2(xored[i],xorx[i],e4);
          and H3(anded[i],andx[i],e3);
        end
    endgenerate
    and G3(OF,over,~S1);
endmodule