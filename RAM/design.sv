// Code your design here
module MainMemory(address, w_enable, r_enable, manual_mode, manual_data, wbus_data);
  
  input[7:0] address;
  input w_enable, r_enable;
  input manual_mode;
  input[3:0] manual_data;
  inout[3:0] wbus_data;
  
  reg[3:0] ram[0:255];
  
  integer k;
  initial
    begin
      for(k=0;k<256;k=k+1)
        begin
          ram[k] = 8'b0;
        end
    end
  
  always@(posedge w_enable)
    begin
      if(manual_mode)
        begin
          ram[address] <= manual_data;
        end
      else
        begin
          ram[address] <= wbus_data;
        end
    end
  
  assign wbus_data = (r_enable)?ram[address]:8'bzzzz_zzzz;
  
endmodule