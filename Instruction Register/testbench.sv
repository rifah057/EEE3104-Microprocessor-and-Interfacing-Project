// Code your testbench here
// or browse Examples
module InstructionRegister_tb;
  reg load, send, reset;
  reg[7:0] instruction;
  wire[3:0] control;
  wire[3:0] wbus;
  
  InstructionRegister example_tb(instruction, load, send, reset, wbus, control);
 
  
  initial
    begin
      reset = 1;
      #2 reset = 0;
      
      instruction = 8'b0000_1100;
      load = 1;
      send = 0;
      #2 //takes a while to update
      $display("t=%d, control=%4b, wbus=%4b", $time, control, wbus);
      
      #5
      load = 0;
      send = 1;
      #2 //takes a while to update
      $display("t=%d, control=%4b, wbus=%4b", $time, control, wbus);
      
      #5
  	  $finish;
    end
 
endmodule