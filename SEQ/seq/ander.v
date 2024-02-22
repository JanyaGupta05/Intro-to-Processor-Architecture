module ander(A,B,anded);
input [63:0] A;
input [63:0] B;
output [63:0] anded;

genvar l;
    generate
        for(l=0;l<64;l=l+1)
        begin : AND_OP
          and D1(anded[l],A[l],B[l]);
        end
    endgenerate
endmodule