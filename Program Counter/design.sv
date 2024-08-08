// Code your design here
module ProgramCounter(clk, reset, LoadPC, PCin, PCout);
  input clk, reset, LoadPC;
  input[7:0] PCin;
  output reg[7:0] PCout;
  
  always@(posedge clk, negedge reset)
    begin
      if(reset)
        PCout<=8'b0;
      else if(LoadPC)
        PCout<=PCin;
    end
  
endmodule