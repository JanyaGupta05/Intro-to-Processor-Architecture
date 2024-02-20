module fetchmodule(input wire clk, input [63:0] pc,
    output reg [3:0] icode, output reg [3:0] ifun, output reg [3:0] rA, output reg [3:0] rB, output reg [63:0] valC, 
    output reg [63:0] valP, output reg instruct_error);

    reg[7:0]instruction_memory[0:21];
    reg [0:79] instruction;
    initial 
    begin
        $readmemb("1.txt", instruction_memory);
        #10;
    end

    always @* begin
     instruction= {instruction_memory[pc],instruction_memory[pc+1],instruction_memory[pc+2],instruction_memory[pc+3],instruction_memory[pc+4],instruction_memory[pc+5],instruction_memory[pc+6],instruction_memory[pc+7],instruction_memory[pc+8],instruction_memory[pc+9]};
     instruct_error=0;
     icode = instruction[0:3];
     ifun = instruction[4:7];

     if(icode== 4'b0000 || icode== 4'b0001 || icode== 4'b1001)begin
      valP = pc +1;
     end

     else if( icode== 4'b0010 || icode== 4'b0110 || icode== 4'b1010 || icode== 4'b1011)begin
    rA= instruction[8:11];
    rB= instruction[12:15];
    valP= pc+2;
     end

    else if(icode== 4'b0011 || icode== 4'b0100 || icode== 4'b0101)begin
    rA= instruction[8:11];
    rB= instruction[12:15];
    valC= instruction[16:79];
    valP= pc +10;
    end

    else if( icode== 4'b1000 || icode== 4'b0111)begin
    valC= instruction[8:71];
    valP= pc+9;
    end
    
    else begin
    instruct_error=1;
    end
    end
endmodule