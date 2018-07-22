`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/30 21:38:45
// Design Name: 
// Module Name: RegFile
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
//�Ĵ�����
module RegFile(
	input CLK,   //ʱ���ź�
	input reset,  //��λ�ź�
	input RegWre,  //�Ĵ���дʹ���ź�
	input [4:0] ReadReg1,  //��ȡ�Ĵ���1
	input [4:0] ReadReg2,  //��ȡ�Ĵ���2
	input [4:0] WriteReg,  //д�Ĵ���1
	input [31:0] WriteData,  // д��Ĵ��� 
	output [31:0] ReadData1,//���readReg1
	output [31:0] ReadData2  //���readreg2
);
	reg [31:0] regFile[0:31]; // �Ĵ������������reg ����
	integer i;
	initial begin
	   for( i = 0; i < 32; i = i+1)
	       regFile[i] = 0;
	end
	assign ReadData1 = (ReadReg1 == 0 ? 0:regFile[ReadReg1]);
	assign ReadData2 = (ReadReg2 == 0 ? 0:regFile[ReadReg2]);
        
	//assign ReadData1 = regFile[ReadReg1]; //  ֱ�����rs
//	assign ReadData2 = regFile[ReadReg2]; 
	always @ (negedge CLK ) begin // ������ʱ�ӱ��ش���		
		 if(RegWre == 1 && WriteReg != 0)begin // WriteReg != 0��$0�Ĵ��������޸�
			regFile[WriteReg] <= WriteData; // д�Ĵ�������Ҫд���ֵ�����Ĵ���
		end		
	end
endmodule