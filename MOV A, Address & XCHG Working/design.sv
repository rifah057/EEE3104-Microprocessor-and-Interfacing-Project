// Code your design here
module ControlSequencer(clk, reset, IR_to_Control, Cp, Ep, Lmp, Lmi, Cei, Cea, Li, Ei, LaRam, Lab, Eatmp, Su, Eu, Lbtmp, Eba, Lo, Ltmpa, Etmpb);
  
  input clk, reset;
  input [3:0] IR_to_Control;
  output reg Cp, Ep, Lmp, Lmi, Cei, Cea, Li, Ei, LaRam, Lab, Eatmp, Su, Eu, Lbtmp, Eba, Lo, Ltmpa, Etmpb;
  
  //LaRam=Ram to A, Lab=B to A, Eatmp=A to Temp
  //Ltmpa=A to Temp, Etmpb=Temp to B
  //Lbtmp=Temp to B, Eba=B to A
  
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
            Cp <= 0; Ep <= 1; Lmp <= 1; Lmi<=0;
            Cei <= 0; Cea<=0; Li <= 0; Ei <= 0;
            LaRam <= 0; Lab<=0; Eatmp <= 0; Su <= 0;
            Eu <= 0; Lbtmp <= 0; Eba<=0; Lo <= 0;
            Ltmpa<=0; Etmpb<=0;
          end
        6'b000010:
          begin
            Cp <= 1; Ep <= 0; Lmp <= 0; Lmi<=0;
            Cei <= 0; Cea<=0; Li <= 0; Ei <= 0;
            LaRam <= 0; Lab<=0; Eatmp <= 0; Su <= 0;
            Eu <= 0; Lbtmp <= 0; Eba<=0; Lo <= 0;
            Ltmpa<=0; Etmpb<=0;
          end
        6'b000100:
          begin
            Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=0;
            Cei <= 1; Cea<=0; Li <= 1; Ei <= 0;
            LaRam <= 0; Lab<=0; Eatmp <= 0; Su <= 0;
            Eu <= 0; Lbtmp <= 0; Eba<=0; Lo <= 0;
            Ltmpa<=0; Etmpb<=0;
          end
        
        6'b001000:
          begin
            case(IR_to_Control)
              4'b0111: //mov a,address
                begin
                  Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=1;
                  Cei <= 0; Cea<=0; Li <= 0; Ei <= 1;
                  LaRam <= 0; Lab<=0; Eatmp <= 0; Su <= 0;
                  Eu <= 0; Lbtmp <= 0; Eba<=0; Lo <= 0;
                  Ltmpa<=0; Etmpb<=0; 
                end
              4'b0011: //xchg a,b(mov tmp,a)
                begin
                  Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=0;
                  Cei <= 0; Cea<=0; Li <= 0; Ei <= 0;
                  LaRam <= 0; Lab<=0; Eatmp <= 1; Su <= 0;
                  Eu <= 0; Lbtmp <= 0; Eba<=0; Lo <= 0;
                  Ltmpa<=1; Etmpb<=0;
                end
            endcase
          end
        6'b010000:
          begin
            case(IR_to_Control)
              4'b0111: //mov a,address
                begin
                  Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=0;
                  Cei <= 0; Cea<=1; Li <= 0; Ei <= 0;
                  LaRam <= 1; Lab<=0; Eatmp <= 0; Su <= 0;
                  Eu <= 0; Lbtmp <= 0; Eba<=0; Lo <= 0;
                  Ltmpa<=0; Etmpb<=0;
                end
              4'b0011: //xchg a,b(mov a,b)
                begin
                  Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=0;
                  Cei <= 0; Cea<=0; Li <= 0; Ei <= 0;
                  LaRam <= 0; Lab<=1; Eatmp <= 0; Su <= 0;
                  Eu <= 0; Lbtmp <= 0; Eba<=1; Lo <= 0;
                  Ltmpa<=0; Etmpb<=0;
                end
            endcase
          end
        6'b100000:
          begin
            case(IR_to_Control)
              4'b0111: //mov a,address
                begin
                  Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=0;
                  Cei <= 0; Cea<=0; Li <= 0; Ei <= 0;
                  LaRam <= 0; Lab<=0; Eatmp <= 0; Su <= 0;
                  Eu <= 0; Lbtmp <= 0; Eba<=0; Lo <= 0;
                  Ltmpa<=0; Etmpb<=0;
                end
              4'b0011: //xchg a,b(mov b,tmp)
                begin
                  Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=0;
                  Cei <= 0; Cea<=0; Li <= 0; Ei <= 0;
                  LaRam <= 0; Lab<=0; Eatmp <= 0; Su <= 0;
                  Eu <= 0; Lbtmp <= 1; Eba<=0; Lo <= 0;
                  Ltmpa<=0; Etmpb<=1;
                end
            endcase
          end
        
        default:
          begin
            Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=0;
            Cei <= 0; Cea<=0; Li <= 0; Ei <= 0;
            LaRam <= 0; Lab<=0; Eatmp <= 0; Su <= 0;
            Eu <= 0; Lbtmp <= 0; Eba<=0; Lo <= 0;
            Ltmpa<=0; Etmpb<=0;
          end
      endcase
    end
