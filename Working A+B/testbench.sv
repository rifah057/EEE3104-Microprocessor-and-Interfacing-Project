// Code your testbench here
// or browse Examples
module ALU_tb();
  reg[7:0] dataAIn;
  reg[7:0] dataBIn;
  reg clk;
  reg loadA, loadB, send, sendALU;
  reg[3:0] opcode;
  
  wire[7:0] dataAout;
  wire[7:0] dataAALU;
  wire[7:0] dataBALU;
  wire[7:0] resultOut;
  
  ARegister exampleA(dataAIn, dataAOut, dataAALU, loadA, send, clk);
  BRegister exampleB(clk, dataBIn, dataBALU, loadB);
  ALU exampleALU(dataAALU, dataBALU, opcode, sendALU, resultOut);
  
  initial
    begin
      clk=1'b0;
      dataAIn = 8'b0000_0001;
      dataBIn = 8'b0000_0010;
      opcode = 4'b0000;
      #2 loadA = 1; loadB=1; send=0; sendALU=0;
      #5 $display("t=%d, A=%8b, B=%8b", $time, dataAALU, dataBALU);
      loadA=0; loadB=0; send=0; sendALU=1;
      #2 $display("t=%d, A=%8b, B=%8b, sum=%8b", $time, dataAALU, dataBALU, resultOut);
      #5 $finish;
    end
  
  always #5 clk=~clk;
  
  
  
endmodule