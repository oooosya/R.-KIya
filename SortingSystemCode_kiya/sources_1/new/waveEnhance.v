`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/21/2021 04:09:05 PM
// Design Name: 
// Module Name: waveEnhance
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


module waveEnhance(
    input clk,
    input rst_n,
    
    input sigin,
    output reg signed [14:0] sigout
    );

    reg [13:0] counters;
    reg signed [13:0] x, x1, temp1;
    

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            x <= 1'b0;x1 <= 1'b0;
        end
        else begin
            x <= sigin;
            x1 <= x;
        end
    end

    always @(posedge clk or negedge rst_n) begin
            if (!rst_n) begin
                counters = 14'd0;
                temp1 = 14'd0;
            end
            else if ((x-x1)>0) begin
                temp1 = 14'd6000;
                counters = counters + 14'b1;
            end
            else if ((counters > 14'd0) && (counters < 14'd200)) begin
                temp1 = 14'd6000;
                counters = counters + 14'b1;
            end
            //else if (counters >= 14'd200) begin
            //    temp1 = 14'd0;
            //    counters = 0;
            //end
            else begin
                temp1 <= 14'd0;
                counters = 0;
            end
        end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            sigout <= 14'd0;
        end
        else
            sigout <= temp1;
    end

endmodule
