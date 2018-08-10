`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/15 11:11:30
// Design Name: 
// Module Name: Selector41_32bits
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
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/15 10:57:37
// Design Name: 
// Module Name: Selector41_31bits
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


module Selector41_32bits(
  PCPlusFourAddress, ExtendedImmediate, ReadData1, ExtendedAddress, PCSrc, NextAddress
);
    input wire[31:0] PCPlusFourAddress;  // PC + 4  ��ַ
    input wire[31:0] ExtendedImmediate;  // ��������չ
    input wire[31:0] ReadData1;          // �Ĵ��� rs ���ֵ
    input wire[31:0] ExtendedAddress;    //��תָ����չ��ַ
    input [1:0] PCSrc;              // �����ź�
    output reg[31:0] NextAddress;        // ������һ��ָ���ַ
    
    always @( PCPlusFourAddress or ExtendedImmediate or ReadData1 or ExtendedAddress or PCSrc)begin
            case (PCSrc)
                2'b00: NextAddress = PCPlusFourAddress;                             // ˳��ִ��
                2'b01: NextAddress = PCPlusFourAddress + (ExtendedImmediate << 2);  // ��֧��ת
                2'b10: NextAddress = ReadData1;                                     // �Ĵ���Ѱַ
                2'b11: NextAddress = ExtendedAddress;                               // ��ת��ַ
                default:begin
                     NextAddress = NextAddress;  // ����ԭ��ַ����
                end                        //$display (" no match");
            endcase
        end
    
endmodule
