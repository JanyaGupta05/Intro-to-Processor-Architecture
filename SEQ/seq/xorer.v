module xorer(A,B,xored);
input [63:0] A;
input [63:0] B;
output [63:0] xored;
genvar k;
    generate
        for(k=0;k<64;k=k+1)
        begin : XOR_OP
          xor C1(xored[k],A[k],B[k]);
        end
    endgenerate
endmodule