`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/05/30 21:37:44
// Design Name: 
// Module Name: selector5
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
//��λ����ѡ����
module selector5(
	 control,
	 data1,
	 data2,
	 result
);
    
	input  control;  //�����ź�
	input wire [4:0] data1;   
	input wire [4:0] data2;
	output wire [4:0] result;
	assign result = (control == 0)? data1:data2; //�����ź�Ϊ1��ѡdata1,����data2
	
endmodule  
