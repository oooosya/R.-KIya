`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/17/2021 01:10:20 AM
// Design Name: 
// Module Name: triggerfun
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


module triggerfun(
    input clk,
    input rst_n,
    input [1:0] sigin,
    output reg signed [13:0] sigout
    );

    
    
    reg [1:0] x;
    wire signed [13:0] y;
    wire workingline;
    reg trigger;
    

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            x <= 2'b00;
            trigger <= 1'b1;
        end
        else if((workingline)&&(sigin > 0)) begin
            trigger <= (sigin > 0);
            x <= sigin;
        end
        else begin
            x <= 0; trigger <= 1'b0;
        end
    end

    pulseGeneratorfun u_sigGen(
        .clk(clk), 
        .rst_n(rst_n),
        .ena(workingline), 
        .trigger(trigger),
        .repeats(x),
        .sigout(y)
    );


    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            sigout <= 0;
        end
        else
            sigout <= y;
    end

    ila_1 u_ila2 (
	.clk(clk), // input wire clk


	.probe0(workingline), // input wire [0:0]  probe0  
	.probe1(trigger), // input wire [0:0]  probe1 
	.probe2(x), // input wire [1:0]  probe2 
	.probe3(y), // input wire [13:0]  probe3
    .probe4(sigin) //
    );


endmodule
