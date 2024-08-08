// Code your design here
module ControlSequencer(clk, reset, IR_to_Control, Cp, Ep, Lmp, Lmi, Cei, Cea, Li, Ei, LaRam, Lab, LaALU, Eatmp, Su, Eu, Lbtmp, Eba, Lo, Ltmpa, Etmpb, EaRAM, LA, LtmpRAM, Cetmp, LbALU, LaOUT, EaOut, HLT, Ercl, Lzf, Ecf, Lcf, Lcarry);
  
  input clk, reset;
  input [3:0] IR_to_Control;
  output reg Cp, Ep, Lmp, Lmi, Cei, Cea, Li, Ei, LaRam, Lab, LaALU, Eatmp, Su, Eu, Lbtmp, Eba, Lo, Ltmpa, Etmpb, EaRAM, LA, LtmpRAM, Cetmp, LbALU, LaOUT, EaOut, HLT, Ercl, Lzf, Ecf, Lcf, Lcarry;
  
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
            LaRam <= 0; Lab<=0; Eatmp <= 0; Su <= 0;
            Eu <= 0; Lbtmp <= 0; Eba<=0; Lo <= 0;
            Ltmpa<=0; Etmpb<=0; LaALU<=0;
            EaRAM<=0; LA<=0;
            LtmpRAM<=0; Cetmp<=0; LbALU<=0;
            LaOUT<=0; EaOut<=0; 
            Ecf<=0; Lcarry<=0; Ercl<=0; Lzf<=0; Lcf<=0;
          end
        6'b000010:
          begin
            //$display("Ekhane asche");
            case(HLT)
              1'b0:
                begin
                  Cp <= 1; Ep <= 0; Lmp <= 0; Lmi<=0;
                  Cei <= 0; Cea<=0; Li <= 0; Ei <= 0;
                  LaRam <= 0; Lab<=0; Eatmp <= 0; Su <= 0;
                  Eu <= 0; Lbtmp <= 0; Eba<=0; Lo <= 0;
                  Ltmpa<=0; Etmpb<=0; LaALU<=0;
                  EaRAM<=0; LA<=0;
                  LtmpRAM<=0; Cetmp<=0; LbALU<=0;
                  LaOUT<=0; EaOut<=0;
                  Ecf<=0; Lcarry<=0; Ercl<=0; Lzf<=0; Lcf<=0;
                end
              1'b1:
                begin
                  Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=0;
                  Cei <= 0; Cea<=0; Li <= 0; Ei <= 0;
                  LaRam <= 0; Lab<=0; Eatmp <= 0; Su <= 0;
                  Eu <= 0; Lbtmp <= 0; Eba<=0; Lo <= 0;
                  Ltmpa<=0; Etmpb<=0; LaALU<=0;
                  EaRAM<=0; LA<=0;
                  LtmpRAM<=0; Cetmp<=0; LbALU<=0;
                  LaOUT<=0; EaOut<=0;
                  Ecf<=0; Lcarry<=0; Ercl<=0; Lzf<=0; Lcf<=0;
                end
            endcase
          end
        6'b000100:
          begin
            Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=0;
            Cei <= 1; Cea<=0; Li <= 1; Ei <= 0;
            LaRam <= 0; Lab<=0; Eatmp <= 0; Su <= 0;
            Eu <= 0; Lbtmp <= 0; Eba<=0; Lo <= 0;
            Ltmpa<=0; Etmpb<=0; LaALU<=0;
            EaRAM<=0; LA<=0;
            LtmpRAM<=0; Cetmp<=0; LbALU<=0;
            LaOUT<=0; EaOut<=0;
            Ecf<=0; Lcarry<=0; Ercl<=0; Lzf<=0; Lcf<=0;
          end
        
        6'b001000:
          begin
            case(IR_to_Control)
              4'b0111: //mov a, [address]
                begin
                  Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=1;
                  Cei <= 0; Cea<=0; Li <= 0; Ei <= 1;
                  LaRam <= 0; Lab<=0; Eatmp <= 0; Su <= 0;
                  Eu <= 0; Lbtmp <= 0; Eba<=0; Lo <= 0;
                  Ltmpa<=0; Etmpb<=0; LaALU<=0; 
                  EaRAM<=0; LA<=0;
                  LtmpRAM<=0; Cetmp<=0; LbALU<=0;
                  LaOUT<=0; EaOut<=0;
                  Ecf<=0; Lcarry<=0; Ercl<=0; Lzf<=0; Lcf<=0;
                end
              4'b0011: //xchg a,b(mov tmp,a)
                begin
                  Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=0;
                  Cei <= 0; Cea<=0; Li <= 0; Ei <= 0;
                  LaRam <= 0; Lab<=0; Eatmp <= 1; Su <= 0;
                  Eu <= 0; Lbtmp <= 0; Eba<=0; Lo <= 0;
                  Ltmpa<=1; Etmpb<=0; LaALU<=0;
                  EaRAM<=0; LA<=0;
                  LtmpRAM<=0; Cetmp<=0; LbALU<=0;
                  LaOUT<=0; EaOut<=0;
                  Ecf<=0; Lcarry<=0; Ercl<=0; Lzf<=0; Lcf<=0;
                end
              4'b0001: //add a,b
                begin
                  Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=0;
                  Cei <= 0; Cea<=0; Li <= 0; Ei <= 0;
                  LaRam <= 0; Lab<=0; Eatmp <= 0; Su <= 0;
                  Eu <= 1; Lbtmp <= 0; Eba<=0; Lo <= 0;
                  Ltmpa<=0; Etmpb<=0; LaALU<=0;
                  EaRAM<=0; LA<=0;
                  LtmpRAM<=0; Cetmp<=0; LbALU<=0;
                  LaOUT<=0; EaOut<=0;
                  Ecf<=0; Lcarry<=0; Ercl<=0; Lzf<=1; Lcf<=1;
                end
              4'b0010: //sub a,b
                begin
                  Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=0;
                  Cei <= 0; Cea<=0; Li <= 0; Ei <= 0;
                  LaRam <= 0; Lab<=0; Eatmp <= 0; Su <= 0;
                  Eu <= 1; Lbtmp <= 0; Eba<=0; Lo <= 0;
                  Ltmpa<=0; Etmpb<=0; LaALU<=0;
                  EaRAM<=0; LA<=0;
                  LtmpRAM<=0; Cetmp<=0; LbALU<=0;
                  LaOUT<=0; EaOut<=0;
                  Ecf<=0; Lcarry<=0; Ercl<=0; Lzf<=1; Lcf<=1;
                end
              4'b1000: //and a,b
                begin
                  Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=0;
                  Cei <= 0; Cea<=0; Li <= 0; Ei <= 0;
                  LaRam <= 0; Lab<=0; Eatmp <= 0; Su <= 0;
                  Eu <= 1; Lbtmp <= 0; Eba<=0; Lo <= 0;
                  Ltmpa<=0; Etmpb<=0; LaALU<=0;
                  EaRAM<=0; LA<=0;
                  LtmpRAM<=0; Cetmp<=0; LbALU<=0;
                  LaOUT<=0; EaOut<=0;
                  Ecf<=0; Lcarry<=0; Ercl<=0; Lzf<=1; Lcf<=1;
                end
              4'b0110: //mov [address], a
                begin
                  Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=1;
                  Cei <= 0; Cea<=0; Li <= 0; Ei <= 1;
                  LaRam <= 0; Lab<=0; Eatmp <= 0; Su <= 0;
                  Eu <= 0; Lbtmp <= 0; Eba<=0; Lo <= 0;
                  Ltmpa<=0; Etmpb<=0; LaALU<=0;
                  EaRAM<=0; LA<=0;
                  LtmpRAM<=0; Cetmp<=0; LbALU<=0;
                  LaOUT<=0; EaOut<=0;
                  Ecf<=0; Lcarry<=0; Ercl<=0; Lzf<=0; Lcf<=0;
                end
              4'b1001: //or b, [address]
                begin
                  Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=1;
                  Cei <= 0; Cea<=0; Li <= 0; Ei <= 1;
                  LaRam <= 0; Lab<=0; Eatmp <= 0; Su <= 0;
                  Eu <= 0; Lbtmp <= 0; Eba<=0; Lo <= 0;
                  Ltmpa<=0; Etmpb<=0; LaALU<=0;
                  EaRAM<=0; LA<=0;
                  LtmpRAM<=0; Cetmp<=0; LbALU<=0;
                  LaOUT<=0; EaOut<=0;
                  Ecf<=0; Lcarry<=0; Ercl<=0; Lzf<=1; Lcf<=1;
                end
              4'b1010: //out a
                begin
                  Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=0;
                  Cei <= 0; Cea<=0; Li <= 0; Ei <= 0;
                  LaRam <= 0; Lab<=0; Eatmp <= 0; Su <= 0;
                  Eu <= 0; Lbtmp <= 0; Eba<=0; Lo <= 0;
                  Ltmpa<=0; Etmpb<=0; LaALU<=0;
                  EaRAM<=0; LA<=0;
                  LtmpRAM<=0; Cetmp<=0; LbALU<=0;
                  LaOUT<=1; EaOut<=1;
                  Ecf<=0; Lcarry<=0; Ercl<=0; Lzf<=0; Lcf<=0;
                end
              4'b1111: //hlt
                begin
                  Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=0;
                  Cei <= 0; Cea<=0; Li <= 0; Ei <= 0;
                  LaRam <= 0; Lab<=0; Eatmp <= 0; Su <= 0;
                  Eu <= 0; Lbtmp <= 0; Eba<=0; Lo <= 0;
                  Ltmpa<=0; Etmpb<=0; LaALU<=0;
                  EaRAM<=0; LA<=0;
                  LtmpRAM<=0; Cetmp<=0; LbALU<=0;
                  LaOUT<=0; EaOut<=0; HLT<=1;
                  Ecf<=0; Lcarry<=0; Ercl<=0; Lzf<=0; Lcf<=0;
                end
              4'b0100: //rcl b
                begin
                  Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=0;
                  Cei <= 0; Cea<=0; Li <= 0; Ei <= 0;
                  LaRam <= 0; Lab<=0; Eatmp <= 0; Su <= 0;
                  Eu <= 0; Lbtmp <= 0; Eba<=0; Lo <= 0;
                  Ltmpa<=0; Etmpb<=0; LaALU<=0;
                  EaRAM<=0; LA<=0;
                  LtmpRAM<=0; Cetmp<=0; LbALU<=0;
                  LaOUT<=1; EaOut<=1;
                  Ecf<=1; Lcarry<=1; Ercl<=0; Lzf<=0; Lcf<=0;
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
                  LaRam <= 1; Lab<=0; Eatmp <= 0; Su <= 0;
                  Eu <= 0; Lbtmp <= 0; Eba<=0; Lo <= 0;
                  Ltmpa<=0; Etmpb<=0; LaALU<=0; 
                  EaRAM<=0; LA<=0;
                  LtmpRAM<=0; Cetmp<=0; LbALU<=0;
                  LaOUT<=0; EaOut<=0;
                  Ecf<=0; Lcarry<=0; Ercl<=0; Lzf<=0; Lcf<=0;
                end
              4'b0011: //xchg a,b(mov a,b)
                begin
                  Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=0;
                  Cei <= 0; Cea<=0; Li <= 0; Ei <= 0;
                  LaRam <= 0; Lab<=1; Eatmp <= 0; Su <= 0;
                  Eu <= 0; Lbtmp <= 0; Eba<=1; Lo <= 0;
                  Ltmpa<=0; Etmpb<=0; LaALU<=0; 
                  EaRAM<=0; LA<=0;
                  LtmpRAM<=0; Cetmp<=0; LbALU<=0;
                  LaOUT<=0; EaOut<=0;
                  Ecf<=0; Lcarry<=0; Ercl<=0; Lzf<=0; Lcf<=0;
                end
              4'b0001: //add a,b(send result of alu to a)
                begin
                  Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=0;
                  Cei <= 0; Cea<=0; Li <= 0; Ei <= 0;
                  LaRam <= 0; Lab<=0; Eatmp <= 0; Su <= 0;
                  Eu <= 0; Lbtmp <= 0; Eba<=0; Lo <= 0;
                  Ltmpa<=0; Etmpb<=0; LaALU<=1;
                  EaRAM<=0; LA<=0;
                  LtmpRAM<=0; Cetmp<=0; LbALU<=0;
                  LaOUT<=0; EaOut<=0;
                  Ecf<=0; Lcarry<=0; Ercl<=0; Lzf<=0; Lcf<=0;
                end
              4'b0010: //sub a,b(send result of alu to a)
                begin
                  Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=0;
                  Cei <= 0; Cea<=0; Li <= 0; Ei <= 0;
                  LaRam <= 0; Lab<=0; Eatmp <= 0; Su <= 0;
                  Eu <= 0; Lbtmp <= 0; Eba<=0; Lo <= 0;
                  Ltmpa<=0; Etmpb<=0; LaALU<=1;
                  EaRAM<=0; LA<=0;
                  LtmpRAM<=0; Cetmp<=0; LbALU<=0;
                  LaOUT<=0; EaOut<=0;
                  Ecf<=0; Lcarry<=0; Ercl<=0; Lzf<=0; Lcf<=0;
                end
              4'b1000: //and a,b
                begin
                  Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=0;
                  Cei <= 0; Cea<=0; Li <= 0; Ei <= 0;
                  LaRam <= 0; Lab<=0; Eatmp <= 0; Su <= 0;
                  Eu <= 0; Lbtmp <= 0; Eba<=0; Lo <= 0;
                  Ltmpa<=0; Etmpb<=0; LaALU<=1;
                  EaRAM<=0; LA<=0;
                  LtmpRAM<=0; Cetmp<=0; LbALU<=0;
                  LaOUT<=0; EaOut<=0;
                  Ecf<=0; Lcarry<=0; Ercl<=0; Lzf<=0; Lcf<=0;
                end
              4'b0110: //mov address, a
                begin
                  Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=0;
                  Cei <= 0; Cea<=0; Li <= 0; Ei <= 0;
                  LaRam <= 0; Lab<=0; Eatmp <= 0; Su <= 0;
                  Eu <= 0; Lbtmp <= 0; Eba<=0; Lo <= 0;
                  Ltmpa<=0; Etmpb<=0; LaALU<=0;
                  EaRAM<=1; LA<=1; 
                  LtmpRAM<=0; Cetmp<=0; LbALU<=0;
                  LaOUT<=0; EaOut<=0;
                  Ecf<=0; Lcarry<=0; Ercl<=0; Lzf<=0; Lcf<=0;
                end 
              4'b1001: //or b, [address]
                begin
                  Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=0;
                  Cei <= 0; Cea<=0; Li <= 0; Ei <= 0;
                  LaRam <= 0; Lab<=0; Eatmp <= 0; Su <= 0;
                  Eu <= 0; Lbtmp <= 0; Eba<=0; Lo <= 0;
                  Ltmpa<=0; Etmpb<=0; LaALU<=0;
                  EaRAM<=0; LA<=0;
                  LtmpRAM<=1; Cetmp<=1; LbALU<=0;
                  LaOUT<=0; EaOut<=0;
                  Ecf<=0; Lcarry<=0; Ercl<=0; Lzf<=0; Lcf<=0;
                end
              4'b1010: //out a
                begin
                  Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=0;
                  Cei <= 0; Cea<=0; Li <= 0; Ei <= 0;
                  LaRam <= 0; Lab<=0; Eatmp <= 0; Su <= 0;
                  Eu <= 0; Lbtmp <= 0; Eba<=0; Lo <= 0;
                  Ltmpa<=0; Etmpb<=0; LaALU<=0;
                  EaRAM<=0; LA<=0;
                  LtmpRAM<=0; Cetmp<=0; LbALU<=0;
                  LaOUT<=0; EaOut<=0;
                  Ecf<=0; Lcarry<=0; Ercl<=0; Lzf<=0; Lcf<=0;
                end
              4'b1111: //hlt
                begin
                  Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=0;
                  Cei <= 0; Cea<=0; Li <= 0; Ei <= 0;
                  LaRam <= 0; Lab<=0; Eatmp <= 0; Su <= 0;
                  Eu <= 0; Lbtmp <= 0; Eba<=0; Lo <= 0;
                  Ltmpa<=0; Etmpb<=0; LaALU<=0;
                  EaRAM<=0; LA<=0;
                  LtmpRAM<=0; Cetmp<=0; LbALU<=0;
                  LaOUT<=0; EaOut<=0; 
                  Ecf<=0; Lcarry<=0; Ercl<=0; Lzf<=0; Lcf<=0;
                end
              4'b0100: //rcl b
                begin
                  Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=0;
                  Cei <= 0; Cea<=0; Li <= 0; Ei <= 0;
                  LaRam <= 0; Lab<=0; Eatmp <= 0; Su <= 0;
                  Eu <= 0; Lbtmp <= 0; Eba<=0; Lo <= 0;
                  Ltmpa<=0; Etmpb<=0; LaALU<=0;
                  EaRAM<=0; LA<=0;
                  LtmpRAM<=0; Cetmp<=0; LbALU<=0;
                  LaOUT<=1; EaOut<=1;
                  Ecf<=0; Lcarry<=0; Ercl<=1; Lzf<=0; Lcf<=0;
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
                  LaRam <= 0; Lab<=0; Eatmp <= 0; Su <= 0;
                  Eu <= 0; Lbtmp <= 0; Eba<=0; Lo <= 0;
                  Ltmpa<=0; Etmpb<=0; LaALU<=0; 
                  EaRAM<=0; LA<=0;
                  LtmpRAM<=0; Cetmp<=0; LbALU<=0;
                  Ecf<=0; Lcarry<=0; Ercl<=0; Lzf<=0; Lcf<=0;
                end
              4'b0011: //xchg a,b(mov b,tmp)
                begin
                  Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=0;
                  Cei <= 0; Cea<=0; Li <= 0; Ei <= 0;
                  LaRam <= 0; Lab<=0; Eatmp <= 0; Su <= 0;
                  Eu <= 0; Lbtmp <= 1; Eba<=0; Lo <= 0;
                  Ltmpa<=0; Etmpb<=1; LaALU<=0; 
                  EaRAM<=0; LA<=0;
                  LtmpRAM<=0; Cetmp<=0; LbALU<=0;
                  Ecf<=0; Lcarry<=0; Ercl<=0; Lzf<=0; Lcf<=0;
                end
              4'b0001: //add a,b
                begin
                  Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=0;
                  Cei <= 0; Cea<=0; Li <= 0; Ei <= 0;
                  LaRam <= 0; Lab<=0; Eatmp <= 0; Su <= 0;
                  Eu <= 0; Lbtmp <= 0; Eba<=0; Lo <= 0;
                  Ltmpa<=0; Etmpb<=0; LaALU<=0;
                  EaRAM<=0; LA<=0;
                  LtmpRAM<=0; Cetmp<=0; LbALU<=0;
                  Ecf<=0; Lcarry<=0; Ercl<=0; Lzf<=0; Lcf<=0;
                end
              4'b0010: //sub a,b
                begin
                  Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=0;
                  Cei <= 0; Cea<=0; Li <= 0; Ei <= 0;
                  LaRam <= 0; Lab<=0; Eatmp <= 0; Su <= 0;
                  Eu <= 0; Lbtmp <= 0; Eba<=0; Lo <= 0;
                  Ltmpa<=0; Etmpb<=0; LaALU<=0;
                  EaRAM<=0; LA<=0;
                  LtmpRAM<=0; Cetmp<=0; LbALU<=0;
                  Ecf<=0; Lcarry<=0; Ercl<=0; Lzf<=0; Lcf<=0;
                end
              4'b1000: //and a,b
                begin
                  Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=0;
                  Cei <= 0; Cea<=0; Li <= 0; Ei <= 0;
                  LaRam <= 0; Lab<=0; Eatmp <= 0; Su <= 0;
                  Eu <= 0; Lbtmp <= 0; Eba<=0; Lo <= 0;
                  Ltmpa<=0; Etmpb<=0; LaALU<=0;
                  EaRAM<=0; LA<=0;
                  LtmpRAM<=0; Cetmp<=0; LbALU<=0;
                  Ecf<=0; Lcarry<=0; Ercl<=0; Lzf<=0; Lcf<=0;
                end
              4'b0110: //mov address, a
                begin
                  Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=0;
                  Cei <= 0; Cea<=0; Li <= 0; Ei <= 0;
                  LaRam <= 0; Lab<=0; Eatmp <= 0; Su <= 0;
                  Eu <= 0; Lbtmp <= 0; Eba<=0; Lo <= 0;
                  Ltmpa<=0; Etmpb<=0; LaALU<=0;
                  EaRAM<=0; LA<=0;
                  LtmpRAM<=0; Cetmp<=0; LbALU<=0;
                  Ecf<=0; Lcarry<=0; Ercl<=0; Lzf<=0; Lcf<=0;
                end
              4'b1001: //or b, [address]
                begin
                  Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=0;
                  Cei <= 0; Cea<=0; Li <= 0; Ei <= 0;
                  LaRam <= 0; Lab<=0; Eatmp <= 0; Su <= 0;
                  Eu <= 0; Lbtmp <= 0; Eba<=0; Lo <= 0;
                  Ltmpa<=0; Etmpb<=0; LaALU<=0;
                  EaRAM<=0; LA<=0; LtmpRAM<=0; Cetmp<=0;
                  LtmpRAM<=0; Cetmp<=0; LbALU<=1;
                  Ecf<=0; Lcarry<=0; Ercl<=0; Lzf<=0; Lcf<=0;
                end
              4'b1010: //out a
                begin
                  Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=0;
                  Cei <= 0; Cea<=0; Li <= 0; Ei <= 0;
                  LaRam <= 0; Lab<=0; Eatmp <= 0; Su <= 0;
                  Eu <= 0; Lbtmp <= 0; Eba<=0; Lo <= 0;
                  Ltmpa<=0; Etmpb<=0; LaALU<=0;
                  EaRAM<=0; LA<=0;
                  LtmpRAM<=0; Cetmp<=0; LbALU<=0;
                  LaOUT<=0; EaOut<=0;
                  Ecf<=0; Lcarry<=0; Ercl<=0; Lzf<=0; Lcf<=0;
                end
              4'b1111: //hlt
                begin
                  Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=0;
                  Cei <= 0; Cea<=0; Li <= 0; Ei <= 0;
                  LaRam <= 0; Lab<=0; Eatmp <= 0; Su <= 0;
                  Eu <= 0; Lbtmp <= 0; Eba<=0; Lo <= 0;
                  Ltmpa<=0; Etmpb<=0; LaALU<=0;
                  EaRAM<=0; LA<=0;
                  LtmpRAM<=0; Cetmp<=0; LbALU<=0;
                  LaOUT<=0; EaOut<=0; 
                  Ecf<=0; Lcarry<=0; Ercl<=0; Lzf<=0; Lcf<=0;
                end
              4'b0100: //rcl b
                begin
                  Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=0;
                  Cei <= 0; Cea<=0; Li <= 0; Ei <= 0;
                  LaRam <= 0; Lab<=0; Eatmp <= 0; Su <= 0;
                  Eu <= 0; Lbtmp <= 0; Eba<=0; Lo <= 0;
                  Ltmpa<=0; Etmpb<=0; LaALU<=0;
                  EaRAM<=0; LA<=0;
                  LtmpRAM<=0; Cetmp<=0; LbALU<=0;
                  LaOUT<=1; EaOut<=1;
                  Ecf<=0; Lcarry<=0; Ercl<=0; Lzf<=0; Lcf<=0;
                end
            endcase
          end
        
        default:
          begin
            Cp <= 0; Ep <= 0; Lmp <= 0; Lmi<=0;
            Cei <= 0; Cea<=0; Li <= 0; Ei <= 0;
            LaRam <= 0; Lab<=0; Eatmp <= 0; Su <= 0;
            Eu <= 0; Lbtmp <= 0; Eba<=0; Lo <= 0;
            Ltmpa<=0; Etmpb<=0; LaALU<=0; 
            EaRAM<=0; LA<=0;
            LtmpRAM<=0; Cetmp<=0; LbALU<=0;
            LaOUT<=0; EaOut<=0;
            Ecf<=0; Lcarry<=0; Ercl<=0; Lzf<=0; Lcf<=0;
          end
      endcase
    end
