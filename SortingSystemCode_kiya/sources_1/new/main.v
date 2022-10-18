`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/13/2021 10:40:52 AM
// Design Name: 
// Module Name: main
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


module main(
    input sys_clk_p,
    input sys_clk_n,
    input rst_n,

    output dac_ch0_clk,
    output dac_ch0_wrt,
    output [13:0] dac_ch0_data,

    output dac_ch1_clk,
    output dac_ch1_wrt,
    output [13:0] dac_ch1_data, 


	output adc1_clk_ref,//clk to first AD9627
	output adc2_clk_ref,//clk to second AD9627
	
	output adc1_spi_ce, //adc1 chip spi select
	output adc1_spi_sclk,//adc1 spi clk
	inout  adc1_spi_io,  //spi data
	input  adc1_clk_p,  //adc1 clk from ad9627
	input  adc1_clk_n,	
	input[11:0] adc1_data_p, //adc1 data
	input[11:0] adc1_data_n,
	
	output adc2_spi_ce,//adc2 chip spi select
	output adc2_spi_sclk,//adc2 spi clk
	inout  adc2_spi_io,//spi data
	input  adc2_clk_p,//adc2 clk from ad9627
	input  adc2_clk_n,
	input[11:0] adc2_data_p,//adc2 data
	input[11:0] adc2_data_n
    );

    wire locked;
    wire clk_50m;
    wire clk_100m;
    wire clk_100m_90;

    wire signed [11:0] ad1_a, ad1_b, ad2_a, ad2_b;
    
    reg signed [13:0] channel1_temp, channel2_temp;
    wire signed [13:0] channel1, channel2;
    wire [1:0] trig1, trig2;
    wire signed [13:0] topulse_temp1, toabs, toout;
    wire signed [13:0] DCcomponents;
    wire [31:0] counts;
    wire toenhance;

    always @(posedge clk_100m or negedge rst_n) begin
        if (!rst_n) begin
            channel1_temp <= 0;
            channel2_temp <= 0;
        end
            channel1_temp <= -{ad1_b,{2{1'b0}}};
            channel2_temp <= {ad2_a,{2{1'b0}}};
    end

    //RemoveDCfun u_noDC(
    //.clk(clk_100m),
    //.rst_n(rst_n),
    //.sigin(channel1_temp),
    //.sigout(toabs)
    //);



   // absfun u_abs1(
    //    .clk(clk_100m),
    //    .rst_n(rst_n),
    //    .sigin(toabs),
    //    .sigout(topulse_temp1)
    //);


    absfun u_abs1(
        .clk(clk_100m),
        .rst_n(rst_n),
        .sigin(channel1_temp),
        .sigout(toout)
    );

    squarewave u_square(
        .clk(clk_100m),
        .rst_n(rst_n),

        .sigin(toout),
        .sigout(toenhance)
    );

    waveEnhance u_enhance(
        .clk(clk_100m),
        .rst_n(rst_n),

        .sigin(toenhance),
        .sigout(channel1)
    );

    clk_wiz_0 u_clk
    (
    // Clock out ports
    .clk_100m(clk_100m),     // output clk_100m
    .clk_100m_90(clk_100m_90),     // output clk_100m_90
    .clk_50m(clk_50m),     // output clk_50m
    // Status and control signals
    .resetn(rst_n), // input resetn
    .locked(locked),       // output locked
   // Clock in ports
    .clk_in1_p(sys_clk_p),    // input clk_in1_p
    .clk_in1_n(sys_clk_n));    // input clk_in1_n

    DACfun u_dac(
        .clk(clk_100m), 
        .clk_90(clk_100m_90),     
        .rst_n(rst_n),
        .channel1(channel1),     
        .channel2(toout),
        .dac_ch0_clk(dac_ch0_clk),
        .dac_ch1_clk(dac_ch1_clk),
        .dac_ch0_wrt(dac_ch0_wrt),
        .dac_ch1_wrt(dac_ch1_wrt),
        .dac_ch0_data(dac_ch0_data),
        .dac_ch1_data(dac_ch1_data)
    );

    ADCfun u_adc(
    .sys_clk_p(sys_clk_p),
	.sys_clk_n(sys_clk_n),
    .clk_50m(clk_50m),
    .clk_125m(clk_100m),
    .locked(locked),
	.rst_n(rst_n),        //low reset
	.adc1_clk_ref(adc1_clk_ref),//clk to first AD9627
	.adc2_clk_ref(adc2_clk_ref),//clk to second AD9627
	
	.adc1_spi_ce(adc1_spi_ce), //adc1 chip spi select
	.adc1_spi_sclk(adc1_spi_sclk),//adc1 spi clk
	.adc1_spi_io(adc1_spi_io),  //spi data
	.adc1_clk_p(adc1_clk_p),  //adc1 clk from ad9627
	.adc1_clk_n(adc1_clk_n),	
	.adc1_data_p(adc1_data_p), //adc1 data
	.adc1_data_n(adc1_data_n),
	
	.adc2_spi_ce(adc2_spi_ce),//adc2 chip spi select
	.adc2_spi_sclk(adc2_spi_sclk),//adc2 spi clk
	.adc2_spi_io(adc2_spi_io),//spi data
	.adc2_clk_p(adc2_clk_p),//adc2 clk from ad9627
	.adc2_clk_n(adc2_clk_n),
	.adc2_data_p(adc2_data_p),//adc2 data
	.adc2_data_n(adc2_data_n),

    .adc1_data_a_d0(ad1_a),
    .adc1_data_b_d0(ad1_b),
    .adc2_data_a_d0(ad2_a),
    .adc2_data_b_d0(ad2_b)
    );

    design_1_wrapper u_arm(
        .maxihpm0_lpd_aclk_0(clk_100m)
        );

    ila_0 u_ila (
	.clk(clk_100m), // input wire clk


	.probe0(-ad1_b), // input wire [0:0]  probe0
    .probe1(toabs),  
	.probe2(topulse_temp1), // input wire [0:0]  probe2 
    .probe3(channel1)
    );


endmodule
