module adder(A,B,C,S,O);
input A;
input B;
input C;
output S;
output O;
wire a0,b0,c0;
xor G1(S,A,B,C);
and G2(a,A,B);
and G3(b,B,C);
and G4(c,C,A);
or G5(O,a,b,c);
endmodule