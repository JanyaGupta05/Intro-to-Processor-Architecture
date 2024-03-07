module memory(input clk , input [1:0] M_stat , input [3:0] M_icode, input [3:0] M_ifun , input M_cnd , input [3:0] M_dstE,
input [3:0] M_dstM, input [63:0] M_valA , input [63:0] M_valE , output reg [1:0] W_stat , output reg [3:0] W_icode,
output reg [3:0] W_ifun , output reg [63:0] W_valE , output reg [63:0] W_valM , output reg [3:0] W_dstE , output reg [3:0] W_dstM
,output reg [1:0] m_stat , output reg [63:0] m_valM, output reg [63:0] data , output reg W_cnd);


reg [3:0] icode;
reg [3:0] ifun;
reg [63:0] ValA;
reg [63:0] ValM;
reg [63:0] ValE;
reg adr_memory;
always @(*)
begin
    icode = M_icode;
    ifun = M_ifun;
    ValA = M_valA;
    m_valM = ValM;
    ValE = M_valE;
    m_stat = M_stat;
end



reg[63:0] mem[0:8192];

always @(*)
begin
    if(icode==4'b1001)
    begin
      ValM=mem[ValA];
    end
        if (icode==4'b1010)
    begin
        mem[ValE] = ValA;
    end
        if (icode==4'b1000)
    begin
        mem[ValE] = ValA;
    end
        if (icode==4'b0100)
    begin
        mem[ValE] = ValA;
    end
end
always @(*)
begin 
    adr_memory=0;
    if(ValE>8192)
    begin
      adr_memory=1;
      m_stat = 2'd2;
    end
    else
    begin
    // if (icode==4'b0100)
    // begin
    //     mem[ValE] = ValA;
    // end
    if (icode==4'b0101)
    begin
        ValM = mem[ValE];
    end
    // if (icode==4'b1000)
    // begin
    //     mem[ValE] = ValP;
    // end
    // if (icode==4'b1001)
    // begin
    //     ValM = mem[ValA];
    // end
    if (icode==4'b1011)
    begin
        ValM = mem[ValA];
    end
    // if (icode==4'b1010)
    // begin
    //     mem[ValE] = ValA;
    // end
    //     if(icode==4'b1001)
    // begin
    //   ValM=mem[ValA];
    // end
    data = mem[ValE];
end 
end

always @(posedge clk)
begin
    W_stat = m_stat;
    W_icode = M_icode;
    W_valE = M_valE;
    W_valM = m_valM;
    W_dstE = M_dstE;
    W_dstM =M_dstM;
    W_cnd =M_cnd;
end


endmodule