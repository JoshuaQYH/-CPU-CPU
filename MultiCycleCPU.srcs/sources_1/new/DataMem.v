`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/06/15 10:07:42
// Design Name: 
// Module Name: DataMem
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


module DataMem(
 CLK, mWR,  mRD,  DataAddress,  DataIn, DataOut
);
        
    input mWR;
    input mRD;
    input CLK;
    input wire [31:0] DataAddress;
    input wire [31:0] DataIn;
    output reg [31:0] DataOut;
    reg [7:0] ram[0:63]; // ��˴洢
    
     initial begin
        DataOut = 0;
     end
       // ����ʹ���½��ش�������Ȼ�ᷢ�����ݳ�ͻ�����ݵ�ַ����һ��ָ��Ľ����
       always@( negedge CLK ) begin
           if( mWR == 1 ) begin   //д
               ram[DataAddress] <= DataIn[31:24];
               ram[DataAddress+1] <= DataIn[23:16];
               ram[DataAddress+2] <= DataIn[15:8];
               ram[DataAddress+3] <= DataIn[7:0];
          end
          else begin
           if(mRD == 1)begin    // ��
                  DataOut[31:24] = ram[DataAddress];
                  DataOut[23:16] = ram[DataAddress+1];
                  DataOut[15:8] = ram[DataAddress+2];
                  DataOut[7:0] = ram[DataAddress+3];
              end
              else if(mRD == 0)begin //����̬
                  DataOut[31:24] = 8'bz;
                  DataOut[23:16] = 8'bz;
                  DataOut[15:8] = 8'bz;
                  DataOut[7:0] = 8'bz;
              end
          end
        end
endmodule
