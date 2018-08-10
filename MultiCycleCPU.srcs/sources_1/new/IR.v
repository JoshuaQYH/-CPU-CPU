`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/15 16:08:21
// Design Name: 
// Module Name: IR
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


module IR(
    IRWre, IDataOut, CLK, IRDataOut
);
    input  IRWre;          // IR �Ĵ���дʹ���ź�
    input [31:0] IDataOut;  // ����ָ��洢����ָ��ֵ
    input CLK;             //ʱ���ź�
    output reg [31:0] IRDataOut; // ָ��Ĵ��������ָ��ֵ 
    
   always @(negedge CLK )begin 
        if(IRWre == 1)
            IRDataOut = IDataOut;   //  ����ָ��Ĵ��������ֵ
        else
            IRDataOut = IRDataOut;  // �����������ֵ����
   end 
endmodule
