// Code your design here
module InstructionRegister(instruction, load, send, reset, wbus, control);
  
  input[7:0] instruction;
  input load, send, reset;
  output[3:0] wbus;
  output[3:0] control;
  
  reg[3:0] opcode;
  reg[3:0] operand;
  
  assign control = opcode;
  assign wbus = send ? operand : 4'bzzzz;
  
  always@(instruction or posedge load)
    begin
      if(load)
        begin
          opcode <= instruction[7:4];
          operand <=instruction[3:0];
        end
    end
  
  always@(posedge reset)
    begin
      opcode <= 4'b0;
      operand <= 4'b0;
    end
  
  
endmodule