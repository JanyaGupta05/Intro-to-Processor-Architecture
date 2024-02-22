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
wire ins_address;
wire hlt;
wire adr_address;

fetchmodule call(
    .clk(clk),
    .pc(pc),
    .icode(icode),
    .ifun(ifun),
    .rA(rA),
    .rB(rB),
    .valC(valC),
    .valP(valP),
    .ins_address(ins_address),
    .hlt(hlt),
    .adr_address(adr_address)
);

initial begin
    
    clk=1;  
    pc=0;
    #10
    pc=valP;
    #10
    pc= valP;
    #10
    pc= valP;
    #10
    pc=valP;
    #10
    pc=valP;
    #10
    pc=valP;
    #10
    $finish;

end

always @*
begin
$display("%d %d %d %d %d %d %b %b %b",icode, ifun, rA, rB, valC, valP, ins_address, adr_address, hlt);
end
endmodule