`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/20/2021 06:25:42 PM
// Design Name: 
// Module Name: squarewave
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


module squarewave(
    input clk,
    input rst_n,

    input signed [13:0] sigin,
    output reg sigout
    );

    reg signed [13:0] x;
    reg temp1;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            x <= 14'd0;
        end
        else
            x <= sigin;
    end

    always @(*) begin
        temp1 = (x > 14'd5000)? 1'b1:1'b0;
    end

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) 
            sigout <= 14'd0;
        else
            sigout <= temp1;
    end 
endmodule
