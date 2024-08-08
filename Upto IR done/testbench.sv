// Code your testbench here
// or browse Examples
module tb_full();
  reg clk;
  reg reset;
  wire Cp, Ep, Lm, Ce, Li, Ei, La, Ea, Su, Eu, Lb, Lo;
  wire[7:0] PCout; //output of PC
  wire[7:0] MAR_to_RAM; //output of MAR
  wire[7:0] RAM_to_BUS; //output of BUS
  wire[3:0] IR_to_Control; //IR to control
  
  ControlSequencer example_tbCS(clk, reset, Cp, Ep, Lm, Ce, Li, Ei, La, Ea, Su, Eu, Lb, Lo);
  ProgramCounter example_tbPC(clk, reset, Ep, Cp, PCout);
  MAR example_tbMAR(clk, Lm, PCout, MAR_to_RAM);
  RAM example_tbRAM(clk, Ce, MAR_to_RAM, RAM_to_BUS);
  InstructionRegister example_tbIR(RAM_to_BUS, Li, reset, IR_to_Control);
  
  initial
    begin
      clk = 1'b1;
      reset = 1'b1; 
      #2 reset = 1'b0; //reset is done once
      #1 $display("t=%d, Ep=%b, Lm=%b, PCout=%8b, MARout=%8b", $time, Ep, Lm, PCout, MAR_to_RAM);
      #1 reset = 1'b1;
      $display("t=%d, Ep=%b, Lm=%b, PCout=%8b, MARout=%8b", $time, Ep, Lm, PCout, MAR_to_RAM);
      #3
      $display("t=%d, Ep=%b, Lm=%b, PCout=%8b, MARout=%8b", $time, Ep, Lm, PCout, MAR_to_RAM);
      #6
      $display("t=%d, Ep=%b, Lm=%b, PCout=%8b, MARout=%8b", $time, Ep, Lm, PCout, MAR_to_RAM);
      #4
      $display("t=%d, Ep=%b, Lm=%b, Cp=%b, PCout=%8b, MARout=%8b", $time, Ep, Lm, Cp, PCout, MAR_to_RAM);
      #6
      $display("t=%d, Cp=%b, PCout=%8b, MARout=%8b, RAMout=%8b", $time, Cp, PCout, MAR_to_RAM, RAM_to_BUS);
      #4
      $display("t=%d, Cp=%b, Ce=%b, MARout=%8b, RAMout=%8b", $time, Cp, Ce, MAR_to_RAM, RAM_to_BUS);
      #6
      $display("t=%d, Ce=%b, Li=%b, MARout=%8b, RAMout=%8b, IR_to_Control=%4b", $time, Ce, Li, MAR_to_RAM, RAM_to_BUS, IR_to_Control);
      #1
      $finish;
    end
  
  always #5 clk = ~clk;
  
  
endmodule