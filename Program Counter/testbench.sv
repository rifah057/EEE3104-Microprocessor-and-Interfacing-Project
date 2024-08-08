// Code your testbench here
// or browse Examples
module ProgramCounter_tb;
  reg clk, reset, LoadPC;
  reg[7:0] PCin;
  wire[7:0] PCout; 
  
  ProgramCounter example_tb(clk, reset, LoadPC, PCin, PCout);
  
  initial
    begin
      clk = 1'b0;
      #2 reset = 1; 
      #7 reset = 0;
    end
  
  always #5 clk = ~clk;
  
  initial
    begin
      PCin = 8'b0111_1100;
      #12 LoadPC=1;
      #5 LoadPC=0;
      $display("t=%d, PCout=%8b", $time, PCout);
      #5 reset = 1;
      #5 reset = 0;
      $display("t=%d, PCout=%8b", $time, PCout);
      #5
  	  $finish;
    end
 
endmodule