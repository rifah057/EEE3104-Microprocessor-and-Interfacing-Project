// Code your design here
module ALU(A, B, opcode, send, resultOut);
  input[7:0] A;
  input[7:0] B;
  input[3:0] opcode;
  input send;
  output[7:0] resultOut;
  
  reg[7:0] result;
  
  assign resultOut = send ? result : 8'bzzzz_zzzz; //result is buffered
  
  always@(A or B)
    begin
      if(opcode==4'b0000) result <= A+B;
      /*case
        begin
          
        end
      endcase*/
    end
  
endmodule

module ARegister(dataIn, dataOut, dataALU, load, send, clk); //clock needed
  
  input[7:0] dataIn;
  output[7:0] dataOut;
  output[7:0] dataALU;
  input load, send, clk;
  
  reg[7:0] data;
  
  assign dataOut = send ? data : 8'bzzzz_zzzz;//goes to bus when send is set
  assign dataALU = data; //goes to alu
  
  always@(posedge clk)
    begin
      if(load)
        begin
          data <= dataIn; 
        end
    end
  
endmodule

module BRegister(clk, dataIn, dataALU, load);
  input clk, load;
  input[7:0] dataIn;
  output[7:0] dataALU;
  
  reg[7:0] data;
  
  assign dataALU = data;
  
  always@(posedge clk)
    begin
      if(load)
        begin
          data<=dataIn;
        end
    end
endmodule