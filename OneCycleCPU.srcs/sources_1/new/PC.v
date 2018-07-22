`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/30 21:34:43
// Design Name: 
// Module Name: PC
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

// PC���������
module PC(
	 clk,    //ʱ���ź�
	 reset,  //��λ
	 input_pc,  //������һ��ָ���ַ
	 output_pc, //�����ǰָ���ַ
	 PCWre   //ͣ��ָ��
);
	 input wire[31:0] input_pc;
	 output reg[31:0] output_pc;
	 input clk, reset, PCWre;

    //�ȴ�ʱ��������
	always@(posedge clk)begin
		if(reset == 0)begin  //��ʼ��
			output_pc = 0;
		end
		else if(!PCWre)begin  //ͣ��
			output_pc = output_pc;
		end
		else if(PCWre)begin   //��ͣ������һ��ָ���ַ��Ϊ��ǰָ���ַ
			output_pc = input_pc;
		end
	end

endmodule