// Code your design here

/*For the program counter, we will need a clock input as usual, a clear input for resetting the counter, a Ep input to indicate that on the next clock edge the value of the counter will be latched onto MAR, a Cp input to allow increment, an input and an output*/

module ProgramCounter(clk, reset, Ep, Cp, PCout);
  input clk, reset, Ep, Cp;
  output[7:0] PCout;
  
  reg[7:0] count_buffer = 8'bzzzzzzzz; //this is the value put on the bus when Ep is set
  reg[7:0] count;
  
  assign PCout = count_buffer; //write bus
  
  always@(negedge clk)
    begin
      if(Ep) //latch to MAR, send output of program counter on write bus
        begin
          count_buffer <= count; 
        end
      else if(Cp) //increment state
        begin
          count <= (count == 8'b1111_1111) ? 8'b0000_0000 : count + 8'b0000_0001;
        end
    end
   
  always@(negedge reset)
    begin
      if(~reset) count<=8'b0;
    end
  
endmodule