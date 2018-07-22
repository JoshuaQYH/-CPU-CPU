`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/30 21:38:04
// Design Name: 
// Module Name: selector3to1
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

module selector3to1(
	 pcPlusFour,
	 extendImm,
	 jumpAddress,
	 PCsrc,
	 result
);

	input wire[31:0] pcPlusFour;    // 0 1
	input wire[31:0] extendImm;     // 1
	input wire[31:0] jumpAddress;   // 2
	input [1:0] PCsrc;               // �����ź���

	output reg[31:0] result;       // ������һ��ָ���ַ

	always @( pcPlusFour or extendImm or jumpAddress or PCsrc)begin
		case (PCsrc)
			2'b00: result = pcPlusFour;
			2'b01: result = pcPlusFour + (extendImm << 2);
			2'b10: result = jumpAddress;
			default:begin
			     result = result;  // ����
			end
					//$display (" no match");
		endcase
	end

endmodule
