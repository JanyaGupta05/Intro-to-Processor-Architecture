`include "decode.v"
module decode_tb_module;
    
    reg clk; reg[3:0] rA; reg[3:0] rB; reg[3:0] icode; 
    // reg[63:0] rax;
    // reg[63:0] rcx;
    // reg[63:0] rdx;
    // reg[63:0] rbx;
    // reg[63:0] rsp;
    // reg[63:0] rbp;
    // reg[63:0] rsi;
    // reg[63:0] rdi;
    // reg[63:0] r8;
    // reg[63:0] r9;
    // reg[63:0] r10;
    // reg[63:0] r11;
    // reg[63:0] r12;
    // reg[63:0] r13;
    // reg[63:0] r14;
    wire[63:0] valA;
    wire[63:0] valB;

decodemodule call(.clk(clk), .rA(rA), .rB(rB), .icode(icode), 
    // .rax(rax),
    // .rcx(rcx),
    // .rdx(rdx),
    // .rbx(rbx),
    // .rsp(rsp),
    // .rbp(rbp),
    // .rsi(rsi),
    // .rdi(rdi),
    // .r8(r8),
    // .r9(r9),
    // .r10(r10),
    // .r11(r11),
    // .r12(r12),
    // .r13(r13),
    // .r14(r14),
    .valA(valA),
    .valB(valB));


always #10 clk= ~clk;

initial begin
  clk=0;
  icode= 4'b0000; rA= 4'd0; rB= 4'd0; 
  #20 
  icode= 4'b0010; rA= 4'd1; rB= 4'd8;
  #20
  icode= 4'b0011; rA= 4'd2; rB= 4'd2;
  #20
  icode= 4'b0100; rA= 4'd3; rB= 4'd3;
  #20
  icode= 4'b0101; rA= 4'd4; rB= 4'd4;
  #20
  icode= 4'b0110; rA= 4'd6; rB= 4'd6;
  #20
  icode= 4'b0111; rA= 4'd5; rB= 4'd5;
  #20
  icode= 4'b1000; rA= 4'd8; rB= 4'd8;
  #20
  icode= 4'b1001; rA= 4'd9; rB= 4'd9;
  #20
  icode= 4'b1010; rA= 4'd10; rB= 4'd10;
  #20
  icode= 4'b1011; rA= 4'd11; rB= 4'd1;
  $finish;
end
always @*
begin
$monitor("%d %d %d %d %d",icode, rA, rB, valA, valB);
end
endmodule