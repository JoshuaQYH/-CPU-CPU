`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/17 16:57:35
// Design Name: 
// Module Name: OutputFunc
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module OutputFunc(
    opcode, zero, sign, OutputState, DBDataSrc, mWR, mRD,ExtSel, PCWre,
    IRWre, InsMemRW, WrRegDSrc, RegDst, RegWre, ALUOp, PCSrc, ALUSrcA, ALUSrcB  
);
    input [5:0] opcode;
    input zero, sign;
    input [2:0] OutputState;
    output reg DBDataSrc;
    output reg mWR;
    output reg mRD;
    output reg ExtSel;
    output reg PCWre;
    output reg IRWre;
    output reg InsMemRW;
    output reg WrRegDSrc;
    output reg RegWre;
    output reg ALUSrcA;
    output reg ALUSrcB;
    output reg [1:0] RegDst;
    output reg [1:0] PCSrc;
    output reg [2:0] ALUOp;
    
    initial begin
                ExtSel = 0;
                PCWre = 1;   //����pc
                InsMemRW = 1;  // дָ��
                IRWre = 1;
                RegDst = 0;    
                RegWre = 0;
                ALUOp = 0;
                PCSrc = 0;
                ALUSrcA = 0;
                ALUSrcB = 0;
                mRD = 0;
                mWR = 1;
                DBDataSrc = 0;
     end

      //     ״̬��
      parameter [2:0] IF = 3'b000;
      parameter [2:0] ID = 3'b001 ;
      parameter [2:0] EXE = 3'b010; 
      parameter [2:0] WB = 3'b011;
      parameter [2:0] MEM = 3'b100;
      
      parameter [5:0] _add = 6'b000000; 
      parameter [5:0] _sub = 6'b000001; 
      parameter [5:0] _addi = 6'b000010;  
      parameter [5:0] _or = 6'b010000; 
      parameter [5:0] _and = 6'b010001; 
      parameter [5:0] _ori = 6'b010010; 
      parameter [5:0] _sll = 6'b011000; 
      parameter [5:0] _slt = 6'b100110; 
      parameter [5:0] _sltiu = 6'b100111; 
      parameter [5:0] _sw = 6'b110000; 
      parameter [5:0] _lw = 6'b110001; 
      parameter [5:0] _beq = 6'b110100; 
      parameter [5:0] _bltz = 6'b110110; 
      parameter [5:0] _j = 6'b111000; 
      parameter [5:0] _jr = 6'b111001; 
      parameter [5:0] _jal = 6'b111010; 
      parameter [5:0] _halt = 6'b111111;
      
      always @(OutputState or opcode or sign or zero)begin
          // PCWre
          if(OutputState == IF && opcode != _halt) PCWre = 1;
          else PCWre = 0;  // ��������ͣ��ָ����� Ϊ1
         
          //InsMemRW
          InsMemRW = 1;   //һֱΪ1 ����ȡָ״̬
          
          //IRWre
          if(OutputState == IF) IRWre = 1;
          else IRWre = 0;   //����ȡָ״̬������Ϊ0
          
           
           if(OutputState == EXE) begin
            //ALUSrcA
                     if(opcode == _sll) ALUSrcA = 1;
                     else ALUSrcA = 0;  // sll ����sa��λ��
                     
                     //ALUSrcB
                     if(opcode == _addi || opcode == _ori || opcode == _sltiu || opcode == _lw || opcode == _sw)
                         ALUSrcB = 1; //��Ҫ��������ָ������Ϊ1
                     else ALUSrcB = 0;
            //ALUOp
               case(opcode)
                      _add: ALUOp = 3'b000;
                      _sub: ALUOp = 3'b001;
                      _addi: ALUOp = 3'b000;
                      _or: ALUOp = 3'b101;
                      _and: ALUOp = 3'b110;
                      _ori: ALUOp = 3'b101; 
                      _sll: ALUOp = 3'b100;
                      _slt: ALUOp = 3'b010;
                      _sltiu: ALUOp = 3'b010;
                      _sw: ALUOp = 3'b000;
                      _lw: ALUOp = 3'b000;  
                      _beq: ALUOp = 3'b001;
                      _bltz: ALUOp = 3'b001;
               endcase          
           end
         
           if(OutputState == ID)begin
                 //ExtSel   ��Ҫ0 ����������ָ������Ϊ1
                  if(opcode == _addi || opcode == _sll || opcode == _sltiu || opcode == _sw || opcode == _lw || opcode == _beq || opcode == _bltz)
                   ExtSel = 1;
                  else ExtSel = 0;
           end
           
           if(OutputState == IF)begin
                 //PCSrc 
                     case(opcode)
                         _j: PCSrc = 2'b11;
                         _jal: PCSrc = 2'b11;
                         _jr: PCSrc = 2'b10;
                         _beq: begin
                               if(zero)
                                   PCSrc = 2'b01;
                               else PCSrc = 2'b00;
                         end
                         _bltz:begin
                              if(sign)
                                  PCSrc = 2'b01;
                              else PCSrc = 2'b00;
                         end
                         default: PCSrc = 2'b00;
                     endcase
           end          
   
           //mWR  �洢�׶Σ����� opcode ȷ����ȡ���ߴ洢�洢��������
           if(OutputState == MEM)begin
                  if(opcode == _sw) mWR = 1;
                    else mWR = 0;
                    //mRD
                    if(opcode == _lw) mRD = 1;
                    else mRD = 0;
           end
         
         
           //////////////////////WB 
           //DBDataSrc ɸѡ lw ָ���ȡ�洢�������� �� ALU������
           if(OutputState == WB && opcode == _lw) DBDataSrc = 1'b1;
           else if(OutputState == WB) DBDataSrc = 1'b0;
           
          //WrRegDSrc д�ؽ׶�ȷ��д��Ĵ���������
          if(OutputState == ID && opcode == _jal) WrRegDSrc = 1'b0;
          else if(OutputState == WB) WrRegDSrc = 1'b1;
     
          
            //RegWre д�ؽ׶Σ��Ĵ������д�������׶μĴ����ɶ�
          if(OutputState == WB || opcode == _jal) RegWre = 1'b1;
          else RegWre = 1'b0;   //д�ص�ʱ����Ҫ����1
           
            //RegDst ��д�ؽ׶Σ�ȷ��д���λ�á����ݲ�����Ĳ�ͬ��ȷ��
           if(opcode == _jal && OutputState == ID) RegDst = 2'b00;  // jal ָ�� ��Ҫ31�żĴ���
                          
           if(OutputState == WB)begin                
                if(opcode == _lw || opcode == _addi || opcode == _ori || opcode == _sltiu) RegDst = 2'b01;  // lwָ�� ָ��rt �Ĵ���
                else RegDst = 2'b10;              // add ��ָ�� rd�Ĵ���
           end          
           
           //ȡֵ�׶η�ֹд���ȡ�洢��
           if(OutputState == IF)begin
                RegWre = 0;
                mRD = 0;
                mWR = 0;
           end
      end                                                                                               
endmodule
