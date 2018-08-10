`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/19 08:52:37
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


module TestCPU;
   reg _CLK;
   reg _RST;
   wire _zero;
   wire _sign;
   wire[31:0] _CurrentAddress;
   wire[31:0] _NextAddress;  
   wire[1:0]  _PCSrc;
   wire [2:0] _ALUOp; 
   wire[31:0] _ReadData1, _ReadData2, _ALUResult;
   wire [31:0] _dataA;           //ALU������1
   wire [31:0] _dataB;           //ALU������2
           
   wire[31:0] _ExtendOut, _DataOut, _IDataOut, _IRDataOut;
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
    DataPath _DataPath(
	     .CLK(_CLK),              // ʱ��
		 .RST(_RST),           // ��λ�ź�
	     .zero(_zero),            //���ź�
	     .sign(_sign),
		 .CurrentAddress(_CurrentAddress),   // ��ǰָ���ַ
		 .NextAddress(_NextAddress),     // ��һ��ָ���ַ
		 .ALUOp(_ALUOp),           //alu������
		 .ReadData1(_ReadData1),       //�Ĵ��� ��1 �������rs
         .ReadData2(_ReadData2),        // �Ĵ��� ��2 �������rt
         .dataA(_dataA),           //ALU������1
         .dataB(_dataB),           //ALU������2
		 .ALUResult(_ALUResult),       //ALU ������
	     .IDataOut(_IDataOut),         //ָ��洢�����ָ�� 
	     .DataOut(_DataOut),          //���ݴ洢�����            
	     .WriteData(_WriteData),            //ͨ����ѡһд���ݽ���Ĵ���
	     .rs(_rs),        
	     .rt(_rt),
	     .rd(_rd),
	     .sa(_sa),
	     .opcode(_opcode),          // ���Ƶ�Ԫָ�Ԫ������
	     .PCSrc(_PCSrc),           // ȷ�������¸���ַ�Ŀ����ź�
         .PCPlusFourAddress(_PCPlusFourAddress),    //pc+4��ַ
         .immediate(_immediate),        //������������
         .ExtendResult(_ExtendResult),       // 0 / ������չλ���
         .toExtendAddress(_toExtendAddress),   //jָ���д���չ��ַ
         .JumpAddress(_JumpAddress),       //��չ����ת��ַ
         .WriteReg(_WriteReg),           //  д��Ĵ�����λ��
         .IRDataOut(_IRDataOut)           // ָ��Ĵ��������ֵ
         );  
         
            initial begin
                    _CLK = 0;
                    _RST = 0; //��ʼ������
                   
                    #50;    //50 ns��ʼ ����
                        _CLK = 1;
                    #50; //�������� pc 0
                      // _RST = 1;
                    forever #50 begin   //����ʱ���ź�
                        _RST = 1;
                        _CLK = !_CLK;
                    end
                 end         
endmodule
