// Code your testbench here
// or browse Examples
module MainMemory_tb;
  reg w_enable, r_enable, manual_mode;
  reg[7:0] address;
  reg[3:0] manual_data;
  wire[3:0] wbus_data;
  
  MainMemory example_tb(address, w_enable, r_enable, manual_mode, manual_data, wbus_data);
 
  
  initial
    begin
      address = 8'b0000_1100;
      w_enable = 1;
      r_enable = 0;
      manual_mode = 1;
      manual_data = 4'b1010;
      
      #5
      w_enable = 0;
      r_enable = 1;
      manual_mode = 0;
      #2 //takes a while to update
      $display("t=%d, data at location=%4b", $time, wbus_data);
      
      address = 8'b0000_1010;
      w_enable = 1;
      r_enable = 0;
      manual_mode = 1;
      manual_data = 4'b1110;
      
      #5
      w_enable = 0;
      r_enable = 1;
      manual_mode = 0;
      #2 //takes a while to update
      $display("t=%d, data at location=%4b", $time, wbus_data);
      
      #5
  	  $finish;
    end
 
endmodule