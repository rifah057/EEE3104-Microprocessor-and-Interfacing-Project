// Code your design here
module ARegister(dataIn, dataOut, dataALU, load, send, reset); //clock needed
  
  input[7:0] dataIn;
  output[7:0] dataOut;
  output[7:0] dataALU;
  input load, send, reset;
  
  reg[7:0] data;
  
  assign dataOut = send ? data : 8'bzzzz_zzzz;
  assign dataALU = data;
  
  always@(dataIn or posedge load)
    begin
      if(load)
        begin
          data <= dataIn; 
        end
    end
  
  always@(posedge reset)
    begin
      data <= 8'bzzzz_zzzz;
    end
  
endmodule