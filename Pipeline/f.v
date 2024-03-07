module freg(input clk, input [63:0] f_pc, output reg [63:0] F_predPC);
always @(posedge clk)
begin
    F_predPC <= f_pc;
end
endmodule