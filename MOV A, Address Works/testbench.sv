// Code your testbench here
// or browse Examples
module tb_full();
  reg clk;
  reg reset;
  wire Cp, Ep, Lmp, Lmi, Cei, Cea, Li, Ei, La, Ea, Su, Eu, Lb, Lo;
  wire[3:0] PC_to_MAR; // connection between pc to mar
  wire[3:0] MAR_to_RAM; //connection between mar to ram
  wire[7:0] RAM_to_IR; //connection between ram and ir
  wire[3:0] RAM_to_A; //connection between ram and a
  wire[3:0] IR_to_Control; //connection between ir and control unit
  wire[3:0] IR_to_MAR; //connection between ir and mar
  wire[3:0] A_to_ALU; //connection between a and alu
  
  ControlSequencer example_tbCS(clk, reset, IR_to_Control, Cp, Ep, Lmp, Lmi, Cei, Cea, Li, Ei, La, Ea, Su, Eu, Lb, Lo);
  ProgramCounter example_tbPC(clk, reset, Ep, Cp, PC_to_MAR);
  MAR example_tbMAR(clk, Lmp, Lmi, PC_to_MAR, IR_to_MAR, MAR_to_RAM);
  RAM example_tbRAMRAM(clk, Cei, Cea, MAR_to_RAM, RAM_to_IR, RAM_to_A);
  InstructionRegister example_tbIR(clk, RAM_to_IR, Li, Ei, reset, IR_to_Control, IR_to_MAR);
  ARegister example_tbAR(clk, RAM_to_A, La, Ea, reset, A_to_ALU);
  
  initial
    begin
      clk = 1'b1;
      reset = 1'b1; 
      #1 reset = 1'b0; //reset is done once
      #2 $display("t=%d, Cp=%b, Ep=%b, Cei=%b, Cea=%b, La=%b, Ea=%b, Ei=%b, Li=%b, Lmp = %b, Lmi=%b, Su=%b, Eu=%b, Lb=%b, Lo=%b, PC_to_MAR=%8b, MAR_to_RAM=%8b, RAM_to_IR=%8b, IR_to_Control=%4b, IR_to_MAR=%4b, RAM_to_A=%4b, A_to_ALU=%4b", $time, Cp, Ep, Cei, Cea, La, Ea, Ei, Li, Lmp, Lmi, Su, Eu, Lb, Lo, PC_to_MAR, MAR_to_RAM, RAM_to_IR, IR_to_Control, IR_to_MAR, RAM_to_A, A_to_ALU);
      #1 reset = 1'b1;
      #3
      $display("t=%d, Cp=%b, Ep=%b, Cei=%b, Cea=%b, La=%b, Ea=%b, Ei=%b, Li=%b, Lmp = %b, Lmi=%b, Su=%b, Eu=%b, Lb=%b, Lo=%b, PC_to_MAR=%8b, MAR_to_RAM=%8b, RAM_to_IR=%8b, IR_to_Control=%4b, IR_to_MAR=%4b, RAM_to_A=%4b, A_to_ALU=%4b", $time, Cp, Ep, Cei, Cea, La, Ea, Ei, Li, Lmp, Lmi, Su, Eu, Lb, Lo, PC_to_MAR, MAR_to_RAM, RAM_to_IR, IR_to_Control, IR_to_MAR, RAM_to_A, A_to_ALU);
      #6
      $display("t=%d, Cp=%b, Ep=%b, Cei=%b, Cea=%b, La=%b, Ea=%b, Ei=%b, Li=%b, Lmp = %b, Lmi=%b, Su=%b, Eu=%b, Lb=%b, Lo=%b, PC_to_MAR=%8b, MAR_to_RAM=%8b, RAM_to_IR=%8b, IR_to_Control=%4b, IR_to_MAR=%4b, RAM_to_A=%4b, A_to_ALU=%4b", $time, Cp, Ep, Cei, Cea, La, Ea, Ei, Li, Lmp, Lmi, Su, Eu, Lb, Lo, PC_to_MAR, MAR_to_RAM, RAM_to_IR, IR_to_Control, IR_to_MAR, RAM_to_A, A_to_ALU);
      #4
      $display("t=%d, Cp=%b, Ep=%b, Cei=%b, Cea=%b, La=%b, Ea=%b, Ei=%b, Li=%b, Lmp = %b, Lmi=%b, Su=%b, Eu=%b, Lb=%b, Lo=%b, PC_to_MAR=%8b, MAR_to_RAM=%8b, RAM_to_IR=%8b, IR_to_Control=%4b, IR_to_MAR=%4b, RAM_to_A=%4b, A_to_ALU=%4b", $time, Cp, Ep, Cei, Cea, La, Ea, Ei, Li, Lmp, Lmi, Su, Eu, Lb, Lo, PC_to_MAR, MAR_to_RAM, RAM_to_IR, IR_to_Control, IR_to_MAR, RAM_to_A, A_to_ALU);
      #6
      $display("t=%d, Cp=%b, Ep=%b, Cei=%b, Cea=%b, La=%b, Ea=%b, Ei=%b, Li=%b, Lmp = %b, Lmi=%b, Su=%b, Eu=%b, Lb=%b, Lo=%b, PC_to_MAR=%8b, MAR_to_RAM=%8b, RAM_to_IR=%8b, IR_to_Control=%4b, IR_to_MAR=%4b, RAM_to_A=%4b, A_to_ALU=%4b", $time, Cp, Ep, Cei, Cea, La, Ea, Ei, Li, Lmp, Lmi, Su, Eu, Lb, Lo, PC_to_MAR, MAR_to_RAM, RAM_to_IR, IR_to_Control, IR_to_MAR, RAM_to_A, A_to_ALU);
      #4
      $display("t=%d, Cp=%b, Ep=%b, Cei=%b, Cea=%b, La=%b, Ea=%b, Ei=%b, Li=%b, Lmp = %b, Lmi=%b, Su=%b, Eu=%b, Lb=%b, Lo=%b, PC_to_MAR=%8b, MAR_to_RAM=%8b, RAM_to_IR=%8b, IR_to_Control=%4b, IR_to_MAR=%4b, RAM_to_A=%4b, A_to_ALU=%4b", $time, Cp, Ep, Cei, Cea, La, Ea, Ei, Li, Lmp, Lmi, Su, Eu, Lb, Lo, PC_to_MAR, MAR_to_RAM, RAM_to_IR, IR_to_Control, IR_to_MAR, RAM_to_A, A_to_ALU);
      #6
      $display("t=%d, Cp=%b, Ep=%b, Cei=%b, Cea=%b, La=%b, Ea=%b, Ei=%b, Li=%b, Lmp = %b, Lmi=%b, Su=%b, Eu=%b, Lb=%b, Lo=%b, PC_to_MAR=%8b, MAR_to_RAM=%8b, RAM_to_IR=%8b, IR_to_Control=%4b, IR_to_MAR=%4b, RAM_to_A=%4b, A_to_ALU=%4b", $time, Cp, Ep, Cei, Cea, La, Ea, Ei, Li, Lmp, Lmi, Su, Eu, Lb, Lo, PC_to_MAR, MAR_to_RAM, RAM_to_IR, IR_to_Control, IR_to_MAR, RAM_to_A, A_to_ALU);
      #4
      $display("t=%d, Cp=%b, Ep=%b, Cei=%b, Cea=%b, La=%b, Ea=%b, Ei=%b, Li=%b, Lmp = %b, Lmi=%b, Su=%b, Eu=%b, Lb=%b, Lo=%b, PC_to_MAR=%8b, MAR_to_RAM=%8b, RAM_to_IR=%8b, IR_to_Control=%4b, IR_to_MAR=%4b, RAM_to_A=%4b, A_to_ALU=%4b", $time, Cp, Ep, Cei, Cea, La, Ea, Ei, Li, Lmp, Lmi, Su, Eu, Lb, Lo, PC_to_MAR, MAR_to_RAM, RAM_to_IR, IR_to_Control, IR_to_MAR, RAM_to_A, A_to_ALU);
      #6
      $display("t=%d, Cp=%b, Ep=%b, Cei=%b, Cea=%b, La=%b, Ea=%b, Ei=%b, Li=%b, Lmp = %b, Lmi=%b, Su=%b, Eu=%b, Lb=%b, Lo=%b, PC_to_MAR=%8b, MAR_to_RAM=%8b, RAM_to_IR=%8b, IR_to_Control=%4b, IR_to_MAR=%4b, RAM_to_A=%4b, A_to_ALU=%4b", $time, Cp, Ep, Cei, Cea, La, Ea, Ei, Li, Lmp, Lmi, Su, Eu, Lb, Lo, PC_to_MAR, MAR_to_RAM, RAM_to_IR, IR_to_Control, IR_to_MAR, RAM_to_A, A_to_ALU);
      #4
      $display("t=%d, Cp=%b, Ep=%b, Cei=%b, Cea=%b, La=%b, Ea=%b, Ei=%b, Li=%b, Lmp = %b, Lmi=%b, Su=%b, Eu=%b, Lb=%b, Lo=%b, PC_to_MAR=%8b, MAR_to_RAM=%8b, RAM_to_IR=%8b, IR_to_Control=%4b, IR_to_MAR=%4b, RAM_to_A=%4b, A_to_ALU=%4b", $time, Cp, Ep, Cei, Cea, La, Ea, Ei, Li, Lmp, Lmi, Su, Eu, Lb, Lo, PC_to_MAR, MAR_to_RAM, RAM_to_IR, IR_to_Control, IR_to_MAR, RAM_to_A, A_to_ALU);
      #6
      $display("t=%d, Cp=%b, Ep=%b, Cei=%b, Cea=%b, La=%b, Ea=%b, Ei=%b, Li=%b, Lmp = %b, Lmi=%b, Su=%b, Eu=%b, Lb=%b, Lo=%b, PC_to_MAR=%8b, MAR_to_RAM=%8b, RAM_to_IR=%8b, IR_to_Control=%4b, IR_to_MAR=%4b, RAM_to_A=%4b, A_to_ALU=%4b", $time, Cp, Ep, Cei, Cea, La, Ea, Ei, Li, Lmp, Lmi, Su, Eu, Lb, Lo, PC_to_MAR, MAR_to_RAM, RAM_to_IR, IR_to_Control, IR_to_MAR, RAM_to_A, A_to_ALU);
      #4
      $display("t=%d, Cp=%b, Ep=%b, Cei=%b, Cea=%b, La=%b, Ea=%b, Ei=%b, Li=%b, Lmp = %b, Lmi=%b, Su=%b, Eu=%b, Lb=%b, Lo=%b, PC_to_MAR=%8b, MAR_to_RAM=%8b, RAM_to_IR=%8b, IR_to_Control=%4b, IR_to_MAR=%4b, RAM_to_A=%4b, A_to_ALU=%4b", $time, Cp, Ep, Cei, Cea, La, Ea, Ei, Li, Lmp, Lmi, Su, Eu, Lb, Lo, PC_to_MAR, MAR_to_RAM, RAM_to_IR, IR_to_Control, IR_to_MAR, RAM_to_A, A_to_ALU);
      #6
      $display("t=%d, Cp=%b, Ep=%b, Cei=%b, Cea=%b, La=%b, Ea=%b, Ei=%b, Li=%b, Lmp = %b, Lmi=%b, Su=%b, Eu=%b, Lb=%b, Lo=%b, PC_to_MAR=%8b, MAR_to_RAM=%8b, RAM_to_IR=%8b, IR_to_Control=%4b, IR_to_MAR=%4b, RAM_to_A=%4b, A_to_ALU=%4b", $time, Cp, Ep, Cei, Cea, La, Ea, Ei, Li, Lmp, Lmi, Su, Eu, Lb, Lo, PC_to_MAR, MAR_to_RAM, RAM_to_IR, IR_to_Control, IR_to_MAR, RAM_to_A, A_to_ALU);
      #4
      $display("t=%d, Cp=%b, Ep=%b, Cei=%b, Cea=%b, La=%b, Ea=%b, Ei=%b, Li=%b, Lmp = %b, Lmi=%b, Su=%b, Eu=%b, Lb=%b, Lo=%b, PC_to_MAR=%8b, MAR_to_RAM=%8b, RAM_to_IR=%8b, IR_to_Control=%4b, IR_to_MAR=%4b, RAM_to_A=%4b, A_to_ALU=%4b", $time, Cp, Ep, Cei, Cea, La, Ea, Ei, Li, Lmp, Lmi, Su, Eu, Lb, Lo, PC_to_MAR, MAR_to_RAM, RAM_to_IR, IR_to_Control, IR_to_MAR, RAM_to_A, A_to_ALU);
      #6
      $display("t=%d, Cp=%b, Ep=%b, Cei=%b, Cea=%b, La=%b, Ea=%b, Ei=%b, Li=%b, Lmp = %b, Lmi=%b, Su=%b, Eu=%b, Lb=%b, Lo=%b, PC_to_MAR=%8b, MAR_to_RAM=%8b, RAM_to_IR=%8b, IR_to_Control=%4b, IR_to_MAR=%4b, RAM_to_A=%4b, A_to_ALU=%4b", $time, Cp, Ep, Cei, Cea, La, Ea, Ei, Li, Lmp, Lmi, Su, Eu, Lb, Lo, PC_to_MAR, MAR_to_RAM, RAM_to_IR, IR_to_Control, IR_to_MAR, RAM_to_A, A_to_ALU);
      #4
      $display("t=%d, Cp=%b, Ep=%b, Cei=%b, Cea=%b, La=%b, Ea=%b, Ei=%b, Li=%b, Lmp = %b, Lmi=%b, Su=%b, Eu=%b, Lb=%b, Lo=%b, PC_to_MAR=%8b, MAR_to_RAM=%8b, RAM_to_IR=%8b, IR_to_Control=%4b, IR_to_MAR=%4b, RAM_to_A=%4b, A_to_ALU=%4b", $time, Cp, Ep, Cei, Cea, La, Ea, Ei, Li, Lmp, Lmi, Su, Eu, Lb, Lo, PC_to_MAR, MAR_to_RAM, RAM_to_IR, IR_to_Control, IR_to_MAR, RAM_to_A, A_to_ALU);
      #6
      $display("t=%d, Cp=%b, Ep=%b, Cei=%b, Cea=%b, La=%b, Ea=%b, Ei=%b, Li=%b, Lmp = %b, Lmi=%b, Su=%b, Eu=%b, Lb=%b, Lo=%b, PC_to_MAR=%8b, MAR_to_RAM=%8b, RAM_to_IR=%8b, IR_to_Control=%4b, IR_to_MAR=%4b, RAM_to_A=%4b, A_to_ALU=%4b", $time, Cp, Ep, Cei, Cea, La, Ea, Ei, Li, Lmp, Lmi, Su, Eu, Lb, Lo, PC_to_MAR, MAR_to_RAM, RAM_to_IR, IR_to_Control, IR_to_MAR, RAM_to_A, A_to_ALU);
      #4
      $display("t=%d, Cp=%b, Ep=%b, Cei=%b, Cea=%b, La=%b, Ea=%b, Ei=%b, Li=%b, Lmp = %b, Lmi=%b, Su=%b, Eu=%b, Lb=%b, Lo=%b, PC_to_MAR=%8b, MAR_to_RAM=%8b, RAM_to_IR=%8b, IR_to_Control=%4b, IR_to_MAR=%4b, RAM_to_A=%4b, A_to_ALU=%4b", $time, Cp, Ep, Cei, Cea, La, Ea, Ei, Li, Lmp, Lmi, Su, Eu, Lb, Lo, PC_to_MAR, MAR_to_RAM, RAM_to_IR, IR_to_Control, IR_to_MAR, RAM_to_A, A_to_ALU);
      #6
      $display("t=%d, Cp=%b, Ep=%b, Cei=%b, Cea=%b, La=%b, Ea=%b, Ei=%b, Li=%b, Lmp = %b, Lmi=%b, Su=%b, Eu=%b, Lb=%b, Lo=%b, PC_to_MAR=%8b, MAR_to_RAM=%8b, RAM_to_IR=%8b, IR_to_Control=%4b, IR_to_MAR=%4b, RAM_to_A=%4b, A_to_ALU=%4b", $time, Cp, Ep, Cei, Cea, La, Ea, Ei, Li, Lmp, Lmi, Su, Eu, Lb, Lo, PC_to_MAR, MAR_to_RAM, RAM_to_IR, IR_to_Control, IR_to_MAR, RAM_to_A, A_to_ALU);
      #1
      $finish;
    end
  
  always #5 clk = ~clk;

endmodule