// Code your testbench here
// or browse Examples
module tb_full();
  reg clk;
  reg reset;
  wire Cp, Ep, Lm, Ce, Li, Ei, La, Ea, Su, Eu, Lb, Lo;
  //wire[3:0] BUS; //output of PC
  wire[3:0] MAR_to_RAM; //output of MAR
  //wire[7:0] RAM_to_BUS; //output of BUS
  wire[3:0] IR_to_Control; //IR to control
  //wire[7:0] IR_to_BUS; //IR to BUS
  wire[7:0] BUS;
  wire[3:0] A_to_ALU; //output to alu from A
  
  ControlSequencer example_tbCS(clk, reset, IR_to_Control, Cp, Ep, Lm, Ce, Li, Ei, La, Ea, Su, Eu, Lb, Lo);
  ProgramCounter example_tbPC(clk, reset, Ep, Cp, BUS);
  MAR example_tbMAR(clk, Lm, BUS, MAR_to_RAM);
  RAM example_tbRAM(clk, Ce, MAR_to_RAM, BUS);
  InstructionRegister example_tbIR(clk, BUS, Li, Ei, reset, IR_to_Control, BUS);
  ARegister example_tbAR(BUS[3:0], A_to_ALU, La, Ea);
  
  initial
    begin
      clk = 1'b1;
      reset = 1'b1; 
      #2 reset = 1'b0; //reset is done once
      #1 $display("t=%d, Ep=%b, Lm=%b, PCout=%8b, MARout=%8b", $time, Ep, Lm, BUS, MAR_to_RAM);
      #1 reset = 1'b1;
      $display("t=%d, Ep=%b, Lm=%b, PCout=%8b, MARout=%8b", $time, Ep, Lm, BUS, MAR_to_RAM);
      #3
      $display("t=%d, Ep=%b, Lm=%b, PCout=%8b, MARout=%8b", $time, Ep, Lm, BUS, MAR_to_RAM);
      #6
      $display("t=%d, Ep=%b, Lm=%b, PCout=%8b, MARout=%8b", $time, Ep, Lm, BUS, MAR_to_RAM);
      #4
      $display("t=%d, Ep=%b, Lm=%b, Cp=%b, PCout=%8b, MARout=%8b", $time, Ep, Lm, Cp, BUS, MAR_to_RAM);
      #6
      $display("t=%d, Cp=%b, PCout=%8b, MARout=%8b, BUS=%8b", $time, Cp, BUS, MAR_to_RAM, BUS);
      #4
      $display("t=%d, Cp=%b, Ce=%b, MARout=%8b, BUS=%8b", $time, Cp, Ce, MAR_to_RAM, BUS);
      #6
      $display("t=%d, Ce=%b, Li=%b, MARout=%8b, BUS=%8b, IR_to_Control=%4b", $time, Ce, Li, MAR_to_RAM, BUS, IR_to_Control);
      #4
      $display("t=%d, Ce=%b, Li=%b, Ei=%b, Lm=%b, MARout=%8b, BUS=%8b", $time, Ce, Li, Ei, Lm, MAR_to_RAM, BUS);
      #6
      $display("t=%d, Li=%b, Ei=%b, MARout=%8b, BUS=%8b, IR_to_Control=%4b", $time, Li, Ei, MAR_to_RAM, BUS, IR_to_Control);
      #4
      $display("t=%d, Ce=%b, La=%b, MARout=%8b, BUS=%8b", $time, Ce, La, MAR_to_RAM, BUS);
      #6
      $display("t=%d, Li=%b, Ei=%b, MARout=%8b, BUS=%8b, IR_to_Control=%4b, A_to_ALU=%4b", $time, Li, Ei, MAR_to_RAM, BUS, IR_to_Control, A_to_ALU);
      #1
      $finish;
    end
  
  always #5 clk = ~clk;

endmodule