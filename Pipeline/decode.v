module decodemodule(input wire clk, input [3:0] D_icode, input[3:0] D_ifun, input[3:0] D_rA, input[3:0] D_rB, 
input[63:0] D_valC, input[63:0] D_valP, input[1:0] D_stat, input[3:0] e_dstE, input[3:0] M_dstE, input[3:0] M_dstM,
input[3:0] W_dstM, input[3:0] W_dstE, input[63:0] e_valE, input[63:0] M_valE, input[63:0] m_valM, input[63:0] W_valM,
input[63:0] W_valE,
input [63:0] rax,
input [63:0] rcx,
input [63:0] rdx,
input [63:0] rbx,
input [63:0] rsp,
input [63:0] rbp,
input [63:0] rsi,
input [63:0] rdi,
input [63:0] r8,
input [63:0] r9,
input [63:0] r10,
input [63:0] r11,
input [63:0] r12,
input [63:0] r13,
input [63:0] r14,
input E_bubble,
output reg[3:0] E_icode, output reg[3:0] E_ifun, output reg[63:0] E_valA, output reg[63:0] E_valB, output reg[63:0] E_valC,
output reg[3:0] E_dstE, output reg[3:0] E_dstM, output reg[3:0] E_srcA, output reg[3:0] E_srcB, output reg[1:0] E_stat,
output reg[63:0] d_valA, output reg[63:0] d_valB, output reg[3:0] d_srcA, output reg[3:0] d_srcB);

reg[3:0] dstE, dstM;
reg[63:0] register_file [0:14];


always @(*) begin
      
      register_file[0]= rax;
      register_file[1]= rcx;
      register_file[2]= rdx;
      register_file[3]= rbx;
      register_file[4]= rsp;
      register_file[5]= rbp;
      register_file[6]= rsi;
      register_file[7]= rdi;
      register_file[8]= r8;
      register_file[9]= r9;
      register_file[10]= r10;
      register_file[11]= r11;
      register_file[12]= r12;
      register_file[13]= r13;
      register_file[14]= r14;

      if(D_icode== 4'b0010)
      begin
        d_srcA= D_rA;
        d_srcB= 4'b1111;
        dstE= D_rB;
        dstM= 4'b1111;
        d_valA= register_file[d_srcA];
      end

      else if(D_icode== 4'b0011)
      begin
        dstE= D_rB;
        dstM= 4'b1111;
        d_srcA= 4'b1111;
        d_srcB= 4'b1111;
      end

      else if(D_icode== 4'b0100)
      begin
        d_srcA= D_rA;
        d_srcB= 4'b1111;
        dstE= D_rB;
        dstM= 4'b1111;

        d_valA= register_file[d_srcA];
        d_valB= register_file[dstE];
      end


      else if(D_icode== 4'b0101)
      begin
        d_srcA= 4'b1111;
        d_srcB= D_rB;
        dstM= D_rA;
        dstE= 4'b1111;

        d_valB= register_file[d_srcB];
      end

      else if(D_icode== 4'b0110)
      begin
        d_srcA= D_rA;
        d_srcB= D_rB;
        dstE= D_rB;
        dstM= 4'b1111;
        
        d_valA= register_file[d_srcA];
        d_valB= register_file[d_srcB];
      end

    //   else if(D_icode== 4'b0111)
    //   begin
        
    //   end

      else if(D_icode== 4'b1000)
      begin
        d_srcA= 4'b1111;
        d_srcB= 4'b0100;
        dstE= 4'b0100;
        dstM= 4'b1111;

        d_valB= register_file[d_srcB];
      end

      else if(D_icode== 4'b1001)
      begin
        d_srcA= 4'b0100;
        d_srcB= 4'b0100;
        dstE= 4'b0100;
        dstM= 4'b1111;
        
        d_valA= register_file[d_srcA];
        d_valB= register_file[d_srcB];
      end


      else if(D_icode== 4'b1010)
      begin
        d_srcA= D_rA;
        d_srcB= 4'b0100;
        dstE= 4'b0100;
        dstM= 4'b1111;
        
        d_valA= register_file[d_srcA];
        d_valB= register_file[d_srcB];

      end


      else if(D_icode== 4'b1011)
      begin
        d_srcA= 4'b0100;
        d_srcB= 4'b0100;
        dstE= 4'b0100;
        dstM= D_rA;
        
        d_valA= register_file[d_srcA];
        d_valB= register_file[d_srcB];
      end

      else
      begin

        d_srcA= 4'b1111;
        d_srcB= 4'b1111;
        dstE= 4'b1111;
        dstM= 4'b1111;

      end
    end


always @(*)
begin
  if(D_icode == 4'b1000 || D_icode == 4'b0111)
  begin
    d_valA= D_valP;
  end
  else if(d_srcA!=4'b1111)
  begin
    if(d_srcA== e_dstE)
    begin
      d_valA= e_valE;
    end
    else if(d_srcA== M_dstM)
    begin
      d_valA= m_valM;
    end
    else if(d_srcA== M_dstE)
    begin
      d_valA= M_valE;
    end
    else if(d_srcA== W_dstM)
    begin
      d_valA= W_valM;
    end
    else if(d_srcA== W_dstE)
    begin
      d_valA= W_valE;
    end
  end
end

always @(*)
begin
  if(d_srcB!=4'b1111)
  begin
    if(d_srcB== e_dstE)
    begin
      d_valB= e_valE;
    end
    else if(d_srcB== M_dstM)
    begin
      d_valB= m_valM;
    end
    else if(d_srcB== M_dstE)
    begin
      d_valB= M_valE;
    end
    else if(d_srcB== W_dstM)
    begin
      d_valB= W_valM;
    end
    else if(d_srcB== W_dstE)
    begin
      d_valB= W_valE;
    end
  end
end

always @(posedge(clk)) 
begin
    
    if(E_bubble==0)
    begin
      E_icode <= D_icode;
      E_ifun <= D_ifun;
      E_valA <= d_valA;
      E_valB <= d_valB;
      E_valC <= D_valC;
      E_srcA <= d_srcA;
      E_srcB <= d_srcB;
      E_dstE <= dstE;
      E_dstM <= dstM;
      E_stat <= D_stat;
    end
    else
    begin
      E_icode <= 4'b0001;
      E_ifun <= 4'b0000;
      E_valA <= 4'b0000;
      E_valB <= 4'b0000;
      E_valC <= 4'b0000;
      E_srcA <= 4'b1111;
      E_srcB <= 4'b1111;
      E_dstE <= 4'b1111;
      E_dstM <= 4'b1111;
      E_stat <= 2'd0;
    end
end
endmodule