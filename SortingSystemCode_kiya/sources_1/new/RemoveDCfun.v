`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/13/2021 06:28:07 PM
// Design Name: 
// Module Name: RemoveDCfun
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


module RemoveDCfun(
    input clk,
    input rst_n,
    input signed [13:0] sigin,
    output reg signed [13:0] sigout
    );
    
    reg signed [13:0] datain, datamean;
    reg signed [13:0] datamax = 14'b10000000000000;
    reg signed [13:0] datamin = 14'b01111111111111;
    reg [31:0] counter;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            counter <= 0;
        end
        else 
            counter <= (counter < 32'd100_000_005) ? (counter + 32'd1) : 32'd100_000_005;
    end

    always @(posedge clk or negedge rst_n) begin // control the system sample at the clk rate
        if (!rst_n) begin
            datain <= 0;
        end
        else
            datain <= sigin;
    end

    always @(*) begin
        if ((counter < 32'd100_000_005) && (counter > 32'd100_000_000)) begin
            datamax = (datain > datamax) ? datain : datamax;
            datamin = (datain < datamin) ? datain : datamin;
        end
        else if (counter <= 32'd100_000_000) begin
            datamax = 14'b10000000000000;
            datamin = 14'b01111111111111;
        end
        else if (counter == 32'd100_000_005) begin
            datamax <= datamax;
            datamin <= datamin;
            datamean = (datamin>>>1) + (datamax>>>1);
        end
    end

    always @(posedge clk or negedge rst_n) begin // control the system sample at the
        if (!rst_n) begin
            sigout <= 0;
        end
        else
            sigout <= datain - datamin;
    end

endmodule
