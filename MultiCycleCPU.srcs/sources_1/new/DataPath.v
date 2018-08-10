`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/15 17:56:24
// Design Name: 
// Module Name: DataPath
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

`timescale 1ns / 1ps
module DataPath(
	     CLK,              // ʱ��
		 RST,           // ��λ�ź�
	     zero,            //���ź�
	     sign,
		 CurrentAddress,   // ��ǰָ���ַ
		 NextAddress,     // ��һ��ָ���ַ
		 ALUOp,           //alu������
		 ReadData1,       //�Ĵ��� ��1 �������rs
         ReadData2,        // �Ĵ��� ��2 �������rt
         dataA,           //ALU������1
         dataB,           //ALU������2
		 ALUResult,       //ALU ������
	     IDataOut,         //ָ��洢�����ָ�� 
	     DataOut,          //���ݴ洢�����            
	     WriteData,            //ͨ����ѡһд���ݽ���Ĵ���
	     rs,        
	     rt,
	     rd,
	     sa,
	     opcode,          // ���Ƶ�Ԫָ�Ԫ������
	     PCSrc,           // ȷ�������¸���ַ�Ŀ����ź�
         PCPlusFourAddress,    //pc+4��ַ
         immediate,        //������������
         ExtendResult,       // 0 / ������չλ���
         toExtendAddress,   //jָ���д���չ��ַ
         JumpAddress,       //��չ����ת��ַ
         WriteReg,           //  д��Ĵ�����λ��
         IRDataOut,           // ָ��Ĵ��������ֵ
         );  //29 ports
        input wire CLK, RST, zero, sign;
		output [31:0] DataOut;	// ��չ�ֶ�����������ݴ洢�����
		output [31:0] IRDataOut; 	
		output [31:0] NextAddress;
	    input wire [4:0] WriteReg; //д�Ĵ���
		output [2:0] ALUOp;   // �����ź�alu������ 
        wire mRD, mWR;
        output [1:0] PCSrc;
	    wire InsMemRW;    
		output wire[31:0] IDataOut;  
		output wire [31:0] WriteData;
		
		//�����ź�
		wire ExtSel, PCWre, RegWre, ALUSrcA, ALUSrcB, DBDataSrc, IRWre, WrRegDSrc;
		wire [1:0] RegDst;
        output wire[31:0] ReadData1;  // �Ĵ������ֵ1
        output wire[31:0] ReadData2;  //�Ĵ������ֵ2
        output wire[31:0] CurrentAddress;  //��ǰ��ַ
        output wire[31:0] ALUResult;   //ALU������ 
         output wire[31:0] ExtendResult;  //����λ��չ���
         //�����ֶ�
	     input wire[4:0] rs;
	     assign rs = IRDataOut[25:21]; 
		 input wire[4:0] rt;
		 assign rt = IRDataOut[20:16];
		 input wire[4:0] rd;
		 assign rd = IRDataOut[15:11];
		 input wire[31:0] sa;
		 assign sa = {{26{1'b0}},IRDataOut[10:6]};     ///////////////   bug ??
		 input wire[5:0] opcode;
		 assign opcode = IRDataOut[31:26];
		 wire[15:0] toSignZeroExtend;
		 assign toSignZeroExtend = IRDataOut[15:0];
		 input wire[25:0]toExtendAddress;
		 assign toExtendAddress = IRDataOut[25:0];
		 input wire[15:0] immediate;
		 assign immediate = IRDataOut[15:0];
         input wire[31:0] dataA, dataB;   // ����ALU��Ԫ������
         input wire[31:0] PCPlusFourAddress;  // PC��4ģ�飬������ѡһģ��
         input wire[31:0] JumpAddress;  //��ת��ַ��������ѡһģ��	
                      
        
        
	//PCʱ������
	PC _PC(PCWre, NextAddress, CLK, RST, CurrentAddress);
   //PC + 4ģ�������ַ
    PCPlusFour _PCplus4(CurrentAddress, PCPlusFourAddress);              
	 // ָ��洢��ģ��
     //	 mRD = 1;
	InsMem _InsMem(InsMemRW, CurrentAddress, IDataOut);

    //ָ��Ĵ���IR    
    IR _IR(IRWre, IDataOut, CLK, IRDataOut);
    
	ControlUnit controlunit(
    zero,  RST,  CLK, mRD,  mWR, DBDataSrc,
    ExtSel, PCWre, IRWre, InsMemRW, opcode, WrRegDSrc,
    RegDst,  RegWre,  ALUOp,  PCSrc, sign,  ALUSrcA, ALUSrcB 
    );
	
	
    Selector31_5bits selectorWriteReg(rt, rd, RegDst, WriteReg);
	// �Ĵ�����ģ�黯
	RegFile  _RegFile(RegWre, CLK, rs, rt, WriteReg, WriteData, ReadData1, ReadData2);
    //0 ������չλ
    SignZeroExtend _SignZeroExtend(immediate, ExtSel , ExtendResult);

         //������ת��ַ
    JumpAddressExtend _JumpAddressExtend(PCPlusFourAddress,toExtendAddress,JumpAddress);
        // ��ѡһѡ����ȷ����һ��ָ���ַ
     Selector41_32bits Selector41_32bits(PCPlusFourAddress, ExtendResult, ReadData1, JumpAddress, PCSrc, NextAddress);    
    // ���ݼĴ���
    wire [31:0] ADROut,BDROut,ALUOutDROut, DBDROut;
    DataReg ADR(ReadData1, ADROut, CLK);  
    DataReg BDR(ReadData2, BDROut, CLK);
    //32λ����ѡ����������ALU
     Selector21_32bits selector32_A(ADROut, sa, ALUSrcA, dataA);
     Selector21_32bits selector32_B(BDROut, ExtendResult, ALUSrcB,dataB);
   // wire [31:0] ALUOutDROut;
    ALU _ALU(dataA, dataB,ALUOp, ALUResult, zero, sign);
    DataReg ALUOutDR(ALUResult,ALUOutDROut,CLK);
    //ʵ�������ݴ洢��������һ���� _name��ʽ
    DataMem _DataMem(CLK, mWR, mRD, ALUOutDROut, BDROut, DataOut);

    
    wire [31:0] DBDRIn; 
    //��ѡһѡ����
    Selector21_32bits ToDBDR(ALUResult, DataOut, DBDataSrc, DBDRIn);
    DataReg DBDR(DBDRIn, DBDROut, CLK);      
    Selector21_32bits ToRegFile(PCPlusFourAddress, DBDROut, WrRegDSrc, WriteData);
    
   

endmodule
