`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/17/2021 03:57:43 AM
// Design Name: 
// Module Name: pulseGeneratorfun
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


module pulseGeneratorfun(
    input clk,
    input rst_n,
    input [1:0] repeats,
    input trigger,

    output reg ena,
    output reg signed [13:0] sigout
    );

    reg [10:0] N ;
    reg [10:0] waits ;
    reg [1:0] NUM = 2'b1;
    reg [1:0] limit;


    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            sigout <= 14'b0;
            NUM <= 2'b0;
            N <= 11'b0;
            waits <= 11'b0;
            ena <= 1'b1;
            limit <= 1'b0;
        end
        else if (trigger > 0) begin
            N <= 11'd200;
            waits <= 11'd400;
            NUM <= 2'b0;
            ena <= 1'b0;
            limit <= repeats;
        end

        else if ((NUM < limit) && (N > 11'd0) && (waits >= 11'd0)) begin
            sigout <= 14'd4096;
            N <= N - 11'b1;
            ena <= 1'b0;
        end
        else if ((NUM < limit) && (N == 11'd0) && (waits >= 11'd0)) begin
            ena <= 1'b0;
            if (waits>0) begin
                sigout <= 14'd0; waits <= waits - 11'b1;
            end
            else begin
                NUM <= NUM + 2'b1;waits <= 11'd400;N <= 11'd200;
            end
        end
        //else if ((NUM > repeats) && (N <= 11'd400)) begin
        //    ena <= 1'b1;
        //end
        //else if ((NUM < limit) && (N == 11'd0)  && (waits == 11'd0)) begin
        //    ena <= 1'b1;
        //    sigout <= 14'd0;
        //end

        else begin
            sigout <= 14'd0;
            ena <= 1'b1;
            waits <= 11'd0;
            N <= 11'd0;
        end
    end

endmodule
