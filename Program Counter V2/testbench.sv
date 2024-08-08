// Code your testbench here
// or browse Examples
module ProgramCounter_tb;
  reg clk, reset, Ep, Cp;
  wire[7:0] PCout; 
  
  ProgramCounter example_tb(clk, reset, Ep, Cp, PCout);
  
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
      #3 Ep=1; #5 Ep=0; //latching to MAR on first negedge of clock
      $display("t=%d, PCout=%8b", $time, PCout);
      #5 Cp=1; #5 Cp=0; //incrementing the counter on second negedge of clock
      $display("t=%d, PCout=%8b", $time, PCout);
      #5 Ep=1; #5 Ep=0; //latching to MAR on third negedge of clock
      $display("t=%d, PCout=%8b", $time, PCout);
      #5
  	  $finish;
    end
 
endmodule