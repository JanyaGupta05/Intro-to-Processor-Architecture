module fetchmodule(input wire clk, input[63:0] pc, input M_cnd, input[63:0] M_valA, input[63:0] W_valM,
input F_stall, input D_stall, input D_bubble, input[3:0] M_icode, input[3:0] W_icode,
output reg [63:0] f_pc, output reg[3:0] D_icode, output reg[3:0] D_ifun, output reg[3:0] D_rA, output reg[3:0] D_rB,
output reg [63:0] D_valC, output reg [63:0] D_valP, output reg[1:0] D_stat);

//reg[63:0] pc;
reg[3:0] rA;
reg[3:0] rB;
reg[63:0] valC;
reg[63:0] valP;
reg[1:0] stat;
reg ins_address;
reg adr_address;
reg[3:0] icode;
reg[3:0] ifun;

reg[0:79] instruction;
reg[7:0]instruction_memory[0:1023];
initial 
    begin
        $readmemb("loaduse.txt", instruction_memory);
        stat=2'd0;
        adr_address=0;
        ins_address=0;
    end

always @(*)
    begin
    if(pc>120)
      begin
        adr_address=1;
        stat= 2'd2;
      end
    else
    begin

     instruction= {instruction_memory[pc],instruction_memory[pc+1],instruction_memory[pc+2],instruction_memory[pc+3],instruction_memory[pc+4],instruction_memory[pc+5],instruction_memory[pc+6],instruction_memory[pc+7],instruction_memory[pc+8],instruction_memory[pc+9]};
     icode = instruction[0:3];
     ifun = instruction[4:7];

     if(icode== 4'b0000 )
     begin
        stat=2'd1;
      valP = pc +1;
      f_pc= valP;
     end

      else if(icode== 4'b0001 || icode== 4'b1001)
      begin
        valP= pc+1;
        f_pc= valP;
      end

     else if( icode== 4'b0010 || icode== 4'b0110 || icode== 4'b1010 || icode== 4'b1011)
     begin
    rA= instruction[8:11];
    rB= instruction[12:15];
    valP= pc+2;
    f_pc= valP;
     end

    else if(icode== 4'b0011 || icode== 4'b0100 || icode== 4'b0101)
    begin
    rA= instruction[8:11];
    rB= instruction[12:15];
    valC= {instruction[72:79],instruction[64:71],instruction[56:63],instruction[48:55],instruction[40:47],instruction[32:39],instruction[24:31],instruction[16:23]};
    valP= pc +10;
    f_pc= valP;
    end

    else if( icode== 4'b1000 || icode== 4'b0111)
    begin
    valC= {instruction[64:71],instruction[56:63],instruction[48:55],instruction[40:47],instruction[32:39],instruction[24:31],instruction[16:23],instruction[8:15]};
    valP= pc+9;
    f_pc= valC;
    end
    
    else 
    begin
    ins_address=1;
    stat= 2'd3;
    end

  end

    
    
  if(F_stall)
  begin
    f_pc = pc;
  end
end

    always @(posedge(clk))
    begin
      if(D_stall)
      begin
      end
      else if(D_bubble)
      begin
        D_icode<= 4'b0001;
        D_ifun<= 4'b0000;
        D_rA<= 4'b1111;
        D_rB<= 4'b1111;
        D_valC<= 4'b0000;
        D_valP<= 4'b0000;
        D_stat<= 2'b00;
      end
      else
      begin
        D_icode<= icode;
        D_ifun<= ifun;
        D_rA<= rA;
        D_rB<= rB;
        D_valC<= valC;
        D_valP<= valP;
        D_stat<= stat;
      end
    end
endmodule

