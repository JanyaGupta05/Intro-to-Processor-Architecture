`include "adder.v"
module proadder(A,B,M,ADD,OF);
input signed [63:0] A; 
input signed [63:0] B;
input M;
output signed [63:0] ADD;
output OF;
wire [63:0] Bx;
wire [64:0] Cin;
assign Cin[0]=M;
genvar i,j;
    generate
        for(j=0;j<64;j=j+1)
        begin : PRE_XOR
          xor A1(Bx[j],B[j],M);
        end
    endgenerate

    generate
        for(i=0;i<64;i=i+1)
        begin : ADD_SUB_OP          
          adder B1(A[i],Bx[i],Cin[i],ADD[i],Cin[i+1]);                            
        end
    endgenerate
    xor G1(OF,Cin[63],Cin[64]);
endmodule