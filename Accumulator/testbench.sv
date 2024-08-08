// Code your testbench here
// or browse Examples
module ARegister_tb;
  
  reg load, send, reset;
  reg[7:0] dataIn;
  wire[7:0] dataOut;
  wire[7:0] dataALU;
  
  ARegister example_tb(dataIn, dataOut, dataALU, load, send, reset);

  initial
    begin
      reset = 1;
      #2 reset = 0;
      
      dataIn = 8'b0000_1100;
      load = 1;
      send = 0;
      #2 //takes a while to update
      $display("t=%d, dataOut=%8b, dataALU=%8b", $time, dataOut, dataALU);
      
      #5
      load = 0;
      send = 1;
      #2 //takes a while to update
      $display("t=%d, dataOut=%8b, dataALU=%8b", $time, dataOut, dataALU);
      
      #5
  	  $finish;
    end
 
endmodule