endmodule


module ProgramCounter(clk, reset, Ep, Cp, PC_to_MAR, HLT);
  input clk, reset, Ep, Cp, HLT;
  output[3:0] PC_to_MAR;
  
  reg[3:0] count_buffer; 
  reg[3:0] count;
  reg first = 1'b0;
  
  initial
    begin
      count_buffer = 4'bzzzz;
      count = 4'b0000;
    end
  
  assign PC_to_MAR = count_buffer; //write bus
  
  always@(posedge clk)
    begin
      if(Ep)
        begin
          count_buffer <= count; 
        end
      else
        begin
          count_buffer <= 4'bzzzz;
        end
      
      if(Cp)  
        begin
          //$display("Increment block e asche");
          count <= (count == 4'b1111) ? 4'b0000 : count + 4'b0001;
          //$display("count=%8b", count);
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
    end
   
  always@(negedge reset)
    begin
      if(~reset) 
        begin
          count<=4'b0;
          first <= 1'b0;
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

module RAM(input_mode, input_address, input_program, clk, Cei, Cea, Cetmp, LA, MAR_to_RAM, RAM_to_IR, RAM_to_A, A_to_RAM, RAM_to_TMP);
  
  input input_mode;
  input[3:0] input_address;
  input[7:0] input_program;
  input clk,Cei, Cea, Cetmp, LA;  //LA=load from A, Cei=Send to Instruction Register, Cea=Send to A, Cetmp = Send to TMP
  input[3:0] MAR_to_RAM;
  input[3:0] A_to_RAM;
  output[7:0] RAM_to_IR;
  output[3:0] RAM_to_A;
  output[3:0] RAM_to_TMP; //needed for OR B, [Address]
  
  reg[7:0] ram[0:15];
  reg[7:0] dataIR = 8'bzzzz_zzzz;
  reg[3:0] dataA = 4'bzzzz;
  reg[3:0] dataTMP = 4'bzzzz;
  
  assign RAM_to_IR = dataIR;
  assign RAM_to_A = dataA;
  assign RAM_to_TMP = dataTMP;
  
  integer address;
  
  initial
    begin
      for(address=0;address<16;address=address+1)
        begin
          ram[address] <= 8'b0;
        end
    end
  
  always@(input_program)
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
          ram[MAR_to_RAM] <= {4'b0000, A_to_RAM};
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
        end
      else if(Cetmp)
        begin
          dataTMP <= ram[MAR_to_RAM][3:0];
        end
      else
        begin
          dataIR<=8'bzzzz_zzzz;
          dataA<=4'bzzzz;
        end
    end
endmodule

module InstructionRegister(clk, RAM_to_IR, Li, Ei, reset, IR_to_Control, IR_to_MAR);
  
  input[7:0] RAM_to_IR;
  input clk, Li, Ei, reset; //Li=Load from RAM, Ei=Send to BUS and CS
  output[3:0] IR_to_Control;
  output[3:0] IR_to_MAR;
  
  reg[3:0] opcode;
  reg[3:0] operand;
  reg[3:0] address_field;
  
  assign IR_to_Control = opcode;
  assign IR_to_MAR = address_field;
  
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

module ARegister(clk, RAM_to_A, B_to_A, LaRam, Lab, LaALU, Eatmp, EaRAM, EaOut, reset, A_to_ALU, A_to_TMP, ALU_to_A, A_to_RAM, A_to_OUT);
  
  input[3:0] RAM_to_A;
  input[3:0] ALU_to_A;
  input[3:0] B_to_A;
  input clk,  LaRam, Lab, LaALU, Eatmp, reset, EaRAM, EaOut; //Li=Load from RAM, Eatmp=Send to TMP and CS
  //EaRam = Send data to RAM
  output[3:0] A_to_ALU;
  output[3:0] A_to_TMP;
  output[3:0] A_to_RAM;
  output[3:0] A_to_OUT;
  
  reg[3:0] dataA;
  reg[3:0] dataTMP;
  reg[3:0] dataRAM;
  reg[3:0] dataOut;
  
  assign A_to_ALU = dataA;
  assign A_to_TMP = dataTMP;
  assign A_to_RAM = dataRAM;
  assign A_to_OUT = dataOut;
  
  always@(*)
    begin
      if(LaRam)
        begin
          //$display("LaRam e dhuke gese");
          //$display("IR theke control e charbe");
          //$display("Instruction=%8b, Opcode=%4b", instruction, opcode);
          dataA <= RAM_to_A;
          $display("dataA=%4b", dataA);
        end
      else if(Lab)
        begin
          //$display("%4b", B_to_A);
          //$display("Lab e dhuke gese");
          dataA <= B_to_A;
        end
      else if(LaALU)
        begin
          //$display("LaAlu e dhuke gese");
          //$display("dataA=%4b", dataA);
          dataA <= ALU_to_A;
          //$display("dataA=%4b", dataA);
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

module BRegister(clk, TMP_to_B, Lbtmp, LbALU, Lcarry, Eba, reset, B_to_A, B_to_ALU, ALU_to_B, Carry_to_B, Ercl, Carry_from_B);
  
  input[3:0] TMP_to_B;
  input[3:0] ALU_to_B;
  input clk, Lbtmp, LbALU, Lcarry, Eba, reset; //Ltmp=Load from A, Etmp=Send to B
  input Ercl, Carry_to_B;//Ercl=ready to rotate left
  output Carry_from_B;
  output[3:0] B_to_A;
  output[3:0] B_to_ALU;
  //output[3:0] ;
  
  reg[3:0] dataB;
  reg[3:0] dataOut;
  reg Carry;
  reg CB;
  
  assign B_to_A = dataOut;
  assign B_to_ALU = dataB;
  assign Carry_from_B = CB;
  //assign BUS[3:0] = dataOut;
  
  always@(*)
    begin
      if(Lbtmp)
        begin
          dataB <= TMP_to_B;
        end
      else if(LbALU)
        begin
          dataB <= ALU_to_B; //OR B,[Address]
        end
      else if(Lcarry)
        begin
          Carry <= Carry_to_B;
        end
    end

  always@(posedge clk)
    begin
      if(Eba)
        //$display("Dhukse");
        begin
          dataOut<=dataB;
        end
      else if(Ercl)
        begin
          CB <= dataB[3];
          dataB[3] <= dataB[2];
          dataB[2] <= dataB[1];
          dataB[1] <= dataB[0];
          dataB[0] <= Carry;
        end
    end

  always@(negedge reset)
    begin
      if(~reset)
        begin
          dataB<=4'b0000; //b is reset to zero
          dataOut<=4'bzzzz;
        end
    end
endmodule

module FlagRegister(clk, reset, Z_from_ALU, Carry_from_ALU, Carry_to_B, Carry_from_B, Ercl, Lzf, Ecf, Lcf);
  input clk, reset, Ercl, Lzf, Ecf, Lcf;
  input Z_from_ALU, Carry_from_ALU, Carry_from_B;
  output Carry_to_B;
  
  reg zz, cy;
  reg zero, carry;
  
  //assign Z_to_B = zz;
  assign Carry_to_B = carry;
  
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
  
  always@(*)
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
          result = TMP_to_ALU | B_to_ALU; //OR B, [Address] 
          if (result==4'b0000)
            begin
              zero_flag=1;
            end
          else zero_flag=0;
        end
    end
  
  /*generate
    begin
      if(IR_to_Control==4'b0001)
        begin
          adder_sub4(0, A_to_ALU, B_to_ALU, ALU_to_F_Cout, result);
        end
      else if(IR_to_Control==4'b0010)
        begin
          adder_sub4(1, A_to_ALU, B_to_ALU, ALU_to_F_Cout, result);
        end
      else if(IR_to_Control==4'b1000)
        begin
          and_four(result, A_to_ALU, B_to_ALU);
        end
      else if(IR_to_Control==4'b1001) 
        begin
          or_four(result, A_to_ALU, B_to_ALU); //OR B, [Address]
        end
    end
  endgenerate*/

  /*always@(*)
    begin
      //$display("A=%4b", A_to_ALU);
      if(IR_to_Control==4'b0001)
        begin
          //$display("Summing A and B");
          //$display("A=%4b, B=%4b", A_to_ALU, B_to_ALU);
          //{Carryout, result} <= A_to_ALU+B_to_ALU;
          result <= A_to_ALU+B_to_ALU;
          //$display("Sum=%4b", result);
        end
      else if(IR_to_Control==4'b0010) 
        begin
          //{Carryout, result} <= A_to_ALU-B_to_ALU;
          result <= A_to_ALU-B_to_ALU;
        end
      else if(IR_to_Control==4'b1000) result <= A_to_ALU&B_to_ALU;
      else if(IR_to_Control==4'b1001) result <= TMP_to_ALU | B_to_ALU; //OR B, [Address] 
    end*/
  
  always@(posedge clk)
    begin
      if(Eu)
        begin
          resultOut<=result;
          zz <= zero_flag;
          cy <= carry_flag;
        end
    end
  
  always@(negedge reset)
    begin
      if(~reset)
        begin
          resultOut<=4'bzzzz;
          zero_flag<=1'bz;
          carry_flag<=1'bz;
        end
    end
  
endmodule
/*
module adder_sub4(Carryin, A, B, Carryout, Sum);
  input[3:0] A;
  input[3:0] B;
  input Carryin;
  output Carryout;
  output[3:0] Sum;
  
  wire[2:0] C;
  wire[3:0] BB;
  
  add_sub add_sub0(Carryin, B, BB);
  
  fulladd stage0(A[0], BB[0], Carryin, C[0], Sum[0]);
  fulladd stage1(A[1], BB[1], C[0], C[1], Sum[1]);
  fulladd stage2(A[2], BB[2], C[1], C[2], Sum[2]);
  fulladd stage3(A[3], BB[3], C[2], Carryout, Sum[3]);
endmodule

module fulladd(x,y,cin,co,s);
  input x,y,cin;
  output co,s;
  
  assign s = x^y^cin; 
  assign co = (x&y) | (y&cin) | (x&cin);
  
endmodule

module add_sub(ctrl, B, BB);
  input ctrl;
  input[3:0] B;
  output[3:0] BB; 
  
  xor xor0(BB[0], ctrl, B[0]);
  xor xor1(BB[1], ctrl, B[1]);
  xor xor2(BB[2], ctrl, B[2]);
  xor xor3(BB[3], ctrl, B[3]);
endmodule

module and_four(A, B, out);
  input[3:0] A;
  input[3:0] B;
  output[3:0] out; 
  
  and and0(out[0], A[0], B[0]);
  and and1(out[1], A[1], B[1]);
  and and2(out[2], A[2], B[2]);
  and and3(out[3], A[3], B[3]);
endmodule

module or_four(A, B, out);
  input[3:0] A;
  input[3:0] B;
  output[3:0] out; 
  
  or or0(out[0], A[0], B[0]);
  or or1(out[1], A[1], B[1]);
  or or2(out[2], A[2], B[2]);
  or or3(out[3], A[3], B[3]);
endmodule
*/
/*module FLAGRegister(ALU_to_F_Cout)
  input ALU_to_F_Cout;
  
endmodule*/

module OUTRegister(clk, reset, A_to_OUT, LaOUT, OUT_to_disp);
  input clk, reset;
  input[3:0] A_to_OUT;
  input LaOUT;
  output[3:0] OUT_to_disp;
  
  reg[3:0] dataDisp;
  
  assign OUT_to_disp = dataDisp;
  
  always@(*)
    begin
      if(LaOUT)
        begin
          dataDisp<=A_to_OUT;
        end
    end
  
  always@(negedge reset)
    begin
      if(~reset) dataDisp<=4'bzzzz;
    end
  
endmodule