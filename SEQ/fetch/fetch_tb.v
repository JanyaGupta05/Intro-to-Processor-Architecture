`include "fetch.v"
module fetch_tb_module;

reg clk;
reg[63:0] pc;
wire [3:0] icode;
wire [3:0] ifun;
wire [3:0] rA;
wire [3:0] rB;
wire [63:0] valC;
wire [63:0] valP;
wire instruct_error;

fetchmodule call(
    .clk(clk),
    .pc(pc),
    .icode(icode),
    .ifun(ifun),
    .rA(rA),
    .rB(rB),
    .valC(valC),
    .valP(valP),
    .instruct_error(instruct_error)
);

initial begin
    clk=1;  
    pc=0;
    #10
    pc=valP;
    #10
    pc= valP;
    $finish;
end

always @*
begin
$display("%d %d %d %d %d %d %b",icode, ifun, rA, rB, valC, valP, instruct_error);
end
endmodule