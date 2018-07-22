`timescale 1ns / 1ps
module DataPipe(
	    clk,              // ʱ��
		 reset,           // ��λ�ź�
	     zero,            //���ź�
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
	     opcode,
	     PCSrc,           // ȷ�������¸���ַ�Ŀ����ź�
         PCPlusFourAddress,    //pc+4��ַ
         immediate,        //������������
         ExtendResult,       // 0 / ������չλ���
         toExtendAddress,   //jָ���д���չ��ַ
         JumpAddress,       //��չ����ת��ַ
         WriteReg
);  
        input clk, reset, zero;
		output [31:0] DataOut;	// ��չ�ֶ�����������ݴ洢�����	
		output [31:0] NextAddress;//  PCPlusAddress, ExtendResult, JumpAddress, IDataOut;
	    input wire [4:0] WriteReg; //д�Ĵ���
		output [2:0] ALUOp;   // �����ź�alu������ 
        wire mRD, mWR;
        output [1:0] PCSrc;
	    wire InsMemRW;    
		output wire[31:0] IDataOut;  
		output wire [31:0] WriteData;
		
		//�����ź�
		wire ExtSel, PCWre,  RegDst, RegWre, ALUSrcA, ALUSrcB, DBDataSrc;
        output wire[31:0] ReadData1;  // �Ĵ������ֵ1
        output wire[31:0] ReadData2;  //�Ĵ������ֵ2
        output wire[31:0] CurrentAddress;  //��ǰ��ַ
        output wire[31:0] ALUResult;   //ALU������ 
         output wire[31:0] ExtendResult;  //����λ��չ���
         //�����ֶ�
	     input wire[4:0] rs;
	     assign rs = IDataOut[25:21]; 
		 input wire[4:0] rt;
		 assign rt = IDataOut[20:16];
		 input wire[4:0] rd;
		 assign rd = IDataOut[15:11];
	// wire[4:0] sa = IDataOut[10:6];
		 input wire[31:0] sa;
		 assign sa = {{26{1'b0}},IDataOut[10:6]};
		 input wire[5:0] opcode;
		 assign opcode = IDataOut[31:26];
		 wire[15:0] toSignZeroExtend;
		 assign toSignZeroExtend = IDataOut[15:0];
		 input wire[25:0]toExtendAddress;
		 assign toExtendAddress = IDataOut[25:0];
		 input wire[15:0] immediate;
		 assign immediate = IDataOut[15:0];
         input wire[31:0] dataA, dataB;   // ����ALU��Ԫ������
                //wire[15:0] toExtendAddress;
       //  input wire[25:0] toJumpAddress;  // ����jָ����չģ�飬������ת��ַ
                
	//PCʱ������
	PC _PC(clk, reset, NextAddress, CurrentAddress, PCWre);

	 // ָ��洢��ģ��
     //	 mRD = 1;
	ROM _ROM(InsMemRW, CurrentAddress, IDataOut);

	//���Ƶ�Ԫʵ����
	controlUnit _controlUnit(opcode, zero, ExtSel, PCWre, InsMemRW, RegDst,RegWre, ALUOp, PCSrc, ALUSrcA, ALUSrcB, mRD, mWR, DBDataSrc);

	// ��λѡ����ѡ�����д�Ĵ���������
	selector5 _selector5(RegDst, rt, rd, WriteReg);

	// �Ĵ�����ģ�黯
	RegFile  _RegFile(clk, reset, RegWre, rs, rt, WriteReg, WriteData, ReadData1, ReadData2);

   //ʵ�������ݴ洢��������һ���� _name��ʽ
   RAM _RAM(clk, ALUResult, ReadData2, mRD, mWR, DataOut);

	//0 ������չλ
	SignZeroExtend _SignZeroExtend(ExtSel, immediate, ExtendResult);

	//32λ����ѡ����������ALU
	selector32 _selector32_A(ALUSrcA, ReadData1, sa, dataA);
	selector32 _selector32_B(ALUSrcB, ReadData2, ExtendResult, dataB);
    selector32 _selector32_DB(DBDataSrc, ALUResult, DataOut, WriteData);
	// alu32 ģ�飬��������ѡ���������ݣ���������� 0
	ALU32 _ALU32(ALUOp, dataA, dataB, ALUResult, zero);
	
    input wire[31:0] PCPlusFourAddress;  // PC��4ģ�飬������ѡһģ��
	//PC + 4ģ�������ַ
	PCplus4 _PCplus4(CurrentAddress, PCPlusFourAddress);
	
	input wire[31:0] JumpAddress;  //��ת��ַ��������ѡһģ��	
	//������ת��ַ
	extendAddress _extendAddress(toExtendAddress,PCPlusFourAddress,JumpAddress);
	
	//��ѡһѡ����ȷ����һ��ָ���ַ
	selector3to1 _selector3to1(PCPlusFourAddress, ExtendResult, JumpAddress, PCSrc, NextAddress);
	
endmodule