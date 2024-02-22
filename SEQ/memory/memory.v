module memory(input wire clk, input [3:0] icode ,input [63:0] ValA , input [63:0] ValE, input [63:0] ValP, output reg [63:0] data , output reg [63:0] ValM,output reg adr_memory);

reg[63:0] mem[0:8192];

always @(posedge clk)
begin 
    adr_memory=0;
    if(ValE>8192)
    begin
      adr_memory=1;
    end
    else
    begin
    if (icode==4'b0100)
    begin
        mem[ValE] = ValA;
    end
    if (icode==4'b0101)
    begin
        ValM = mem[ValE];
    end
    if (icode==4'b1000)
    begin
        mem[ValE] = ValP;
    end
    if (icode==4'b1001)
    begin
        ValM = mem[ValA];
    end
    if (icode==4'b1011)
    begin
        ValM = mem[ValA];
    end
    if (icode==4'b1010)
    begin
        mem[ValE] = ValA;
    end
    data = mem[ValE];
end 
end


endmodule