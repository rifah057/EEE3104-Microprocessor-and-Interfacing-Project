// Code your testbench here
// or browse Examples
module MOV_A_Address_tb();
  reg clk;
  reg reset;
  reg[3:0] input_address;
  reg[7:0] input_program;
  reg input_mode;
  wire Cp, Ep, Lmp, Lmi, Cei, Cea, Li, Ei, LaRam, Lab, LaALU, Eatmp, Lbtmp, Ltmpa, Etmpb, Su, Eu, Eba, Lo, EaRAM, LA, LtmpRAM, Cetmp, LbALU, LaOUT, EaOut, HLT, Ercl, Lzf, Ecf, Lcf, Lcarry, EaCarry, LcarryA, Ejmp, Lpush, Epush, Lpop, Epop, pushstack, popstack, LRam, ERam, LPC, EPC, Ecall;
  wire[3:0] PC_to_MAR; // connection between pc to mar
  wire[3:0] MAR_to_RAM; //connection between mar to ram
  wire[7:0] RAM_to_IR; //connection between ram and ir
  wire[3:0] RAM_to_A; //connection between ram and a
  wire[3:0] IR_to_Control; //connection between ir and control unit
  wire[3:0] IR_operand; //connection between ir and mar
  wire[3:0] A_to_ALU; //connection between a and alu
  wire[3:0] B_to_A; //connection between a and b
  wire[3:0] A_to_TMP; //connection between a and temp
  wire[3:0] TMP_to_B; //connection between tmp and b
  wire[3:0] B_to_ALU; //connection between b and alu
  wire[3:0] ALU_to_A; //connection between a and alu
  wire[3:0] A_to_RAM; //connection between a and ram(to send data to ram from A)
  wire[3:0] RAM_to_TMP; //connection between ram and tmp
  wire[3:0] ALU_to_B; //connection between alu and b(to send data from alu to b)
  wire[3:0] TMP_to_ALU; //connection between tmp and alu
  wire[3:0] A_to_OUT; //connection between a and out
  wire[3:0] OUT_to_disp; //connection between out and display
  //wire ALU_to_F_Cout; //carry out of ALU result
  wire[3:0] RAM_to_B; //connection between ram and b for pop
  wire[3:0] B_to_RAM; //connection between ram and b for push
  wire[3:0] PC_to_RAM; //To push return address from pc to ram
  wire[3:0] RAM_to_PC; //To pop return address from ram to pc
  wire Z_from_ALU, Carry_from_ALU; 
  wire Carry_to_Reg, Carry_from_B, Carry_from_A;
  
  
  integer k;
  
  
  ControlSequencer example_tbCS(clk, reset, IR_to_Control, Cp, Ep, Lmp, Lmi, Cei, Cea, Li, Ei, LaRam, Lab, LaALU, Eatmp, Su, Eu, Lbtmp, Eba, Lo, Ltmpa, Etmpb, EaRAM, LA, LtmpRAM, Cetmp, LbALU, LaOUT, EaOut, HLT, Ercl, Lzf, Ecf, Lcf, Lcarry, EaCarry, LcarryA, Ejmp, Lpush, Epush, Lpop, Epop, pushstack, popstack, LRam, ERam, LPC, EPC, Ecall);
  ProgramCounter example_tbPC(clk, reset, Ep, ERam, LRam, Ecall, Cp, Ejmp, IR_operand, Z_from_ALU, PC_to_MAR, HLT, PC_to_RAM, RAM_to_PC);
  MAR example_tbMAR(clk, Lmp, Lmi, PC_to_MAR, IR_operand, MAR_to_RAM);
  RAM example_tbRAMRAM(input_mode, input_address, input_program, clk, Cei, Cea, Cetmp, LA, Lpush, Epop, LPC, EPC, pushstack, popstack, MAR_to_RAM, RAM_to_IR, RAM_to_A, A_to_RAM, B_to_RAM, RAM_to_B, RAM_to_TMP, PC_to_RAM, RAM_to_PC);
  InstructionRegister example_tbIR(clk, RAM_to_IR, Li, Ei, reset, IR_to_Control, IR_operand);
  ARegister example_tbAR(clk, RAM_to_A, B_to_A, LaRam, Lab, LaALU, Eatmp, EaRAM, EaOut, EaCarry, reset, A_to_ALU, A_to_TMP, ALU_to_A, A_to_RAM, A_to_OUT, Carry_from_A);
  TMPRegister example_tbTMPR(clk, A_to_TMP, Ltmpa, LtmpRAM, Etmpb, reset, TMP_to_B, TMP_to_ALU, RAM_to_TMP);
  BRegister example_tbBR(clk, TMP_to_B, Lbtmp, LbALU, Lcarry, Eba, Epush, Lpop, reset, B_to_A, B_to_ALU, ALU_to_B, Carry_to_Reg, Ercl, Carry_from_B, B_to_RAM, RAM_to_B);
  ALU example_tbALU(clk, reset, A_to_ALU, B_to_ALU, TMP_to_ALU, IR_to_Control, Eu, ALU_to_A, ALU_to_B, Z_from_ALU, Carry_from_ALU);
  FlagRegister example_tbFlag(clk, reset, Z_from_ALU, Carry_from_ALU, Carry_to_Reg, Carry_from_B,Carry_from_A, Ercl, Lzf, Ecf, Lcf, LcarryA);
  OUTRegister example_tbOUTR(clk, reset, A_to_OUT, LaOUT, OUT_to_disp);

 initial
   begin
     clk=1'b1;
     reset = 1'b1; 
     #1 reset = 1'b0;
  
     #1 reset=1'b1; input_mode = 1;
     
     //storing data at address 9h
     #1 input_address = 4'b1001; input_program = 8'b0000_0001; //decimal 1
     
     //storing data at address Ah
     #1 input_address = 4'b1010; input_program = 8'b0000_1000; //decimal 8
     
     //mov a, 9h[address]
     #1 input_address = 4'b0000; input_program = 8'b0111_1001;
     
     //xchg a,b
     #1 input_address = 4'b0001; input_program = 8'b0011_0000;
     
     //push b
     //#1 input_address = 4'b0010; input_program = 8'b1100_0000;
     
     //mov a, Ah[address]
     #1 input_address = 4'b0010; input_program = 8'b0111_1010;
     
     //call address
     #1 input_address = 4'b0011; input_program = 8'b1110_0110;
     
     //add a,b
     #1 input_address = 4'b0100; input_program = 8'b0001_0000;
     
     //xchg a,b
     #1 input_address = 4'b0101; input_program = 8'b0011_0000;
     
     //sub a,b
     #1 input_address = 4'b0110; input_program = 8'b0010_0000;
     
     //ret
     #1 input_address = 4'b0111; input_program = 8'b1111_0000;
     
     //xchg a,b
     //#1 input_address = 4'b0100; input_program = 8'b0011_0000;
     
     //pop b
     //#1 input_address = 4'b0101; input_program = 8'b1101_0000;
     
     //sub a,b
     //#1 input_address = 4'b0011; input_program = 8'b0010_0000;
     
     //jz address
     //#1 input_address = 4'b0100; input_program = 8'b1011_0110;
     
     //shr a
     //#1 input_address = 4'b0001; input_program = 8'b0101_0000;
     
     //rcl b
     //#1 input_address = 4'b0101; input_program = 8'b0100_0000;
     
     //add a,b
     //#1 input_address = 4'b0110; input_program = 8'b0001_0000;

     #1 input_mode=0;
   end
  
  initial
    begin
      $dumpfile("MOV_A_Address.vcd");
      $dumpvars(0,MOV_A_Address_tb);
      #1000 $finish;
    end
  
  always #10 clk = ~clk;
  
endmodule
  
  
  