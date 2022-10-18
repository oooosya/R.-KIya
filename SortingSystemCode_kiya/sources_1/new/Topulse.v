`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/15/2021 02:55:53 PM
// Design Name: 
// Module Name: Topulse
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


module Topulse(
    input clk,
    input rst_n,
    input signed [13:0] sigin,
    output reg [1:0] sigout
    );

    reg signed [13:0] x;
    reg [2:0] trig;


    reg [1:0] pulse = 0;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            x <= 0;
        else
            x <= sigin;
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            trig = 3'b000; pulse <= 2'b00;
        end
        else if ((x > 14'd500) && (trig == 3'b000)) begin
            trig <= 3'b001; pulse <= 2'b00;
        end

        else if ((x < 14'd200) && (trig == 3'b001))begin
            trig <= 3'b111; pulse <= 2'b01;
        end
        //else if ((x < 14'd1000) && (trig == 3'b101))begin 
        //    trig <= 3'b000; pulse <= 14'd0;  
        //end


        else if ((x > 14'd1500) && (trig == 3'b001)) begin
            trig <= 3'b011; pulse <= 2'b00;
        end
        else if ((x < 14'd800) && (trig == 3'b011)) begin
            trig <= 3'b111; pulse <= 2'b10; 
        end


        else if ((x < 14'd200) && (trig == 3'b111)) begin
            trig <= 3'b000; pulse <= 2'b00;   
        end

        else begin
            trig <= trig; pulse <= 2'b00;
        end
    end
    
    ////////////////////////////////////////////
    //always @(posedge clk) begin
    //    case(trig3)
    //        8'd1: begin
    //                counter <= 2;
    //                if ((width == 0) && (counter != 0)) begin
    //                    sq_wave_reg <= (!sq_wave_reg) * 14'd400;
    //                    if (counter != 0) begin
    //                        width <= 3;
    //                        counter <= counter - 1;
    //                    end
    //                    else
    //                        width <= width - 1;
    //                end
    //                trig3 <= 8'd0;         
    //            end
//
//            8'd2: begin
    //            counter <= 4;
    //            if ((width == 0) && (counter != 0)) begin
    //                sq_wave_reg <= (!sq_wave_reg) * 14'd400;
    //                if (counter != 0) begin
    //                    width <= 3;
    //                    counter <= counter - 1;
    //                end
    //                else
    //                    width <= width - 1;
    //            end
    //            trig3 <= 8'd0;   
    //        end

    //        default:
    //            trig3 <= 8'd0;
    //    endcase
//    end
///////////////////////////////////////////////////////

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            sigout <= 2'b00;
        end
        else
            sigout <= pulse;
    end
endmodule