endmodule


module ProgramCounter(clk, reset, Ep, Cp, PC_to_MAR);
  input clk, reset, Ep, Cp;
  output[3:0] PC_to_MAR;
  
  reg[3:0] count_buffer; 
  reg[3:0] count;
  
  initial
    begin
      count_buffer = 4'bzzzz;
      count = 4'b0000;
    end
  
  assign PC_to_MAR = count_buffer; //write bus
  
  always@(posedge clk)
    begin
      if(Ep)
        begin
          count_buffer <= count; 
        end
      else
        begin
          count_buffer <= 4'bzzzz;
        end
      
      if(Cp)  
        begin
          //$display("Increment block e asche");
          count <= (count == 4'b1111) ? 4'b0000 : count + 4'b0001;
          //$display("count=%8b", count);
        end
    end
   
  always@(negedge reset)
    begin
      if(~reset) count<=4'b0;
    end
  
endmodule


module MAR(clk, Lmp, Lmi, PC_to_MAR, IR_to_MAR, MAR_to_RAM);
  
  input clk, Lmp, Lmi;
  input [3:0]  PC_to_MAR;
  input[3:0] IR_to_MAR;
  output [3:0] MAR_to_RAM;

  reg [3:0] address = 4'b0000;

  assign MAR_to_RAM = address;

  always @(*) 
    begin
      //$display("Ei block e asche");
      //$display("from_PC=%8b, lm=%b", from_PC, Lm);
      if(Lmp)
        //$display("Ei block e asche");
        begin
          address <= PC_to_MAR;
        end
      else if(Lmi)
        begin
          address <= IR_to_MAR;
        end
    end
   
endmodule

module RAM(clk, Cei, Cea, MAR_to_RAM, RAM_to_IR, RAM_to_A);
  
  input clk,Cei, Cea;
  input[3:0] MAR_to_RAM;
  output[7:0] RAM_to_IR;
  output[3:0] RAM_to_A;
  
  reg[7:0] ram[0:15];
  reg[7:0] dataIR = 8'bzzzz_zzzz;
  reg[3:0] dataA = 4'bzzzz;
  
  assign RAM_to_IR = dataIR;
  assign RAM_to_A = dataA;
  
  integer address;
  initial
    begin
      for(address=0;address<16;address=address+1)
        begin
          ram[address] <= 8'b0;
        end
      
      ram[0] <= 8'b0111_1001; //mov a, 9h(address)
      ram[1] <= 8'b0011_0000; //xchg b,a
      ram[2] <= 8'b0111_1010; //mov a, Ah(address)
      ram[3] <= 8'b0001_0000; //add a,b
      ram[4] <= 8'b1111_0000; //out a
      ram[9] <= 8'b0000_1010;
    end
  
  always@(posedge clk)
    begin
      if(Cei)
        begin
          //$display("RAM access kortese");
          //$display("MARout=%4b", MAR_to_RAM);
          //$display("Data at location=%8b", ram[MAR_to_RAM]);
          dataIR<=ram[MAR_to_RAM];
        end
      else if(Cea)
        begin
          dataA<=ram[MAR_to_RAM][3:0];
        end
      else
        begin
          dataIR<=8'bzzzz_zzzz;
          dataA<=4'bzzzz;
        end
    end
endmodule

module InstructionRegister(clk, RAM_to_IR, Li, Ei, reset, IR_to_Control, IR_to_MAR);
  
  input[7:0] RAM_to_IR;
  input clk, Li, Ei, reset; //Li=Load from RAM, Ei=Send to BUS and CS
  output[3:0] IR_to_Control;
  output[3:0] IR_to_MAR;
  
  reg[3:0] opcode;
  reg[3:0] operand;
  reg[3:0] address_field;
  
  assign IR_to_Control = opcode;
  assign IR_to_MAR = address_field;
  
  always@(*)
    begin
      if(Li)
        begin
          //$display("IR theke control e charbe");
          //$display("Instruction=%8b, Opcode=%4b", instruction, opcode);
          opcode <= RAM_to_IR[7:4];
          operand <= RAM_to_IR[3:0];
        end
    end
  
  
  always@(posedge clk)
    begin
      if(Ei)
        begin
          address_field<=operand;
        end
    end
  
   
  always@(negedge reset)
    begin
      if(~reset)
        begin
          opcode <= 4'bzzzz;
          operand <= 4'bzzzz;
          address_field<=4'bzzzz;
        end
    end
endmodule

module ARegister(clk, RAM_to_A, B_to_A, LaRam, Lab, Eatmp, reset, A_to_ALU, A_to_TMP);
  
  input[3:0] RAM_to_A;
  input[3:0] B_to_A;
  input clk,  LaRam, Lab, Eatmp, reset; //Li=Load from RAM, Etmp=Send to TMP and CS
  output[3:0] A_to_ALU;
  output[3:0] A_to_TMP;
  
  reg[3:0] dataALU;
  reg[3:0] dataTMP;
  
  assign A_to_ALU = dataALU;
  assign A_to_TMP = dataTMP;
  
  always@(*)
    begin
      if(LaRam)
        begin
          //$display("IR theke control e charbe");
          //$display("Instruction=%8b, Opcode=%4b", instruction, opcode);
          dataALU <= RAM_to_A;
        end
      else if(Lab)
        begin
          dataALU <= B_to_A;
        end
    end

  always@(posedge clk)
    begin
      if(Eatmp)
        begin
          dataTMP<=dataALU;
        end
    end

  always@(negedge reset)
    begin
      if(~reset)
        begin
          dataALU<=4'bzzzz;
          dataTMP<=4'bzzzz;
          //dataOut<=8'bzzzz;
        end
    end
endmodule

module TMPRegister(clk, A_to_TMP, Ltmpa, Etmpb, reset, TMP_to_B);
  
  input[3:0] A_to_TMP;
  input clk, Ltmpa, Etmpb, reset; //Ltmpa=Load from A, Etmp=Send to B
  output[3:0] TMP_to_B;
  //output[3:0] ;
  
  reg[3:0] dataTMP;
  reg[3:0] dataOut;
  
  assign TMP_to_B = dataOut;
  //assign BUS[3:0] = dataOut;
  
  always@(*)
    begin
      if(Ltmpa)
        begin
          dataTMP <= A_to_TMP;
        end
    end

  always@(posedge clk)
    begin
      if(Etmpb)
        begin
          dataOut<=dataTMP;
        end
    end

  always@(negedge reset)
    begin
      if(~reset)
        begin
          dataTMP<=4'bzzzz;
          dataOut<=4'bzzzz;
        end
    end
endmodule

module BRegister(clk, TMP_to_B, Lbtmp, Eba, reset, B_to_A);
  
  input[3:0] TMP_to_B;
  input clk, Lbtmp, Eba, reset; //Ltmp=Load from A, Etmp=Send to B
  output[3:0] B_to_A;
  //output[3:0] ;
  
  reg[3:0] dataB;
  reg[3:0] dataOut;
  
  assign B_to_A = dataOut;
  //assign BUS[3:0] = dataOut;
  
  always@(*)
    begin
      if(Lbtmp)
        begin
          dataB <= TMP_to_B;
        end
    end

  always@(posedge clk)
    begin
      if(Eba)
        begin
          dataOut<=dataB;
        end
    end

  always@(negedge reset)
    begin
      if(~reset)
        begin
          dataB<=4'b0000; //b is reset to zero
          dataOut<=4'bzzzz;
        end
    end
endmodule

