module decodemodule(input wire clk, input [3:0] rA, input [3:0] rB, input [3:0] icode, 
    // input [63:0] rax,
    // input [63:0] rcx,
    // input [63:0] rdx,
    // input [63:0] rbx,
    // input [63:0] rsp,
    // input [63:0] rbp,
    // input [63:0] rsi,
    // input [63:0] rdi,
    // input [63:0] r8,
    // input [63:0] r9,
    // input [63:0] r10,
    // input [63:0] r11,
    // input [63:0] r12,
    // input [63:0] r13,
    // input [63:0] r14,
    output reg[63:0] valA,
    output reg[63:0] valB);

    reg[63:0] register_file [0:14];
    parameter rax= 4'd0;
    parameter rcx= 4'd1;
    parameter rdx= 4'd2;
    parameter rbx= 4'd3;
    parameter rsp= 4'd4;
    parameter rbp= 4'd5;
    parameter rsi= 4'd6;
    parameter rdi= 4'd7;
    parameter r8= 4'd8;
    parameter r9= 4'd0;
    parameter r10= 4'd10;
    parameter r11= 4'd11;
    parameter r12= 4'd12;
    parameter r13= 4'd13;
    parameter r14= 4'd14;

    always @* begin
      
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

      if(icode== 4'b0010)
      begin
        valA= register_file[rA];
        
      end
      else if(icode== 4'b0011)
      begin
        
      end
      else if(icode== 4'b0100)
      begin
        valA= register_file[rA];
        
      end
      else if(icode== 4'b0101)
      begin
        valB= register_file[rB];
        
      end
      else if(icode== 4'b0110)begin
        valA= register_file[rA];
        valB= register_file[rB];
      end
      else if(icode== 4'b0111)
      begin
        
      end
      else if(icode== 4'b1000)
      begin
        
        valB= register_file[4];
      end
      else if(icode== 4'b1001)begin
        valA= register_file[4];
        valB= register_file[4];
      end
      else if(icode== 4'b1010)begin
        valA= register_file[rA];
        valB= register_file[4];
      end
      else if(icode== 4'b1011)begin
        valA= register_file[4];
        valB= register_file[4];
      end
      else
      begin
      end
    end
endmodule