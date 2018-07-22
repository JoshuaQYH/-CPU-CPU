`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/31 01:11:27
// Design Name: 
// Module Name: dataPipe
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
`include "RAM.v"
`include "selector32"
`include "controlUnit.v"
`include "PCplus4.v"
`include "ALU32.v"
`include "selector5.v"
`include "selector3to1.v"
`include "extenndAddress.v"
`include "RegFile.v"
`include "PC.v"
`include "ROM.v"

module dataPipe(
	 clk,     
	 reset,      //��ʼ����
	 opcodes,      //������
	 zero,           //ALU����λ�ź�
	 sign,           // ALU�ķ���λ�ź�
	 CurrentAddress, // ��ǰָ��ĵ�ַ
	 NextAddress,  // ��һ��ָ��ĵ�ַ
	 AluResult,   // 32λALU������
	 WriteData,   //д��Ĵ���
	 ReadData1,
	 ReadData2,   //�Ĵ�����2�����
	 RAMDataOut,  // ���ݴ洢�������
	 PcPlusFour,  // PC+4ģ������
	 ExtendData,  // 0 / ������չ�������
	 ExtSel,   // 0 ��չ���Ƿ�����չ
	 PCWre,
	 InsMemRW,
	 RegDst,
	 RegWre,
	 ALUOp,      // ALU������
	 ALUSrcA,    //ѡ����ƼĴ�����2�������sa�ֶ�
	 ALUSrcB,   // ѡ����ƼĴ�������������λ��չ��
	 mRD,       // Ϊ0 ��
	 mWR,       //Ϊ 0 д
	 DBDataSrc  //����������ݴ洢�������ݻ���ALUy������д���Ĵ���������
);
    input clk, reset;
    output [5:0] opcodes;
    output [2:0] ALUOp;
    output [31:0] CurrentAddress,RAMDataout, NextAddress, AluResult, WriteData, ReadData1, ReadData2, PCPlusFour, ExtendData, Dataout;
    wire zero, sign;
    wire PCWre, InsMemRW, RegDst, RegWre, ALUop, ALUSrcA, ALUSrcB, mRD, mWR, DBDataSrc;
    

endmodule 
