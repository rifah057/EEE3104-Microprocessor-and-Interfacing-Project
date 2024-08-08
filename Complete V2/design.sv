// Code your design here
module ControlSequencer(clk, reset, IR_to_Control, Cp, Ep, Lmp, Lmi, Cei, Cea, Li, Ei, LaRam, Lab, LaALU, Eatmp, Eu, Lbtmp, Eba, Ltmpa, Etmpb, EaRAM, LA, LtmpRAM, Cetmp, LbALU, LaOUT, EaOut, HLT, Ercl, Lzf, Ecf, Lcf, Lcarry, EaCarry, LcarryA, Ejmp, Lpush, Epush, Lpop, Epop, pushstack, popstack, LRam, ERam, LPC, EPC, Ecall);
  
  input clk, reset;
  input [3:0] IR_to_Control;
  output reg Cp, Ep, Lmp, Lmi, Cei, Cea, Li, Ei, LaRam, Lab, LaALU, Eatmp, Eu, Lbtmp, Eba, Ltmpa, Etmpb, EaRAM, LA, LtmpRAM, Cetmp, LbALU, LaOUT, EaOut, HLT, Ercl, Lzf, Ecf, Lcf, Lcarry, EaCarry, LcarryA, Ejmp, Lpush, Epush, Lpop, Epop, pushstack, popstack, LRam, ERam, LPC, EPC, Ecall;
  
  //Eu = Send ALU result to accumulator and send updated carry and zero flag to flag register
  
  //LaRam=Ram to A, Lab=B to A, Eatmp=A to Temp
  //Ltmpa=A to Temp, Etmpb=Temp to B
  //Lbtmp=Temp to B, Eba=B to A
  
  //EaRAM = Send A to RAM, LA = Load to RAM from A
  //LtmpRAM = Load from Ram to tmp, Cetmp = Send to tmp
  //LbALU = Load from ALU to B
  //LaOUT = Load from A to Out
  
  //Ecf = Send current carry from flag register to B
  //Lcarry = Load the carry sent from flag register to B
  //Ercl = Perform RCL and store updated carry. After RCL send back the updated carry to Flag register
  //Lzf = Load zero flag to flag register from ALU result
  //Lcf = Load zero flag and carry flag to flag register from ALU result/After RCL from B
  
  //EaCarry = For SHR A, send the LSB of A to Flag register to update carry and shift A logical right 
  //LcarryA = For SHR A, load the LSB of A sent from A to Carry of Flag Register
  
  //Lpush = Load b into stack, Epush = Send b to stack
  //Lpop = Load b from stack, Epop = Send b from stack
  //pushstack = signal to decrease SP, popstack=signal to increase SP
  
  reg[5:0] counter_state;
  
  /*
  always@(*)
    begin
      if(IR_to_Control==4'b1111) //hlt
        begin
          HLT<=1;
        end
    end
  */
  always@(negedge clk or negedge reset)
    begin
      if(~reset)
        begin
          counter_state <= 6'b000001;
          HLT <= 0;
        end
      else if(counter_state==6'b100000)
        begin
          counter_state <= 6'b000001;
        end
      else 
        begin
          counter_state <= counter_state<<1;
        end
     end
  
  always@(negedge clk)
    begin
      
      case(counter_state)
        6'b000001:
          begin
            Cp <= 0; Ep <= 1; Lmp <= 1; Lmi<=0;
            Cei <= 0; Cea<=0; Li <= 0; Ei <= 0;
            LaRam <= 0; Lab<=0; Eatmp <= 0;
            Eu <= 0; Lbtmp <= 0; Eba<=0;
            Ltmpa<=0; Etmpb<=0; LaALU<=0;
            EaRAM<=0; LA<=0;
            LtmpRAM<=0; Cetmp<=0; LbALU<=0;
            LaOUT<=0; EaOut<=0; 
            Ecf<=0; Lcarry<=0; Ercl<=0; Lzf<=0; Lcf<=0;
            EaCarry<=0; LcarryA<=0; Ejmp<=0;
            Lpush<=0;Epush<=0;Lpop<=0;Epop<=0;
            pushstack<=0;popstack<=0;
            LRam<=0;ERam<=0;LPC<=0;EPC<=0;Ecall<=0;
          end
        6'b000010:
          begin
            //$display("Ekhane asche");
            case(HLT)
              1'b0:
                begin
                  Cp <= 1; Ep <= 0; Lmp <= 0; Lmi<=0;
                  Cei <= 0; Cea<=0; Li <= 0; Ei <= 0;
                  LaRam <= 0; Lab<=0; Eatmp <= 0;
                  Eu <= 0; Lbtmp <= 0; Eba<=0;
                  Ltmpa<=0; Etmpb<=0; LaALU<=0;
                  EaRAM<=0; LA<=0;
                  LtmpRAM<=0; Cetmp<=0; LbALU<=0;
                  LaOUT<=0; EaOut<=0;
                  Ecf<=0; Lcarry<=0; Ercl<=0; Lzf<=0; Lcf<=0;
                  EaCarry<=0; LcarryA<=0; Ejmp<=0;
                  Lpush<=0;Epush<=0;Lpop<=0;Epop<=0;
                  pushstack<=0;popstack<=0;
                  LRam<=0;ERam<=0;LPC<=0;EPC<=0;Ecall<=0;
                end
              1'b1:
                begin
                  Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=0;
                  Cei <= 0; Cea<=0; Li <= 0; Ei <= 0;
                  LaRam <= 0; Lab<=0; Eatmp <= 0; 
                  Eu <= 0; Lbtmp <= 0; Eba<=0; 
                  Ltmpa<=0; Etmpb<=0; LaALU<=0;
                  EaRAM<=0; LA<=0;
                  LtmpRAM<=0; Cetmp<=0; LbALU<=0;
                  LaOUT<=0; EaOut<=0;
                  Ecf<=0; Lcarry<=0; Ercl<=0; Lzf<=0; Lcf<=0;
                  EaCarry<=0; LcarryA<=0; Ejmp<=0;
                  Lpush<=0;Epush<=0;Lpop<=0;Epop<=0;
                  pushstack<=0;popstack<=0;
                  LRam<=0;ERam<=0;LPC<=0;EPC<=0;Ecall<=0;
                end
            endcase
          end
        6'b000100:
          begin
            Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=0;
            Cei <= 1; Cea<=0; Li <= 1; Ei <= 0;
            LaRam <= 0; Lab<=0; Eatmp <= 0; 
            Eu <= 0; Lbtmp <= 0; Eba<=0;
            Ltmpa<=0; Etmpb<=0; LaALU<=0;
            EaRAM<=0; LA<=0;
            LtmpRAM<=0; Cetmp<=0; LbALU<=0;
            LaOUT<=0; EaOut<=0;
            Ecf<=0; Lcarry<=0; Ercl<=0; Lzf<=0; Lcf<=0;
            EaCarry<=0; LcarryA<=0; Ejmp<=0;
            Lpush<=0;Epush<=0;Lpop<=0;Epop<=0;
            pushstack<=0;popstack<=0;
            LRam<=0;ERam<=0;LPC<=0;EPC<=0;Ecall<=0;
          end
        
        6'b001000:
          begin
            case(IR_to_Control)
              4'b0111: //mov a, [address]
                begin
                  Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=1;
                  Cei <= 0; Cea<=0; Li <= 0; Ei <= 1;
                  LaRam <= 0; Lab<=0; Eatmp <= 0; 
                  Eu <= 0; Lbtmp <= 0; Eba<=0;
                  Ltmpa<=0; Etmpb<=0; LaALU<=0; 
                  EaRAM<=0; LA<=0;
                  LtmpRAM<=0; Cetmp<=0; LbALU<=0;
                  LaOUT<=0; EaOut<=0;
                  Ecf<=0; Lcarry<=0; Ercl<=0; Lzf<=0; Lcf<=0;
                  EaCarry<=0; LcarryA<=0; Ejmp<=0;
                  Lpush<=0;Epush<=0;Lpop<=0;Epop<=0;
                  pushstack<=0;popstack<=0;
                  LRam<=0;ERam<=0;LPC<=0;EPC<=0;Ecall<=0;
                end
              4'b0011: //xchg a,b(mov tmp,a)
                begin
                  Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=0;
                  Cei <= 0; Cea<=0; Li <= 0; Ei <= 0;
                  LaRam <= 0; Lab<=0; Eatmp <= 1;
                  Eu <= 0; Lbtmp <= 0; Eba<=0;
                  Ltmpa<=1; Etmpb<=0; LaALU<=0;
                  EaRAM<=0; LA<=0;
                  LtmpRAM<=0; Cetmp<=0; LbALU<=0;
                  LaOUT<=0; EaOut<=0;
                  Ecf<=0; Lcarry<=0; Ercl<=0; Lzf<=0; Lcf<=0;
                  EaCarry<=0; LcarryA<=0; Ejmp<=0;
                  Lpush<=0;Epush<=0;Lpop<=0;Epop<=0;
                  pushstack<=0;popstack<=0;
                  LRam<=0;ERam<=0;LPC<=0;EPC<=0;Ecall<=0;
                end
              4'b0001: //add a,b
                begin
                  Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=0;
                  Cei <= 0; Cea<=0; Li <= 0; Ei <= 0;
                  LaRam <= 0; Lab<=0; Eatmp <= 0;
                  Eu <= 1; Lbtmp <= 0; Eba<=0;
                  Ltmpa<=0; Etmpb<=0; LaALU<=0;
                  EaRAM<=0; LA<=0;
                  LtmpRAM<=0; Cetmp<=0; LbALU<=0;
                  LaOUT<=0; EaOut<=0;
                  Ecf<=0; Lcarry<=0; Ercl<=0; Lzf<=1; Lcf<=1;
                  EaCarry<=0; LcarryA<=0; Ejmp<=0;
                  Lpush<=0;Epush<=0;Lpop<=0;Epop<=0;
                  pushstack<=0;popstack<=0;
                  LRam<=0;ERam<=0;LPC<=0;EPC<=0;Ecall<=0;
                end
              4'b0010: //sub a,b
                begin
                  Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=0;
                  Cei <= 0; Cea<=0; Li <= 0; Ei <= 0;
                  LaRam <= 0; Lab<=0; Eatmp <= 0;
                  Eu <= 1; Lbtmp <= 0; Eba<=0;
                  Ltmpa<=0; Etmpb<=0; LaALU<=0;
                  EaRAM<=0; LA<=0;
                  LtmpRAM<=0; Cetmp<=0; LbALU<=0;
                  LaOUT<=0; EaOut<=0;
                  Ecf<=0; Lcarry<=0; Ercl<=0; Lzf<=1; Lcf<=1;
                  EaCarry<=0; LcarryA<=0; Ejmp<=0;
                  Lpush<=0;Epush<=0;Lpop<=0;Epop<=0;
                  pushstack<=0;popstack<=0;
                  LRam<=0;ERam<=0;LPC<=0;EPC<=0;Ecall<=0;
                end
              4'b1000: //and a,b
                begin
                  Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=0;
                  Cei <= 0; Cea<=0; Li <= 0; Ei <= 0;
                  LaRam <= 0; Lab<=0; Eatmp <= 0;
                  Eu <= 1; Lbtmp <= 0; Eba<=0;
                  Ltmpa<=0; Etmpb<=0; LaALU<=0;
                  EaRAM<=0; LA<=0;
                  LtmpRAM<=0; Cetmp<=0; LbALU<=0;
                  LaOUT<=0; EaOut<=0;
                  Ecf<=0; Lcarry<=0; Ercl<=0; Lzf<=1; Lcf<=1;
                  EaCarry<=0; LcarryA<=0; Ejmp<=0;
                  Lpush<=0;Epush<=0;Lpop<=0;Epop<=0;
                  pushstack<=0;popstack<=0;
                  LRam<=0;ERam<=0;LPC<=0;EPC<=0;Ecall<=0;
                end
              4'b0110: //mov [address], a
                begin
                  Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=1;
                  Cei <= 0; Cea<=0; Li <= 0; Ei <= 1;
                  LaRam <= 0; Lab<=0; Eatmp <= 0;
                  Eu <= 0; Lbtmp <= 0; Eba<=0;
                  Ltmpa<=0; Etmpb<=0; LaALU<=0;
                  EaRAM<=0; LA<=0;
                  LtmpRAM<=0; Cetmp<=0; LbALU<=0;
                  LaOUT<=0; EaOut<=0;
                  Ecf<=0; Lcarry<=0; Ercl<=0; Lzf<=0; Lcf<=0;
                  EaCarry<=0; LcarryA<=0; Ejmp<=0;
                  Lpush<=0;Epush<=0;Lpop<=0;Epop<=0;
                  pushstack<=0;popstack<=0;
                  LRam<=0;ERam<=0;LPC<=0;EPC<=0;Ecall<=0;
                end
              4'b1001: //or b, [address]
                begin
                  Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=1;
                  Cei <= 0; Cea<=0; Li <= 0; Ei <= 1;
                  LaRam <= 0; Lab<=0; Eatmp <= 0;
                  Eu <= 0; Lbtmp <= 0; Eba<=0;
                  Ltmpa<=0; Etmpb<=0; LaALU<=0;
                  EaRAM<=0; LA<=0;
                  LtmpRAM<=0; Cetmp<=0; LbALU<=0;
                  LaOUT<=0; EaOut<=0;
                  Ecf<=0; Lcarry<=0; Ercl<=0; Lzf<=1; Lcf<=1;
                  EaCarry<=0; LcarryA<=0; Ejmp<=0;
                  Lpush<=0;Epush<=0;Lpop<=0;Epop<=0;
                  pushstack<=0;popstack<=0;
                  LRam<=0;ERam<=0;LPC<=0;EPC<=0;Ecall<=0;
                end
              4'b1010: //out a
                begin
                  Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=0;
                  Cei <= 0; Cea<=0; Li <= 0; Ei <= 0;
                  LaRam <= 0; Lab<=0; Eatmp <= 0;
                  Eu <= 0; Lbtmp <= 0; Eba<=0;
                  Ltmpa<=0; Etmpb<=0; LaALU<=0;
                  EaRAM<=0; LA<=0;
                  LtmpRAM<=0; Cetmp<=0; LbALU<=0;
                  LaOUT<=0; EaOut<=1;
                  Ecf<=0; Lcarry<=0; Ercl<=0; Lzf<=0; Lcf<=0;
                  EaCarry<=0; LcarryA<=0; Ejmp<=0;
                  Lpush<=0;Epush<=0;Lpop<=0;Epop<=0;
                  pushstack<=0;popstack<=0;
                  LRam<=0;ERam<=0;LPC<=0;EPC<=0;Ecall<=0;
                end
              4'b0000: //hlt
                begin
                  Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=0;
                  Cei <= 0; Cea<=0; Li <= 0; Ei <= 0;
                  LaRam <= 0; Lab<=0; Eatmp <= 0;
                  Eu <= 0; Lbtmp <= 0; Eba<=0; 
                  Ltmpa<=0; Etmpb<=0; LaALU<=0;
                  EaRAM<=0; LA<=0;
                  LtmpRAM<=0; Cetmp<=0; LbALU<=0;
                  LaOUT<=0; EaOut<=0; HLT<=1;
                  Ecf<=0; Lcarry<=0; Ercl<=0; Lzf<=0; Lcf<=0;
                  EaCarry<=0; LcarryA<=0; Ejmp<=0;
                  Lpush<=0;Epush<=0;Lpop<=0;Epop<=0;
                  pushstack<=0;popstack<=0;
                  LRam<=0;ERam<=0;LPC<=0;EPC<=0;Ecall<=0;
                end
              4'b0100: //rcl b
                begin
                  Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=0;
                  Cei <= 0; Cea<=0; Li <= 0; Ei <= 0;
                  LaRam <= 0; Lab<=0; Eatmp <= 0; 
                  Eu <= 0; Lbtmp <= 0; Eba<=0;
                  Ltmpa<=0; Etmpb<=0; LaALU<=0;
                  EaRAM<=0; LA<=0;
                  LtmpRAM<=0; Cetmp<=0; LbALU<=0;
                  LaOUT<=0; EaOut<=0;
                  Ecf<=1; Lcarry<=1; Ercl<=0; Lzf<=0; Lcf<=0;
                  EaCarry<=0; LcarryA<=0; Ejmp<=0;
                  Lpush<=0;Epush<=0;Lpop<=0;Epop<=0;
                  pushstack<=0;popstack<=0;
                  LRam<=0;ERam<=0;LPC<=0;EPC<=0;Ecall<=0;
                end
              4'b0101: //shr a
                begin
                  Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=0;
                  Cei <= 0; Cea<=0; Li <= 0; Ei <= 0;
                  LaRam <= 0; Lab<=0; Eatmp <= 0;
                  Eu <= 0; Lbtmp <= 0; Eba<=0;
                  Ltmpa<=0; Etmpb<=0; LaALU<=0;
                  EaRAM<=0; LA<=0;
                  LtmpRAM<=0; Cetmp<=0; LbALU<=0;
                  LaOUT<=0; EaOut<=0;
                  Ecf<=0; Lcarry<=0; Ercl<=0; Lzf<=0; Lcf<=0;
                  EaCarry<=1; LcarryA<=1; Ejmp<=0;
                  Lpush<=0;Epush<=0;Lpop<=0;Epop<=0;
                  pushstack<=0;popstack<=0;
                  LRam<=0;ERam<=0;LPC<=0;EPC<=0;Ecall<=0;
                end
              4'b1011: //jz address
                begin
                  Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=0;
                  Cei <= 0; Cea<=0; Li <= 0; Ei <= 1;
                  LaRam <= 0; Lab<=0; Eatmp <= 0;
                  Eu <= 0; Lbtmp <= 0; Eba<=0;
                  Ltmpa<=0; Etmpb<=0; LaALU<=0;
                  EaRAM<=0; LA<=0;
                  LtmpRAM<=0; Cetmp<=0; LbALU<=0;
                  LaOUT<=0; EaOut<=0;
                  Ecf<=0; Lcarry<=0; Ercl<=0; Lzf<=0; Lcf<=0;
                  EaCarry<=0; LcarryA<=0; Ejmp<=0;
                  Lpush<=0;Epush<=0;Lpop<=0;Epop<=0;
                  pushstack<=0;popstack<=0;
                  LRam<=0;ERam<=0;LPC<=0;EPC<=0;Ecall<=0;
                end
              4'b1100: //push b
                begin
                  Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=0;
                  Cei <= 0; Cea<=0; Li <= 0; Ei <= 0;
                  LaRam <= 0; Lab<=0; Eatmp <= 0;
                  Eu <= 0; Lbtmp <= 0; Eba<=0;
                  Ltmpa<=0; Etmpb<=0; LaALU<=0;
                  EaRAM<=0; LA<=0;
                  LtmpRAM<=0; Cetmp<=0; LbALU<=0;
                  LaOUT<=0; EaOut<=0;
                  Ecf<=0; Lcarry<=0; Ercl<=0; Lzf<=0; Lcf<=0;
                  EaCarry<=0; LcarryA<=0; Ejmp<=0;
                  Lpush<=0;Epush<=1;Lpop<=0;Epop<=0;
                  pushstack<=0;popstack<=0;
                  LRam<=0;ERam<=0;LPC<=0;EPC<=0;Ecall<=0;
                end
              4'b1101: //pop b
                begin
                  Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=0;
                  Cei <= 0; Cea<=0; Li <= 0; Ei <= 0;
                  LaRam <= 0; Lab<=0; Eatmp <= 0;
                  Eu <= 0; Lbtmp <= 0; Eba<=0;
                  Ltmpa<=0; Etmpb<=0; LaALU<=0;
                  EaRAM<=0; LA<=0;
                  LtmpRAM<=0; Cetmp<=0; LbALU<=0;
                  LaOUT<=0; EaOut<=0;
                  Ecf<=0; Lcarry<=0; Ercl<=0; Lzf<=0; Lcf<=0;
                  EaCarry<=0; LcarryA<=0; Ejmp<=0;
                  Lpush<=0;Epush<=0;Lpop<=0;Epop<=0;
                  pushstack<=0;popstack<=1;
                  LRam<=0;ERam<=0;LPC<=0;EPC<=0;Ecall<=0;
                end
              4'b1110: //call address
                begin
                  Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=0;
                  Cei <= 0; Cea<=0; Li <= 0; Ei <= 1;
                  LaRam <= 0; Lab<=0; Eatmp <= 0;
                  Eu <= 0; Lbtmp <= 0; Eba<=0;
                  Ltmpa<=0; Etmpb<=0; LaALU<=0;
                  EaRAM<=0; LA<=0;
                  LtmpRAM<=0; Cetmp<=0; LbALU<=0;
                  LaOUT<=0; EaOut<=0;
                  Ecf<=0; Lcarry<=0; Ercl<=0; Lzf<=0; Lcf<=0;
                  EaCarry<=0; LcarryA<=0; Ejmp<=0;
                  Lpush<=0;Epush<=0;Lpop<=0;Epop<=0;
                  pushstack<=0;popstack<=0;
                  LRam<=0;ERam<=1;LPC<=1;EPC<=0;Ecall<=0;
                end
              4'b1111: //ret
                begin
                  Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=0;
                  Cei <= 0; Cea<=0; Li <= 0; Ei <= 0;
                  LaRam <= 0; Lab<=0; Eatmp <= 0;
                  Eu <= 0; Lbtmp <= 0; Eba<=0;
                  Ltmpa<=0; Etmpb<=0; LaALU<=0;
                  EaRAM<=0; LA<=0;
                  LtmpRAM<=0; Cetmp<=0; LbALU<=0;
                  LaOUT<=0; EaOut<=0;
                  Ecf<=0; Lcarry<=0; Ercl<=0; Lzf<=0; Lcf<=0;
                  EaCarry<=0; LcarryA<=0; Ejmp<=0;
                  Lpush<=0;Epush<=0;Lpop<=0;Epop<=0;
                  pushstack<=0;popstack<=1;
                  LRam<=0;ERam<=0;LPC<=0;EPC<=0;Ecall<=0;
                end
            endcase
          end
        6'b010000:
          begin
            case(IR_to_Control)
              4'b0111: //mov a,address
                begin
                  Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=0;
                  Cei <= 0; Cea<=1; Li <= 0; Ei <= 0;
                  LaRam <= 1; Lab<=0; Eatmp <= 0;
                  Eu <= 0; Lbtmp <= 0; Eba<=0;
                  Ltmpa<=0; Etmpb<=0; LaALU<=0; 
                  EaRAM<=0; LA<=0;
                  LtmpRAM<=0; Cetmp<=0; LbALU<=0;
                  LaOUT<=0; EaOut<=0;
                  Ecf<=0; Lcarry<=0; Ercl<=0; Lzf<=0; Lcf<=0;
                  EaCarry<=0; LcarryA<=0; Ejmp<=0;
                  Lpush<=0;Epush<=0;Lpop<=0;Epop<=0;
                  pushstack<=0;popstack<=0;
                  LRam<=0;ERam<=0;LPC<=0;EPC<=0;Ecall<=0;
                end
              4'b0011: //xchg a,b(mov a,b)
                begin
                  Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=0;
                  Cei <= 0; Cea<=0; Li <= 0; Ei <= 0;
                  LaRam <= 0; Lab<=1; Eatmp <= 0;
                  Eu <= 0; Lbtmp <= 0; Eba<=1;
                  Ltmpa<=0; Etmpb<=0; LaALU<=0; 
                  EaRAM<=0; LA<=0;
                  LtmpRAM<=0; Cetmp<=0; LbALU<=0;
                  LaOUT<=0; EaOut<=0;
                  Ecf<=0; Lcarry<=0; Ercl<=0; Lzf<=0; Lcf<=0;
                  EaCarry<=0; LcarryA<=0; Ejmp<=0;
                  Lpush<=0;Epush<=0;Lpop<=0;Epop<=0;
                  pushstack<=0;popstack<=0;
                  LRam<=0;ERam<=0;LPC<=0;EPC<=0;Ecall<=0;
                end
              4'b0001: //add a,b(send result of alu to a)
                begin
                  Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=0;
                  Cei <= 0; Cea<=0; Li <= 0; Ei <= 0;
                  LaRam <= 0; Lab<=0; Eatmp <= 0;
                  Eu <= 0; Lbtmp <= 0; Eba<=0;
                  Ltmpa<=0; Etmpb<=0; LaALU<=1;
                  EaRAM<=0; LA<=0;
                  LtmpRAM<=0; Cetmp<=0; LbALU<=0;
                  LaOUT<=0; EaOut<=0;
                  Ecf<=0; Lcarry<=0; Ercl<=0; Lzf<=0; Lcf<=0;
                  EaCarry<=0; LcarryA<=0; Ejmp<=0;
                  Lpush<=0;Epush<=0;Lpop<=0;Epop<=0;
                  pushstack<=0;popstack<=0;
                  LRam<=0;ERam<=0;LPC<=0;EPC<=0;Ecall<=0;
                end
              4'b0010: //sub a,b(send result of alu to a)
                begin
                  Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=0;
                  Cei <= 0; Cea<=0; Li <= 0; Ei <= 0;
                  LaRam <= 0; Lab<=0; Eatmp <= 0;
                  Eu <= 0; Lbtmp <= 0; Eba<=0;
                  Ltmpa<=0; Etmpb<=0; LaALU<=1;
                  EaRAM<=0; LA<=0;
                  LtmpRAM<=0; Cetmp<=0; LbALU<=0;
                  LaOUT<=0; EaOut<=0;
                  Ecf<=0; Lcarry<=0; Ercl<=0; Lzf<=0; Lcf<=0;
                  EaCarry<=0; LcarryA<=0; Ejmp<=0;
                  Lpush<=0;Epush<=0;Lpop<=0;Epop<=0;
                  pushstack<=0;popstack<=0;
                  LRam<=0;ERam<=0;LPC<=0;EPC<=0;Ecall<=0;
                end
              4'b1000: //and a,b
                begin
                  Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=0;
                  Cei <= 0; Cea<=0; Li <= 0; Ei <= 0;
                  LaRam <= 0; Lab<=0; Eatmp <= 0;
                  Eu <= 0; Lbtmp <= 0; Eba<=0;
                  Ltmpa<=0; Etmpb<=0; LaALU<=1;
                  EaRAM<=0; LA<=0;
                  LtmpRAM<=0; Cetmp<=0; LbALU<=0;
                  LaOUT<=0; EaOut<=0;
                  Ecf<=0; Lcarry<=0; Ercl<=0; Lzf<=0; Lcf<=0;
                  EaCarry<=0; LcarryA<=0; Ejmp<=0;
                  Lpush<=0;Epush<=0;Lpop<=0;Epop<=0;
                  pushstack<=0;popstack<=0;
                  LRam<=0;ERam<=0;LPC<=0;EPC<=0;Ecall<=0;
                end
              4'b0110: //mov address, a
                begin
                  Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=0;
                  Cei <= 0; Cea<=0; Li <= 0; Ei <= 0;
                  LaRam <= 0; Lab<=0; Eatmp <= 0;
                  Eu <= 0; Lbtmp <= 0; Eba<=0;
                  Ltmpa<=0; Etmpb<=0; LaALU<=0;
                  EaRAM<=1; LA<=1; 
                  LtmpRAM<=0; Cetmp<=0; LbALU<=0;
                  LaOUT<=0; EaOut<=0;
                  Ecf<=0; Lcarry<=0; Ercl<=0; Lzf<=0; Lcf<=0;
                  EaCarry<=0; LcarryA<=0; Ejmp<=0;
                  Lpush<=0;Epush<=0;Lpop<=0;Epop<=0;
                  pushstack<=0;popstack<=0;
                  LRam<=0;ERam<=0;LPC<=0;EPC<=0;Ecall<=0;
                end 
              4'b1001: //or b, [address]
                begin
                  Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=0;
                  Cei <= 0; Cea<=0; Li <= 0; Ei <= 0;
                  LaRam <= 0; Lab<=0; Eatmp <= 0;
                  Eu <= 0; Lbtmp <= 0; Eba<=0;
                  Ltmpa<=0; Etmpb<=0; LaALU<=0;
                  EaRAM<=0; LA<=0;
                  LtmpRAM<=1; Cetmp<=1; LbALU<=0;
                  LaOUT<=0; EaOut<=0;
                  Ecf<=0; Lcarry<=0; Ercl<=0; Lzf<=0; Lcf<=0;
                  EaCarry<=0; LcarryA<=0; Ejmp<=0;
                  Lpush<=0;Epush<=0;Lpop<=0;Epop<=0;
                  pushstack<=0;popstack<=0;
                  LRam<=0;ERam<=0;LPC<=0;EPC<=0;Ecall<=0;
                end
              4'b1010: //out a
                begin
                  Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=0;
                  Cei <= 0; Cea<=0; Li <= 0; Ei <= 0;
                  LaRam <= 0; Lab<=0; Eatmp <= 0;
                  Eu <= 0; Lbtmp <= 0; Eba<=0;
                  Ltmpa<=0; Etmpb<=0; LaALU<=0;
                  EaRAM<=0; LA<=0;
                  LtmpRAM<=0; Cetmp<=0; LbALU<=0;
                  LaOUT<=1; EaOut<=0;
                  Ecf<=0; Lcarry<=0; Ercl<=0; Lzf<=0; Lcf<=0;
                  EaCarry<=0; LcarryA<=0; Ejmp<=0;
                  Lpush<=0;Epush<=0;Lpop<=0;Epop<=0;
                  pushstack<=0;popstack<=0;
                  LRam<=0;ERam<=0;LPC<=0;EPC<=0;Ecall<=0;
                end
              4'b0000: //hlt
                begin
                  Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=0;
                  Cei <= 0; Cea<=0; Li <= 0; Ei <= 0;
                  LaRam <= 0; Lab<=0; Eatmp <= 0;
                  Eu <= 0; Lbtmp <= 0; Eba<=0;
                  Ltmpa<=0; Etmpb<=0; LaALU<=0;
                  EaRAM<=0; LA<=0;
                  LtmpRAM<=0; Cetmp<=0; LbALU<=0;
                  LaOUT<=0; EaOut<=0; 
                  Ecf<=0; Lcarry<=0; Ercl<=0; Lzf<=0; Lcf<=0;
                  EaCarry<=0; LcarryA<=0; Ejmp<=0;
                  Lpush<=0;Epush<=0;Lpop<=0;Epop<=0;
                  pushstack<=0;popstack<=0;
                  LRam<=0;ERam<=0;LPC<=0;EPC<=0;Ecall<=0;
                end
              4'b0100: //rcl b
                begin
                  Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=0;
                  Cei <= 0; Cea<=0; Li <= 0; Ei <= 0;
                  LaRam <= 0; Lab<=0; Eatmp <= 0;
                  Eu <= 0; Lbtmp <= 0; Eba<=0;
                  Ltmpa<=0; Etmpb<=0; LaALU<=0;
                  EaRAM<=0; LA<=0;
                  LtmpRAM<=0; Cetmp<=0; LbALU<=0;
                  LaOUT<=0; EaOut<=0;
                  Ecf<=0; Lcarry<=0; Ercl<=1; Lzf<=0; Lcf<=0;
                  EaCarry<=0; LcarryA<=0; Ejmp<=0;
                  Lpush<=0;Epush<=0;Lpop<=0;Epop<=0;
                  pushstack<=0;popstack<=0;
                  LRam<=0;ERam<=0;LPC<=0;EPC<=0;Ecall<=0;
                end
              4'b0101: //shr a
                begin
                  Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=0;
                  Cei <= 0; Cea<=0; Li <= 0; Ei <= 0;
                  LaRam <= 0; Lab<=0; Eatmp <= 0;
                  Eu <= 0; Lbtmp <= 0; Eba<=0;
                  Ltmpa<=0; Etmpb<=0; LaALU<=0;
                  EaRAM<=0; LA<=0;
                  LtmpRAM<=0; Cetmp<=0; LbALU<=0;
                  LaOUT<=0; EaOut<=0;
                  Ecf<=0; Lcarry<=0; Ercl<=0; Lzf<=0; Lcf<=0;
                  EaCarry<=0; LcarryA<=0; Ejmp<=0;
                  Lpush<=0;Epush<=0;Lpop<=0;Epop<=0;
                  pushstack<=0;popstack<=0;
                  LRam<=0;ERam<=0;LPC<=0;EPC<=0;Ecall<=0;
                end
              4'b1011: //jz address
                begin
                  Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=0;
                  Cei <= 0; Cea<=0; Li <= 0; Ei <= 0;
                  LaRam <= 0; Lab<=0; Eatmp <= 0;
                  Eu <= 0; Lbtmp <= 0; Eba<=0;
                  Ltmpa<=0; Etmpb<=0; LaALU<=0;
                  EaRAM<=0; LA<=0;
                  LtmpRAM<=0; Cetmp<=0; LbALU<=0;
                  LaOUT<=0; EaOut<=0;
                  Ecf<=0; Lcarry<=0; Ercl<=0; Lzf<=0; Lcf<=0;
                  EaCarry<=0; LcarryA<=0; Ejmp<=1;
                  Lpush<=0;Epush<=0;Lpop<=0;Epop<=0;
                  pushstack<=0;popstack<=0;
                  LRam<=0;ERam<=0;LPC<=0;EPC<=0;Ecall<=0;
                end
              4'b1100: //push b
                begin
                  Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=0;
                  Cei <= 0; Cea<=0; Li <= 0; Ei <= 0;
                  LaRam <= 0; Lab<=0; Eatmp <= 0;
                  Eu <= 0; Lbtmp <= 0; Eba<=0;
                  Ltmpa<=0; Etmpb<=0; LaALU<=0;
                  EaRAM<=0; LA<=0;
                  LtmpRAM<=0; Cetmp<=0; LbALU<=0;
                  LaOUT<=0; EaOut<=0;
                  Ecf<=0; Lcarry<=0; Ercl<=0; Lzf<=0; Lcf<=0;
                  EaCarry<=0; LcarryA<=0; Ejmp<=0;
                  Lpush<=1;Epush<=0;Lpop<=0;Epop<=0;
                  pushstack<=0;popstack<=0;
                  LRam<=0;ERam<=0;LPC<=0;EPC<=0;Ecall<=0;
                end
              4'b1101: //pop b
                begin
                  Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=0;
                  Cei <= 0; Cea<=0; Li <= 0; Ei <= 0;
                  LaRam <= 0; Lab<=0; Eatmp <= 0;
                  Eu <= 0; Lbtmp <= 0; Eba<=0;
                  Ltmpa<=0; Etmpb<=0; LaALU<=0;
                  EaRAM<=0; LA<=0;
                  LtmpRAM<=0; Cetmp<=0; LbALU<=0;
                  LaOUT<=0; EaOut<=0;
                  Ecf<=0; Lcarry<=0; Ercl<=0; Lzf<=0; Lcf<=0;
                  EaCarry<=0; LcarryA<=0; Ejmp<=0;
                  Lpush<=0;Epush<=0;Lpop<=0;Epop<=1;
                  pushstack<=0;popstack<=0;
                  LRam<=0;ERam<=0;LPC<=0;EPC<=0;Ecall<=0;
                end
              4'b1110: //call address
                begin
                  Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=0;
                  Cei <= 0; Cea<=0; Li <= 0; Ei <= 0;
                  LaRam <= 0; Lab<=0; Eatmp <= 0;
                  Eu <= 0; Lbtmp <= 0; Eba<=0; 
                  Ltmpa<=0; Etmpb<=0; LaALU<=0;
                  EaRAM<=0; LA<=0;
                  LtmpRAM<=0; Cetmp<=0; LbALU<=0;
                  LaOUT<=0; EaOut<=0;
                  Ecf<=0; Lcarry<=0; Ercl<=0; Lzf<=0; Lcf<=0;
                  EaCarry<=0; LcarryA<=0; Ejmp<=0;
                  Lpush<=0;Epush<=0;Lpop<=0;Epop<=0;
                  pushstack<=1;popstack<=0;
                  LRam<=0;ERam<=0;LPC<=0;EPC<=0;Ecall<=0;
                end
              4'b1111: //ret
                begin
                  Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=0;
                  Cei <= 0; Cea<=0; Li <= 0; Ei <= 0;
                  LaRam <= 0; Lab<=0; Eatmp <= 0;
                  Eu <= 0; Lbtmp <= 0; Eba<=0; 
                  Ltmpa<=0; Etmpb<=0; LaALU<=0;
                  EaRAM<=0; LA<=0;
                  LtmpRAM<=0; Cetmp<=0; LbALU<=0;
                  LaOUT<=0; EaOut<=0;
                  Ecf<=0; Lcarry<=0; Ercl<=0; Lzf<=0; Lcf<=0;
                  EaCarry<=0; LcarryA<=0; Ejmp<=0;
                  Lpush<=0;Epush<=0;Lpop<=0;Epop<=0;
                  pushstack<=0;popstack<=0;
                  LRam<=0;ERam<=0;LPC<=0;EPC<=1;Ecall<=0;
                end
            endcase
          end
        6'b100000:
          begin
            case(IR_to_Control)
              4'b0111: //mov a,address
                begin
                  Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=0;
                  Cei <= 0; Cea<=0; Li <= 0; Ei <= 0;
                  LaRam <= 0; Lab<=0; Eatmp <= 0; 
                  Eu <= 0; Lbtmp <= 0; Eba<=0; 
                  Ltmpa<=0; Etmpb<=0; LaALU<=0; 
                  EaRAM<=0; LA<=0;
                  LtmpRAM<=0; Cetmp<=0; LbALU<=0;
                  Ecf<=0; Lcarry<=0; Ercl<=0; Lzf<=0; Lcf<=0;
                  EaCarry<=0; LcarryA<=0; Ejmp<=0;
                  Lpush<=0;Epush<=0;Lpop<=0;Epop<=0;
                  pushstack<=0;popstack<=0;
                  LRam<=0;ERam<=0;LPC<=0;EPC<=0;Ecall<=0;
                end
              4'b0011: //xchg a,b(mov b,tmp)
                begin
                  Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=0;
                  Cei <= 0; Cea<=0; Li <= 0; Ei <= 0;
                  LaRam <= 0; Lab<=0; Eatmp <= 0; 
                  Eu <= 0; Lbtmp <= 1; Eba<=0;
                  Ltmpa<=0; Etmpb<=1; LaALU<=0; 
                  EaRAM<=0; LA<=0;
                  LtmpRAM<=0; Cetmp<=0; LbALU<=0;
                  Ecf<=0; Lcarry<=0; Ercl<=0; Lzf<=0; Lcf<=0;
                  EaCarry<=0; LcarryA<=0; Ejmp<=0;
                  Lpush<=0;Epush<=0;Lpop<=0;Epop<=0;
                  pushstack<=0;popstack<=0;
                  LRam<=0;ERam<=0;LPC<=0;EPC<=0;Ecall<=0;
                end
              4'b0001: //add a,b
                begin
                  Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=0;
                  Cei <= 0; Cea<=0; Li <= 0; Ei <= 0;
                  LaRam <= 0; Lab<=0; Eatmp <= 0;
                  Eu <= 0; Lbtmp <= 0; Eba<=0;
                  Ltmpa<=0; Etmpb<=0; LaALU<=0;
                  EaRAM<=0; LA<=0;
                  LtmpRAM<=0; Cetmp<=0; LbALU<=0;
                  Ecf<=0; Lcarry<=0; Ercl<=0; Lzf<=0; Lcf<=0;
                  EaCarry<=0; LcarryA<=0; Ejmp<=0;
                  Lpush<=0;Epush<=0;Lpop<=0;Epop<=0;
                  pushstack<=0;popstack<=0;
                  LRam<=0;ERam<=0;LPC<=0;EPC<=0;Ecall<=0;
                end
              4'b0010: //sub a,b
                begin
                  Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=0;
                  Cei <= 0; Cea<=0; Li <= 0; Ei <= 0;
                  LaRam <= 0; Lab<=0; Eatmp <= 0; 
                  Eu <= 0; Lbtmp <= 0; Eba<=0;
                  Ltmpa<=0; Etmpb<=0; LaALU<=0;
                  EaRAM<=0; LA<=0;
                  LtmpRAM<=0; Cetmp<=0; LbALU<=0;
                  Ecf<=0; Lcarry<=0; Ercl<=0; Lzf<=0; Lcf<=0;
                  EaCarry<=0; LcarryA<=0; Ejmp<=0;
                  Lpush<=0;Epush<=0;Lpop<=0;Epop<=0;
                  pushstack<=0;popstack<=0;
                  LRam<=0;ERam<=0;LPC<=0;EPC<=0;Ecall<=0;
                end
              4'b1000: //and a,b
                begin
                  Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=0;
                  Cei <= 0; Cea<=0; Li <= 0; Ei <= 0;
                  LaRam <= 0; Lab<=0; Eatmp <= 0;
                  Eu <= 0; Lbtmp <= 0; Eba<=0; 
                  Ltmpa<=0; Etmpb<=0; LaALU<=0;
                  EaRAM<=0; LA<=0;
                  LtmpRAM<=0; Cetmp<=0; LbALU<=0;
                  Ecf<=0; Lcarry<=0; Ercl<=0; Lzf<=0; Lcf<=0;
                  EaCarry<=0; LcarryA<=0; Ejmp<=0;
                  Lpush<=0;Epush<=0;Lpop<=0;Epop<=0;
                  pushstack<=0;popstack<=0;
                  LRam<=0;ERam<=0;LPC<=0;EPC<=0;Ecall<=0;
                end
              4'b0110: //mov address, a
                begin
                  Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=0;
                  Cei <= 0; Cea<=0; Li <= 0; Ei <= 0;
                  LaRam <= 0; Lab<=0; Eatmp <= 0; 
                  Eu <= 0; Lbtmp <= 0; Eba<=0; 
                  Ltmpa<=0; Etmpb<=0; LaALU<=0;
                  EaRAM<=0; LA<=0;
                  LtmpRAM<=0; Cetmp<=0; LbALU<=0;
                  Ecf<=0; Lcarry<=0; Ercl<=0; Lzf<=0; Lcf<=0;
                  EaCarry<=0; LcarryA<=0; Ejmp<=0;
                  Lpush<=0;Epush<=0;Lpop<=0;Epop<=0;
                  pushstack<=0;popstack<=0;
                  LRam<=0;ERam<=0;LPC<=0;EPC<=0;Ecall<=0;
                end
              4'b1001: //or b, [address]
                begin
                  Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=0;
                  Cei <= 0; Cea<=0; Li <= 0; Ei <= 0;
                  LaRam <= 0; Lab<=0; Eatmp <= 0;
                  Eu <= 1; Lbtmp <= 0; Eba<=0; 
                  Ltmpa<=0; Etmpb<=0; LaALU<=0;
                  EaRAM<=0; LA<=0; LtmpRAM<=0; Cetmp<=0;
                  LtmpRAM<=0; Cetmp<=0; LbALU<=1;
                  Ecf<=0; Lcarry<=0; Ercl<=0; Lzf<=0; Lcf<=0;
                  EaCarry<=0; LcarryA<=0; Ejmp<=0;
                  Lpush<=0;Epush<=0;Lpop<=0;Epop<=0;
                  pushstack<=0;popstack<=0;
                  LRam<=0;ERam<=0;LPC<=0;EPC<=0;Ecall<=0;
                end
              4'b1010: //out a
                begin
                  Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=0;
                  Cei <= 0; Cea<=0; Li <= 0; Ei <= 0;
                  LaRam <= 0; Lab<=0; Eatmp <= 0; 
                  Eu <= 0; Lbtmp <= 0; Eba<=0; 
                  Ltmpa<=0; Etmpb<=0; LaALU<=0;
                  EaRAM<=0; LA<=0;
                  LtmpRAM<=0; Cetmp<=0; LbALU<=0;
                  LaOUT<=0; EaOut<=0;
                  Ecf<=0; Lcarry<=0; Ercl<=0; Lzf<=0; Lcf<=0;
                  EaCarry<=0; LcarryA<=0; Ejmp<=0;
                  Lpush<=0;Epush<=0;Lpop<=0;Epop<=0;
                  pushstack<=0;popstack<=0;
                  LRam<=0;ERam<=0;LPC<=0;EPC<=0;Ecall<=0;
                end
              4'b0000: //hlt
                begin
                  Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=0;
                  Cei <= 0; Cea<=0; Li <= 0; Ei <= 0;
                  LaRam <= 0; Lab<=0; Eatmp <= 0; 
                  Eu <= 0; Lbtmp <= 0; Eba<=0; 
                  Ltmpa<=0; Etmpb<=0; LaALU<=0;
                  EaRAM<=0; LA<=0;
                  LtmpRAM<=0; Cetmp<=0; LbALU<=0;
                  LaOUT<=0; EaOut<=0; 
                  Ecf<=0; Lcarry<=0; Ercl<=0; Lzf<=0; Lcf<=0;
                  EaCarry<=0; LcarryA<=0; Ejmp<=0;
                  Lpush<=0;Epush<=0;Lpop<=0;Epop<=0;
                  pushstack<=0;popstack<=0;
                  LRam<=0;ERam<=0;LPC<=0;EPC<=0;Ecall<=0;
                end
              4'b0100: //rcl b
                begin
                  Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=0;
                  Cei <= 0; Cea<=0; Li <= 0; Ei <= 0;
                  LaRam <= 0; Lab<=0; Eatmp <= 0; 
                  Eu <= 0; Lbtmp <= 0; Eba<=0; 
                  Ltmpa<=0; Etmpb<=0; LaALU<=0;
                  EaRAM<=0; LA<=0;
                  LtmpRAM<=0; Cetmp<=0; LbALU<=0;
                  LaOUT<=0; EaOut<=0;
                  Ecf<=0; Lcarry<=0; Ercl<=0; Lzf<=0; Lcf<=0;
                  EaCarry<=0; LcarryA<=0; Ejmp<=0;
                  Lpush<=0;Epush<=0;Lpop<=0;Epop<=0;
                  pushstack<=0;popstack<=0;
                  LRam<=0;ERam<=0;LPC<=0;EPC<=0;Ecall<=0;
                end
              4'b0101: //shr a
                begin
                  Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=0;
                  Cei <= 0; Cea<=0; Li <= 0; Ei <= 0;
                  LaRam <= 0; Lab<=0; Eatmp <= 0;
                  Eu <= 0; Lbtmp <= 0; Eba<=0;
                  Ltmpa<=0; Etmpb<=0; LaALU<=0;
                  EaRAM<=0; LA<=0;
                  LtmpRAM<=0; Cetmp<=0; LbALU<=0;
                  LaOUT<=0; EaOut<=0;
                  Ecf<=0; Lcarry<=0; Ercl<=0; Lzf<=0; Lcf<=0;
                  EaCarry<=0; LcarryA<=0; Ejmp<=0;
                  Lpush<=0;Epush<=0;Lpop<=0;Epop<=0;
                  pushstack<=0;popstack<=0;
                  LRam<=0;ERam<=0;LPC<=0;EPC<=0;Ecall<=0;
                end
              4'b1011: //jz address
                begin
                  Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=0;
                  Cei <= 0; Cea<=0; Li <= 0; Ei <= 0;
                  LaRam <= 0; Lab<=0; Eatmp <= 0;
                  Eu <= 0; Lbtmp <= 0; Eba<=0; 
                  Ltmpa<=0; Etmpb<=0; LaALU<=0;
                  EaRAM<=0; LA<=0;
                  LtmpRAM<=0; Cetmp<=0; LbALU<=0;
                  LaOUT<=0; EaOut<=0;
                  Ecf<=0; Lcarry<=0; Ercl<=0; Lzf<=0; Lcf<=0;
                  EaCarry<=0; LcarryA<=0; Ejmp<=0;
                  Lpush<=0;Epush<=0;Lpop<=0;Epop<=0;
                  pushstack<=0;popstack<=0;
                  LRam<=0;ERam<=0;LPC<=0;EPC<=0;Ecall<=0;
                end
              4'b1100: //push b
                begin
                  Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=0;
                  Cei <= 0; Cea<=0; Li <= 0; Ei <= 0;
                  LaRam <= 0; Lab<=0; Eatmp <= 0; 
                  Eu <= 0; Lbtmp <= 0; Eba<=0;
                  Ltmpa<=0; Etmpb<=0; LaALU<=0;
                  EaRAM<=0; LA<=0;
                  LtmpRAM<=0; Cetmp<=0; LbALU<=0;
                  LaOUT<=0; EaOut<=0;
                  Ecf<=0; Lcarry<=0; Ercl<=0; Lzf<=0; Lcf<=0;
                  EaCarry<=0; LcarryA<=0; Ejmp<=0;
                  Lpush<=0;Epush<=0;Lpop<=0;Epop<=0;
                  pushstack<=1;popstack<=0;
                  LRam<=0;ERam<=0;LPC<=0;EPC<=0;Ecall<=0;
                end
              4'b1101: //pop b
                begin
                  Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=0;
                  Cei <= 0; Cea<=0; Li <= 0; Ei <= 0;
                  LaRam <= 0; Lab<=0; Eatmp <= 0; 
                  Eu <= 0; Lbtmp <= 0; Eba<=0; 
                  Ltmpa<=0; Etmpb<=0; LaALU<=0;
                  EaRAM<=0; LA<=0;
                  LtmpRAM<=0; Cetmp<=0; LbALU<=0;
                  LaOUT<=0; EaOut<=0;
                  Ecf<=0; Lcarry<=0; Ercl<=0; Lzf<=0; Lcf<=0;
                  EaCarry<=0; LcarryA<=0; Ejmp<=0;
                  Lpush<=0;Epush<=0;Lpop<=1;Epop<=0;
                  pushstack<=0;popstack<=0;
                  LRam<=0;ERam<=0;LPC<=0;EPC<=0;Ecall<=0;
                end
              4'b1110: //call address
                begin
                  Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=0;
                  Cei <= 0; Cea<=0; Li <= 0; Ei <= 0;
                  LaRam <= 0; Lab<=0; Eatmp <= 0;
                  Eu <= 0; Lbtmp <= 0; Eba<=0;
                  Ltmpa<=0; Etmpb<=0; LaALU<=0;
                  EaRAM<=0; LA<=0;
                  LtmpRAM<=0; Cetmp<=0; LbALU<=0;
                  LaOUT<=0; EaOut<=0;
                  Ecf<=0; Lcarry<=0; Ercl<=0; Lzf<=0; Lcf<=0;
                  EaCarry<=0; LcarryA<=0; Ejmp<=0;
                  Lpush<=0;Epush<=0;Lpop<=0;Epop<=0;
                  pushstack<=0;popstack<=0;
                  LRam<=0;ERam<=0;LPC<=0;EPC<=0;Ecall<=1;
                end
              4'b1111: //ret
                begin
                  Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=0;
                  Cei <= 0; Cea<=0; Li <= 0; Ei <= 0;
                  LaRam <= 0; Lab<=0; Eatmp <= 0;
                  Eu <= 0; Lbtmp <= 0; Eba<=0;
                  Ltmpa<=0; Etmpb<=0; LaALU<=0;
                  EaRAM<=0; LA<=0;
                  LtmpRAM<=0; Cetmp<=0; LbALU<=0;
                  LaOUT<=0; EaOut<=0;
                  Ecf<=0; Lcarry<=0; Ercl<=0; Lzf<=0; Lcf<=0;
                  EaCarry<=0; LcarryA<=0; Ejmp<=0;
                  Lpush<=0;Epush<=0;Lpop<=0;Epop<=0;
                  pushstack<=0;popstack<=0;
                  LRam<=1;ERam<=0;LPC<=0;EPC<=0;Ecall<=0;
                end
            endcase
          end
        
        default:
          begin
            Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=0;
            Cei <= 0; Cea<=0; Li <= 0; Ei <= 0;
            LaRam <= 0; Lab<=0; Eatmp <= 0;
            Eu <= 0; Lbtmp <= 0; Eba<=0;
            Ltmpa<=0; Etmpb<=0; LaALU<=0; 
            EaRAM<=0; LA<=0;
            LtmpRAM<=0; Cetmp<=0; LbALU<=0;
            LaOUT<=0; EaOut<=0;
            Ecf<=0; Lcarry<=0; Ercl<=0; Lzf<=0; Lcf<=0;
            EaCarry<=0; LcarryA<=0; Ejmp<=0;
            Lpush<=0;Epush<=0;Lpop<=0;Epop<=0;
            pushstack<=0;popstack<=0;
            LRam<=0;ERam<=0;LPC<=0;EPC<=0;Ecall<=0;
          end
      endcase
    end
endmodule


module ProgramCounter(clk, reset, Ep, ERam, LRam, Ecall, Cp, Ejmp, IR_operand, Z_from_ALU, PC_to_MAR, HLT, PC_to_RAM, RAM_to_PC);
  input clk, reset, Ep, ERam, LRam, Ecall, Cp, Ejmp, HLT, Z_from_ALU;
  //ERam = Send and save return address to RAM
  //LRam = Load return address from RAM
  //Ejmp = Jump Instruction control signal
  output[3:0] PC_to_MAR;
  output[3:0] PC_to_RAM; //for storing return address to stack
  input[3:0] IR_operand;
  input[3:0] RAM_to_PC;
  reg[3:0] count_buffer; 
  reg[3:0] count;
  reg first = 1'b0;
  
  reg[3:0] ret_address;
  
  initial
    begin
      count_buffer = 4'bzzzz;
      count = 4'b0000;
    end
  
  assign PC_to_MAR = count_buffer; 
  assign PC_to_RAM = ret_address;
  
  always@(posedge clk)
    begin
      if(Ep)
        begin
          count_buffer <= count; 
        end
      else if(ERam)
        begin
          ret_address <= count; //saving return address
        end
      else if(LRam)
        begin
          count <= RAM_to_PC; //restoring return address
        end
      else if(Ecall)
        begin
          count <= IR_operand; //jumping to call address
        end
      else if(Cp)  
        begin
          count <= (count == 4'b1111) ? 4'b0000 : count + 4'b0001;
        end
      else if(HLT)
        begin
          if(~first)
            begin
              count <= count - 4'b0001;
              first <= 1;
            end
          else
            begin
              count <= count;
            end
        end
      else if(Ejmp)
        begin
          if(Z_from_ALU)
            begin
              //$display("%4b", IR_operand);
              count <= IR_operand; //for handling jump instruction
            end
        end
    end
   
  always@(negedge reset)
    begin
      if(~reset) 
        begin
          count<=4'b0;
          first <= 1'b0;
          ret_address<=4'bzzzz;
        end
    end
  
endmodule


module MAR(clk, Lmp, Lmi, PC_to_MAR, IR_to_MAR, MAR_to_RAM);
  
  input clk, Lmp, Lmi;
  input [3:0]  PC_to_MAR;
  input[3:0] IR_to_MAR;
  output [3:0] MAR_to_RAM;

  reg [3:0] address = 4'b0000;

  assign MAR_to_RAM = address;

  always @(*) 
    begin
      //$display("Ei block e asche");
      //$display("from_PC=%8b, lm=%b", from_PC, Lm);
      if(Lmp)
        //$display("Ei block e asche");
        begin
          address <= PC_to_MAR;
        end
      else if(Lmi)
        begin
          address <= IR_to_MAR;
        end
    end
   
endmodule

module RAM(input_mode, input_address, input_program, clk, Cei, Cea, Cetmp, LA, Lpush, Epop, LPC, EPC, pushstack, popstack, MAR_to_RAM, RAM_to_IR, RAM_to_A, A_to_RAM, B_to_RAM, RAM_to_B, RAM_to_TMP, PC_to_RAM, RAM_to_PC);
  
  input input_mode;
  input[3:0] input_address;
  input[7:0] input_program;
  input clk,Cei, Cea, Cetmp, LA, Lpush, LPC, EPC, Epop, pushstack, popstack;  
  //LA=load from A, Cei=Send to Instruction Register, Cea=Send to A, Cetmp = Send to TMP, Lpush=Load B into stack, Epop=Send current value pointed by SP to B, pushstack=Decrease SP, LPC=Load current address into stack(for ret), EPC = Send return address back to PC
  input[3:0] PC_to_RAM;
  input[3:0] MAR_to_RAM;
  input[3:0] A_to_RAM; //mov [address], a
  input[3:0] B_to_RAM;
  output[7:0] RAM_to_IR;
  output[3:0] RAM_to_A; //mov a, [address]
  output[3:0] RAM_to_TMP; //needed for OR B, [Address]
  output[3:0] RAM_to_B; //pop b
  output[3:0] RAM_to_PC;
  
  reg[7:0] ram[0:15];
  reg[7:0] dataIR = 8'bzzzz_zzzz;
  reg[3:0] dataA = 4'bzzzz;
  reg[3:0] dataTMP = 4'bzzzz;
  reg[3:0] StackPointer;
  reg[3:0] dataB;
  reg[3:0] ret_address;
  
  assign RAM_to_IR = dataIR;
  assign RAM_to_A = dataA;
  assign RAM_to_TMP = dataTMP;
  assign RAM_to_B = dataB;
  assign RAM_to_PC = ret_address;
  
  integer address;
  
  initial
    begin
      for(address=0;address<16;address=address+1)
        begin
          ram[address] <= 8'b0;
        end
      StackPointer <= 4'b1111;
    end
  
  always@(*)
    begin
      if(input_mode)
        begin
          ram[input_address] <= input_program;
        end
    end
  
  always@(*)
    begin
      if(LA)
        begin
          ram[MAR_to_RAM] <= {4'b0000, A_to_RAM}; //mov [address], a
        end
      else if(Lpush)
        begin
          //$display("B_to_RAM=%4b", B_to_RAM);
          //$display("StackPointer=%4b", StackPointer);
          ram[StackPointer] = {4'b0000, B_to_RAM}; //push b
          //$display("RAM[StackPointer]=%4b", ram[StackPointer]);
        end
      else if(LPC)
        begin
          //$display("%4b", StackPointer);
          ram[StackPointer] = {4'b0000, PC_to_RAM};
        end
    end
  
  always@(posedge clk)
    begin
      if(Cei)
        begin
          //$display("RAM access kortese");
          //$display("MARout=%4b", MAR_to_RAM);
          //$display("Data at location=%8b", ram[MAR_to_RAM]);
          dataIR<=ram[MAR_to_RAM];
          //$display("%8b", ram[MAR_to_RAM]);
        end
      else if(Cea)
        begin
          dataA<=ram[MAR_to_RAM][3:0];
          //$display("%4b", ram[MAR_to_RAM][3:0]);
        end
      else if(Cetmp)
        begin
          dataTMP <= ram[MAR_to_RAM][3:0];
        end
      else if(pushstack)
        begin
          //$display("Decreasing SP=%4b", StackPointer);
          StackPointer <= StackPointer - 4'b0001;
        end
      else if(popstack)
        begin
          //$display("Increasing SP=%4b", StackPointer);
          StackPointer <= StackPointer + 4'b0001;
        end
      else if(Epop)
        begin
          dataB <= ram[StackPointer][3:0];
        end
      else if(EPC)
        begin
          ret_address <= ram[StackPointer][3:0];
        end
      else
        begin
          dataIR<=8'bzzzz_zzzz;
          dataA<=4'bzzzz;
        end
    end
endmodule

module InstructionRegister(clk, RAM_to_IR, Li, Ei, reset, IR_to_Control, IR_operand);
  
  input[7:0] RAM_to_IR;
  input clk, Li, Ei, reset; //Li=Load from RAM, Ei=Send to BUS and CS
  output[3:0] IR_to_Control;
  output[3:0] IR_operand;
  
  reg[3:0] opcode;
  reg[3:0] operand;
  reg[3:0] address_field;
  
  assign IR_to_Control = opcode;
  assign IR_operand = address_field;
  
  always@(*)
    begin
      if(Li)
        begin
          //$display("IR theke control e charbe");
          //$display("Instruction=%8b, Opcode=%4b", instruction, opcode);
          opcode <= RAM_to_IR[7:4];
          operand <= RAM_to_IR[3:0];
        end
    end
  
  
  always@(posedge clk)
    begin
      if(Ei)
        begin
          address_field<=operand;
        end
    end
  
   
  always@(negedge reset)
    begin
      if(~reset)
        begin
          opcode <= 4'bzzzz;
          operand <= 4'bzzzz;
          address_field<=4'bzzzz;
        end
    end
endmodule

module ARegister(clk, RAM_to_A, B_to_A, LaRam, Lab, LaALU, Eatmp, EaRAM, EaOut, EaCarry, reset, A_to_ALU, A_to_TMP, ALU_to_A, A_to_RAM, A_to_OUT, Carry_from_A);
  
  input[3:0] RAM_to_A;
  input[3:0] ALU_to_A;
  input[3:0] B_to_A;
  input clk,  LaRam, Lab, LaALU, Eatmp, reset, EaRAM, EaOut, EaCarry; //Li=Load from RAM, Eatmp=Send to TMP and CS
  //EaRam = Send data to RAM, EaCarry= For SHR A, send LSB to Flag Register to update carry
  output[3:0] A_to_ALU;
  output[3:0] A_to_TMP;
  output[3:0] A_to_RAM;
  output[3:0] A_to_OUT;
  output Carry_from_A;
  
  reg[3:0] dataA;
  reg[3:0] dataTMP;
  reg[3:0] dataRAM;
  reg[3:0] dataOut;
  reg carry;
  
  assign A_to_ALU = dataA;
  assign A_to_TMP = dataTMP;
  assign A_to_RAM = dataRAM;
  assign A_to_OUT = dataOut;
  assign Carry_from_A = carry;
  
  always@(*)
    begin
      if(LaRam)
        begin
          //$display("LaRam e dhuke gese");
          //$display("IR theke control e charbe");
          //$display("Instruction=%8b, Opcode=%4b", instruction, opcode);
          dataA <= RAM_to_A;
          //$display("dataA=%4b", dataA);
        end
      else if(Lab)
        begin
          //$display("%4b", B_to_A);
          //$display("Lab e dhuke gese");
          dataA <= B_to_A;
        end
    end

  always@(posedge clk)
    begin
      if(Eatmp)
        begin
          dataTMP<=dataA; //Send to Tmp to exchange a,b
        end
      else if(EaRAM)
        begin
          dataRAM <= dataA; //Send to RAM
        end
      else if(EaOut)
        begin
          dataOut<= dataA; //OUT A
        end
      else if(EaCarry)
        begin
          carry<=dataA[0];
          dataA[0]<=dataA[1];
          dataA[1]<=dataA[2];
          dataA[2]<=dataA[3];
          dataA[3]<=0;
        end
      else if(LaALU)
        begin
          //$display("LaAlu e dhuke gese");
          //$display("dataA=%4b", dataA);
          dataA <= ALU_to_A;
          //$display("dataA=%4b", dataA);
        end
    end

  always@(negedge reset)
    begin
      if(~reset)
        begin
          dataA<=4'bzzzz;
          dataTMP<=4'bzzzz;
          dataRAM <= 4'bzzzz;
          dataOut<=8'bzzzz;
        end
    end
endmodule

module TMPRegister(clk, A_to_TMP, Ltmpa, LtmpRAM, Etmpb, reset, TMP_to_B, TMP_to_ALU, RAM_to_TMP);
  
  input[3:0] A_to_TMP;
  input[3:0] RAM_to_TMP;
  input clk, Ltmpa, Etmpb, LtmpRAM, reset; //Ltmpa=Load from A, Etmp=Send to B, LtmpRAM=Load from Ram to tmp
  output[3:0] TMP_to_B;
  output[3:0] TMP_to_ALU;
  //output[3:0] ;
  
  reg[3:0] dataTMP;
  reg[3:0] dataOut; //out to b
  
  assign TMP_to_B = dataOut;
  assign TMP_to_ALU = dataTMP;
  //assign BUS[3:0] = dataOut;
  
  always@(*)
    begin
      if(Ltmpa)
        begin
          dataTMP <= A_to_TMP;
        end
      else if(LtmpRAM)
        begin
          dataTMP <= RAM_to_TMP;
        end
    end

  always@(posedge clk)
    begin
      if(Etmpb)
        begin
          dataOut<=dataTMP;
        end
    end

  always@(negedge reset)
    begin
      if(~reset)
        begin
          dataTMP<=4'bzzzz;
          dataOut<=4'bzzzz;
        end
    end
endmodule

module BRegister(clk, TMP_to_B, Lbtmp, LbALU, Lcarry, Eba, Epush, Lpop, reset, B_to_A, B_to_ALU, ALU_to_B, Carry_to_Reg, Ercl, Carry_from_B, B_to_RAM, RAM_to_B);
  
  input[3:0] TMP_to_B;
  input[3:0] ALU_to_B;
  input[3:0] RAM_to_B;
  input clk, Lbtmp, LbALU, Lcarry, Eba, Epush, Lpop, reset; //Ltmp=Load from A, Etmp=Send to B
  input Ercl, Carry_to_Reg;//Ercl=ready to rotate left, Epush=Send B to stack, Lpop=Load B from stack
  output Carry_from_B;
  output[3:0] B_to_A;
  output[3:0] B_to_ALU;
  output[3:0] B_to_RAM;
  //output[3:0] ;
  
  reg[3:0] dataB;
  reg[3:0] dataBtoA;
  reg[3:0] dataBtoRAM;
  reg Carry;
  reg CB;
  
  assign B_to_A = dataBtoA;
  assign B_to_RAM = dataBtoRAM;
  assign B_to_ALU = dataB;
  assign Carry_from_B = CB;
  //assign BUS[3:0] = dataOut;
  
  always@(*)
    begin
      if(Lbtmp)
        begin
          dataB <= TMP_to_B;
        end
      else if(Lcarry)
        begin
          Carry <= Carry_to_Reg;
        end
    end

  always@(posedge clk)
    begin
      if(Eba)
        //$display("Dhukse");
        begin
          dataBtoA<=dataB;
        end
      else if(Ercl)
        begin
          CB <= dataB[3];
          dataB[3] <= dataB[2];
          dataB[2] <= dataB[1];
          dataB[1] <= dataB[0];
          dataB[0] <= Carry;
        end
      else if(Epush)
        begin
          dataBtoRAM <= dataB; 
        end
      else if(Lpop)
        begin
          dataB <= RAM_to_B;
        end
      else if(LbALU)
        begin
          //$display("%4b", ALU_to_B);
          dataB <= ALU_to_B; //OR B,[Address]
        end
    end

  always@(negedge reset)
    begin
      if(~reset)
        begin
          dataB<=4'b0000; //b is reset to zero
          dataBtoA<=4'bzzzz;
          dataBtoRAM <= 4'bzzzz;
        end
    end
endmodule

module FlagRegister(clk, reset, Z_from_ALU, Carry_from_ALU, Carry_to_Reg, Carry_from_B,Carry_from_A, Ercl, Lzf, Ecf, Lcf, LcarryA);
  
  input clk, reset, Ercl, Lzf, Ecf, Lcf, LcarryA;
  input Z_from_ALU, Carry_from_ALU, Carry_from_B, Carry_from_A;
  output Carry_to_Reg;
  
  reg zz, cy;
  reg zero;
  reg carry;
  
  //assign Z_to_B = zz;
  assign Carry_to_Reg = carry;      
  
  always@(*)
    begin
      if(Lcf) //update both zero and carry flag
        begin
          zz<=Z_from_ALU;
          cy<=Carry_from_ALU;
        end
      else if(Lzf) //update zero flag
        begin
          zz <= Z_from_ALU;
        end
      else if(LcarryA)
        begin
          cy <= Carry_from_A;
        end
      else if(Ercl)
        begin
          cy <= Carry_from_B;
        end
    end
  
  always@(posedge clk)
    begin
      if(Ecf)
        begin
          zero<=zz;
          carry<=cy;
        end
    end
  
  always@(negedge reset)
    begin
      if(~reset)
        begin
          zero<=1'b0;
          carry<=1'b0;
        end
    end
    

endmodule

module ALU(clk, reset, A_to_ALU, B_to_ALU, TMP_to_ALU, IR_to_Control, Eu, ALU_to_A, ALU_to_B, Z_from_ALU, Carry_from_ALU);
  input[3:0] A_to_ALU;
  input[3:0] B_to_ALU;
  input[3:0] TMP_to_ALU;
  input[3:0] IR_to_Control;
  input clk, Eu, reset;
  output[3:0] ALU_to_A;
  output[3:0] ALU_to_B;
  //output reg ALU_to_F_Cout;
  output Z_from_ALU, Carry_from_ALU;
  
  assign Z_from_ALU = zz;
  assign Carry_from_ALU = cy;
  
  reg zero_flag, zz;
  reg carry_flag=1'b0;
  reg cy=1'b0;
  
  reg[3:0] result;
  reg[3:0] resultOut;
  //reg Carryout=1'b0;
  
  assign ALU_to_A = resultOut;
  assign ALU_to_B = resultOut;
  //assign ALU_to_F_Cout=Carryout;
  
  task add_sub;
    input[3:0] A;
    input[3:0] B;
    input Carryin;
    output reg Carryout;
    output reg[3:0] Sum;
    
    reg[3:0] BB;
    
    begin
      if(Carryin==1) BB = ~B;
      else BB = B;
      
      {Carryout, Sum} = A + BB + Carryin;
    end
  endtask
  
  always@(posedge clk)
    begin
      if(Eu)
        begin
          if(IR_to_Control==4'b0001)
            begin
              add_sub(A_to_ALU, B_to_ALU, 0, carry_flag, result);
              if (result==4'b0000)
                begin
                  zero_flag=1;
                end
              else zero_flag=0;
            end
          else if(IR_to_Control==4'b0010)
            begin
              add_sub(A_to_ALU, B_to_ALU, 1, carry_flag, result);
              if (result==4'b0000)
                begin
                  zero_flag=1;
                end
              else zero_flag=0;
            end
          else if(IR_to_Control==4'b1000)
            begin
              result = A_to_ALU&B_to_ALU;
              if (result==4'b0000)
                begin
                  zero_flag=1;
                end
              else zero_flag=0;
            end
          else if(IR_to_Control==4'b1001)
            begin
              //$display("TMP=%4b,B=%4b",TMP_to_ALU,B_to_ALU);
              result = TMP_to_ALU | B_to_ALU; //OR B, [Address] 
              //$display("%4b", result);
              if (result==4'b0000)
                begin
                  zero_flag=1;
                end
              else zero_flag=0;
            end
          resultOut = result;
          //$display("%4b", resultOut);
          zz = zero_flag;
          cy = carry_flag;
        end
    end
  
  always@(negedge reset)
    begin
      if(~reset)
        begin
          resultOut<=4'bzzzz;
          zz<=1'b0;
          cy<=1'b0;
        end
    end
  
endmodule

module OUTRegister(clk, reset, A_to_OUT, LaOUT, OUT_to_disp);
  input clk, reset;
  input[3:0] A_to_OUT;
  input LaOUT;
  output[3:0] OUT_to_disp;
  
  reg[3:0] dataDisp;
  
  assign OUT_to_disp = dataDisp;
  
  always@(posedge clk)
    begin
      if(LaOUT)
        begin
          dataDisp<=A_to_OUT;
        end
      /*else
        begin
          dataDisp<=4'bzzzz;
        end*/
    end
  
  always@(negedge reset)
    begin
      if(~reset) dataDisp<=4'bzzzz;
    end
  
endmodule