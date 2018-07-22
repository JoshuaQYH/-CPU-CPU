`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/31 20:39:37
// Design Name: 
// Module Name: TestCPU
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


module TestCPU();
    reg _clk;
    reg _reset;
    wire _zero;
    wire[31:0] _CurrentAddress;
    wire[31:0] _NextAddress;  
    wire[1:0] _PCSrc;
    wire [2:0] _ALUOp; 
    wire[31:0] _ReadData1, _ReadData2, _ALUResult;
    wire [31:0] _dataA;           //ALU������1
    wire [31:0] _dataB;           //ALU������2
            
    wire[31:0] _ExtendOut, _DataOut, _IDataOut;
    wire[4:0] _WriteReg;
    wire[31:0] _WriteData;
    wire [4:0] _rs;        
    wire [4:0] _rt;
    wire [4:0] _rd;
    wire [31:0] _sa;
    wire [5:0] _opcode;
   // wire [1:0] _PCSrc;           // ȷ�������¸���ַ�Ŀ����ź�
    wire [31:0] _PCPlusFourAddress;    //pc+4��ַ
    wire [15:0] _immediate;        //������������
    wire [31:0] _ExtendResult;       // 0 / ������չλ���
    wire [25:0] _toExtendAddress;   //jָ���д���չ��ַ
    wire [31:0] _JumpAddress;       //��չ����ת��ַ
     DataPipe datapipe(
             .clk(_clk),
             .reset(_reset),
             .zero(_zero),
             .CurrentAddress(_CurrentAddress),
             .NextAddress(_NextAddress),
             .ALUOp(_ALUOp),
             .ReadData1(_ReadData1),
             .ReadData2(_ReadData2),
             .dataA(_dataA),           //ALU������1
             .dataB(_dataB),           //ALU������2
             .ALUResult(_ALUResult),
             .IDataOut(_IDataOut),
             .DataOut(_DataOut),
             .WriteData(_WriteData),
             .rs(_rs),        
             .rt(_rt),
             .rd(_rd),
             .sa(_sa),
             .opcode(_opcode),
             .PCSrc(_PCSrc),           // ȷ�������¸���ַ�Ŀ����ź�
             .PCPlusFourAddress(_PCPlusFourAddress),    //pc+4��ַ
             .immediate(_immediate),        //������������
             .ExtendResult(_ExtendResult),       // 0 / ������չλ���
             .toExtendAddress(_toExtendAddress),   //jָ���д���չ��ַ
             .JumpAddress(_JumpAddress),      //��չ����ת��ַ
             .WriteReg(_WriteReg)
    );  
  
	   initial begin
	       _clk = 0;
	       _reset = 0; //��ʼ������
	      
	       #50;    //50 ns��ʼ ����
	           _clk = 1;
	       #50; //�������� pc 0
	         //  _reset = 1;
	       forever #50 begin   //����ʱ���ź�
	           _reset = 1;
	           _clk = !_clk;
	       end
        end
endmodule
