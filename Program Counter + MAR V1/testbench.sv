// Code your testbench here
// or browse Examples
module ProgramCounter_tb;
  reg clk; //main clock
  reg reset, Ep, Cp; //inputs of PC
  reg lm; //inputs of MAR
  wire[7:0] PCout; //output of PC
  wire[7:0] to_RAM; //output of MAR
  
  ProgramCounter example_tbPC(clk, reset, Ep, Cp, PCout);
  MAR example_tbMAR(clk, lm, PCout, to_RAM);
  
  initial
    begin
      clk = 1'b1;
      reset = 1'b1; 
      #2 reset = 1'b0; //reset is done once
      #2 reset = 1'b1;
    end
  
  always #5 clk = ~clk;
  
  initial
    begin
      #2 Ep=1; lm=0; #5 Ep=0; lm=1; //latching to MAR on first negedge of clock
      $display("t=%d, PCout=%8b, to_RAM=%8b", $time, PCout, to_RAM);
      
      #5 Cp=1; #5 Cp=0; //incrementing the counter on second negedge of clock
      $display("t=%d, PCout=%8b, to_RAM=%8b", $time, PCout, to_RAM);
      
      #5 Ep=1; lm=0; #5 Ep=0; lm=1; //latching to MAR on third negedge of clock
      $display("t=%d, PCout=%8b, to_RAM=%8b", $time, PCout, to_RAM);
      #5
  	  $finish;
    end
 
endmodule