module main(
    output wire clk_out,
    output wire clkd_out,
    output wire [5:0] led
);
    
    wire osc_to_pll;
    wire div1_to_div2;
    wire div2_to_div3;
    wire div3_to_div4;
    wire div4_to_div5;
    wire div5_to_div6;
    wire div6_to_div7;

    reg reset_reg = 1'b1;
    
    //I wanted to seee all the other frequencies on the LEDs so I did this
    assign led[5] = div2_to_div3;
    assign led[4] = div3_to_div4;
    assign led[3] = div4_to_div5;
    assign led[2] = div5_to_div6;
    assign led[1] = div6_to_div7;
    //assign led[0] = div2_to_div3;

    
    Gowin_OSC osc(
        .oscout(osc_to_pll) //output oscout
    );

    Gowin_rPLL pll(
        .clkout(clk_out), //output clkout
        .clkoutd(clkd_out), //output clkoutd
        .clkin(osc_to_pll) //input clkin
    );

    Gowin_CLKDIV clkDiv1(
        .clkout(div1_to_div2), //output clkout
        .hclkin(clkd_out), //input hclkin
        .resetn(reset_reg) //input resetn
    );


    Gowin_CLKDIV clkDiv2(
        .clkout(div2_to_div3), //output clkout
        .hclkin(div1_to_div2), //input hclkin
        .resetn(reset_reg) //input resetn
    );


    Gowin_CLKDIV clkDiv3(
        .clkout(div3_to_div4), //output clkout
        .hclkin(div2_to_div3), //input hclkin
        .resetn(reset_reg) //input resetn
    );


    Gowin_CLKDIV clkDiv4(
        .clkout(div4_to_div5), //output clkout
        .hclkin(div3_to_div4), //input hclkin
        .resetn(reset_reg) //input resetn
    );


    Gowin_CLKDIV clkDiv5(
        .clkout(div5_to_div6), //output clkout
        .hclkin(div4_to_div5), //input hclkin
        .resetn(reset_reg) //input resetn
    );


    Gowin_CLKDIV clkDiv6(
        .clkout(div6_to_div7), //output clkout
        .hclkin(div5_to_div6), //input hclkin
        .resetn(reset_reg) //input resetn
    );


    Gowin_CLKDIV clkDiv7(
        .clkout(led[0]), //output clkout
        .hclkin(div6_to_div7), //input hclkin
        .resetn(reset_reg) //input resetn
    );


endmodule