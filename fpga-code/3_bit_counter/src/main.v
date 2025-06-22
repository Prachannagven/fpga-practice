module main(
    output wire clk_out,
    output wire clkd_out,
    output wire [5:0] led,
    output wire wire_out
);
    
    //Clock division portion
    wire osc_to_pll;
    wire div1_to_div2;
    wire div2_to_div3;
    wire div3_to_div4;
    wire div4_to_div5;
    wire div5_to_div6;
    wire div6_to_div7;
    wire small_clk;

    reg reset_reg = 1'b1;
       
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
        .clkout(small_clk), //output clkout
        .hclkin(div6_to_div7), //input hclkin
        .resetn(reset_reg) //input resetn
    );

    assign led[0] = small_clk;

    //Actual Counter Portion
    wire op_Q1;
    wire op_Q1_bar;    
    wire op_Q2;
    wire op_Q2_bar;    
    wire op_Q3;
    wire op_Q3_bar;

    jk_flipflop Q1
       (.clk(small_clk),
        .rst(1'b0),
        .j(1'b1),
        .k(1'b1),
        .Q(op_Q1),
        .Q_bar(op_Q1_bar)
       );

    jk_flipflop Q2
       (.clk(op_Q1),
        .rst(1'b0),
        .j(1'b1),
        .k(1'b1),
        .Q(op_Q2),
        .Q_bar(op_Q2_bar)
       );

    jk_flipflop Q3
       (.clk(op_Q2),
        .rst(1'b0),
        .j(1'b1),
        .k(1'b1),
        .Q(op_Q3),
        .Q_bar(op_Q3_bar)
       );

    assign led[5] = op_Q1;
    assign led[4] = op_Q2;
    assign led[3] = op_Q3;
    assign wire_out = led[3];
endmodule