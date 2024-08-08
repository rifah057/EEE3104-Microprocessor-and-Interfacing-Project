// Code your design here
module ControlSequencer(clk, reset, Cp, Ep, Lm, Ce, Li, Ei, La, Ea, Su, Eu, Lb, Lo);
  
  input clk, reset;
  //input [3:0] from_IR;
  output reg Cp, Ep, Lm, Ce, Li, Ei, La, Ea, Su, Eu, Lb, Lo;
  
  reg[5:0] counter_state;
  
  always@(negedge clk or negedge reset)
    begin
      if(~reset)
        begin
          counter_state <= 6'b000001;
        end
      else if(counter_state==6'b100000)
        begin
          counter_state <= 6'b000001;
        end
      else 
        begin
          counter_state <= counter_state<<1;
        end
     end
  
  always@(negedge clk)
    begin
      case(counter_state)
        6'b000001:
          begin
            Cp <= 0; Ep <= 1; Lm <= 1;
            Ce <= 0; Li <= 0; Ei <= 0;
            La <= 0; Ea <= 0; Su <= 0;
            Eu <= 0; Lb <= 0; Lo <= 0;
          end
        6'b000010:
          begin
            Cp <= 1; Ep <= 0; Lm <= 0;
            Ce <= 0; Li <= 0; Ei <= 0;
            La <= 0; Ea <= 0; Su <= 0;
            Eu <= 0; Lb <= 0; Lo <= 0;
          end
        6'b000100:
          begin
            Cp <= 0; Ep <= 0; Lm <= 0;
            Ce <= 1; Li <= 1; Ei <= 0;
            La <= 0; Ea <= 0; Su <= 0;
            Eu <= 0; Lb <= 0; Lo <= 0;
          end
        default:
          begin
            Cp <= 0; Ep <= 0; Lm <= 0;
            Ce <= 0; Li <= 0; Ei <= 0;
            La <= 0; Ea <= 0; Su <= 0;
            Eu <= 0; Lb <= 0; Lo <= 0;
          end
      endcase
    end
endmodule


module ProgramCounter(clk, reset, Ep, Cp, PCout);
  input clk, reset, Ep, Cp;
  output[7:0] PCout;
  
  reg[7:0] count_buffer; 
  reg[7:0] count;
  
  initial
    begin
      count_buffer = 8'bzzzz_zzzz;
      count = 8'b0000_0000;
    end
  
  assign PCout = count_buffer; //write bus
  
  always@(posedge clk)
    begin
      if(Ep)
        begin
          count_buffer <= count; 
        end
      else if(Cp)  
        begin
          //$display("Increment block e asche");
          count <= (count == 8'b1111_1111) ? 8'b0000_0000 : count + 8'b0000_0001;
          //$display("count=%8b", count);
        end
    end
   
  always@(negedge reset)
    begin
      if(~reset) count<=8'b0;
    end
  
endmodule


module MAR(clk, Lm, from_PC, to_RAM);
  
  input clk, Lm;
  input [7:0]  from_PC;
  output [7:0] to_RAM;

  reg [7:0] address = 8'b1111_1111;

  assign to_RAM = address;

  always @(*) 
    begin
      //$display("Ei block e asche");
      //$display("from_PC=%8b, lm=%b", from_PC, Lm);
      if(Lm)
        //$display("Ei block e asche");
        begin
         address <= from_PC;
        end
    end
   
endmodule

module RAM(clk, Ce, from_MAR, to_BUS);
  
  input clk,Ce;
  input[7:0] from_MAR;
  output[7:0] to_BUS;
  
  reg[7:0] ram[0:15];
  reg[7:0] dataOut = 8'bzzzz_zzzz;
  
  integer address;
  initial
    begin
      for(address=0;address<16;address=address+1)
        begin
          ram[address] <= 8'b0;
        end
      
      ram[0] <= 8'b0001_1001; //mov a, 9h(address)
      ram[1] <= 8'b0111_0000; //xchg b,a
      ram[2] <= 8'b0001_1010; //mov a, Ah(address)
      ram[3] <= 8'b0001_0000; //add a,b
      ram[4] <= 8'b1111_0000; //out a
      ram[9] <= 8'b0000_1010;
    end
  
  always@(posedge clk)
    begin
      if(Ce)
        begin
          //$display("RAM access kortese");
          //$display("MARout=%8b", from_MAR);
          dataOut<=ram[from_MAR];
        end
      else
        begin
          dataOut<=8'bzzzz_zzzz;
        end
    end
  
  assign to_BUS = dataOut;
  
endmodule

module InstructionRegister(instruction, Li, reset, to_Control);
  
  input[7:0] instruction;
  input Li, reset; //Li=Load from RAM, Ei=Send to BUS and CS
  output[3:0] to_Control;
  
  reg[3:0] opcode;
  
  assign to_Control = opcode;
  
  always@(*)
    begin
      if(Li)
        begin
          //$display("IR theke control e charbe");
          //$display("Instruction=%8b, Opcode=%4b", instruction, opcode);
          opcode <= instruction[7:4];
        end
    end
   
  always@(negedge reset)
    begin
      if(~reset)
        begin
          opcode <= 4'b0;
        end
    end
  
  
endmodule




