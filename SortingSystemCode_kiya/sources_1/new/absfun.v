`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/15/2021 11:58:19 AM
// Design Name: 
// Module Name: absfun
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


module absfun(
    input clk,
    input rst_n,
    input signed [13:0] sigin,
    output reg signed [13:0] sigout
    );

    reg signed [13:0] datain, dataout;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            datain <= 14'd0;
        end
        else
            datain <= sigin;
    end

    always @(*) begin
        //dataout = (datain > 0) ? datain : -datain;
        dataout = (datain > 0) ? datain : 0;
    end

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            sigout <= 14'd0;
        end
        else
            sigout <= dataout;
    end
    

endmodule
