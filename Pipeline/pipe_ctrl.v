module pipe_logic(input [3:0]D_icode, input[3:0]d_srcA, input[3:0]d_srcB, input[3:0]E_icode, 
input[3:0]E_dstM, input[3:0]M_icode, input[1:0]m_stat, input[1:0]W_stat, input e_cnd,
output reg W_stall, output reg M_bubble, output reg set_cc, output reg E_bubble, 
output reg D_bubble, output reg D_stall, output reg F_stall);

always @(*)
begin
  set_cc=1'b1;
  W_stall= 1'b0;
  M_bubble= 1'b0;
  E_bubble= 1'b0;
  D_bubble= 1'b0;
  D_stall= 1'b0;
  F_stall= 1'b0;

  F_stall= (((E_icode==4'b0101 || E_icode== 4'b1011)&&(E_dstM== d_srcA || E_dstM== d_srcB))||(D_icode==4'b1001||E_icode==4'b1001||M_icode==4'b1001));
  D_bubble= ((E_icode==4'b0111 && !e_cnd)||((!((E_icode==4'b0101 || E_icode== 4'b1011)&&(E_dstM== d_srcA || E_dstM== d_srcB)))&&(D_icode==4'b1001||E_icode==4'b1001||M_icode==4'b1001)));
  D_stall= ((E_icode==4'b0101 || E_icode== 4'b1011)&&(E_dstM== d_srcA || E_dstM== d_srcB));
  E_bubble= ((E_icode==4'b0111 && !e_cnd)||((E_icode==4'b0101 || E_icode== 4'b1011)&&(E_dstM== d_srcA || E_dstM== d_srcB)));
  set_cc= ((E_icode==4'b0110)&&(m_stat==2'b00)&&(W_stat==2'b00));
  M_bubble= (!(m_stat==2'b00))||(!(W_stat==2'b00));
  W_stall= !(W_stat==2'b00);
end
endmodule