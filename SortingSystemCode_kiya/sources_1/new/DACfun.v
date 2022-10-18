`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/13/2021 10:22:32 AM
// Design Name: 
// Module Name: DACfun
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


module DACfun(
    input clk,
    input clk_90,
    input rst_n,
    input signed [13:0] channel1,
    input signed [13:0] channel2,

    output dac_ch0_clk,
    output dac_ch0_wrt,
    output dac_ch1_clk,
    output dac_ch1_wrt,
    output [13:0] dac_ch0_data,
    output [13:0] dac_ch1_data
    );

    reg signed [13:0] out1;
    reg signed [13:0] out2;

    always @(posedge clk_90 or negedge rst_n) begin
        if(!rst_n) begin
            out1 <= 0;
            out2 <= 0;
        end
        else begin
            out1 <= channel1 + 14'h2000;
            out2 <= channel2 + 14'h2000;
        end
    end 

    assign dac_ch0_clk = clk;
    assign dac_ch0_wrt = clk;
    assign dac_ch0_data = out1;

    assign dac_ch1_clk = clk_90;
    assign dac_ch1_wrt = clk_90;
    assign dac_ch1_data = out2;
endmodule
