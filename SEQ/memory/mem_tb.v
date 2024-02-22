`include "memory.v"
module testbench;


reg clk;
reg [3:0]icode;
reg [63:0] ValA;
reg [63:0] ValE;
reg [63:0] ValP;

wire [63:0] data;
wire [63:0] ValM;
wire adr_memory;

memory memory(clk,icode ,ValA, ValE,ValP,data ,ValM,adr_memory);


initial
begin
clk=0;
icode = 4'b0100;//rm
ValA=12;
ValE=3;
#10clk=~clk;
icode = 4'b0100;
ValA=12;
ValE=3;
#10clk=~clk;
icode = 4'b0101;//mr
ValE=3;
#10clk=~clk;
icode = 4'b0101;
ValE=3;

#10clk=~clk;//rm
icode = 4'b0100;
ValA = 13;
ValE=4;
#10clk=~clk;
icode = 4'b0100;
ValE = 13;
ValE=4;

#10 clk=~clk;//call
icode = 4'b1000;
ValE=3;
ValP=100;
#10 clk=~clk;
icode = 4'b1000;
ValE=3;
ValP=100;
#10 clk=~clk;//ret
icode = 4'b1001;
ValA=3;
#10 clk=~clk;
icode = 4'b1001;
ValA=3;
#10 clk=~clk;//mr
icode = 4'b0101;
ValE = 4;
#10 clk=~clk;
icode = 4'b0101;
ValE = 4;






end

initial
begin
$monitor("valM=%d data = %d adr_memory=%d",ValM,data,adr_memory);
end

endmodule