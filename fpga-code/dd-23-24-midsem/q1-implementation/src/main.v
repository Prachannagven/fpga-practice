module main (
    output wire clk_out,
    output wire clkd_out,
    output [5:0] led
);
    //We take the input from the 27MHz oscillator on board the FPGA, now I want to drop this down to 10MHz so we can see
    //Step 1: Get a useable frequency
    wire osc_to_pll;
    wire div1_to_div2;
    wire div2_to_div3;
    wire div3_to_div4;
    wire div4_to_div5;
    wire div5_to_div6;
    wire div6_to_div7;
    wire clk_in;

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
        .clkout(clk_in), //output clkout
        .hclkin(div6_to_div7), //input hclkin
        .resetn(reset_reg) //input resetn
    );


    //Initializing the various wires for the flip flops
    wire QA_out;
    wire QA_out_bar;
    wire QB_out;
    wire QB_out_bar;
    wire QC_out;    
    wire QC_out_bar;

    wire mux_res;

    //4 Input Mux for control signal of QA flip flop
    mux_4ip mux1
       (.external_ip({1'b1, 1'b0, 1'b0, 1'b1}),
        .control_ip({QB_out, QC_out}),
        .en(1'b1),
        .mux_op(mux_res)
       );
    
    //Initializing the flip flops to count in 4->2->1->0->5->3->4....
    jk_flipflop QA_ff
       (.j(mux_res),
        .k(1'b1),
        .clk(clk_in),
        .rst(1'b0),
        .Q(QA_out),
        .Q_bar(QA_out_bar)
       );

    jk_flipflop QB_ff
       (.j(QA_out),
        .k(1'b1),
        .clk(clk_in),
        .rst(1'b0),
        .Q(QB_out),
        .Q_bar(QB_out_bar)
       );

    t_flipflop QC_ff
       (.t_state(QA_out_bar),
        .clk(clk_in),
        .rst(1'b0),
        .Q(QC_out),
        .Q_bar(QC_out_bar)
       );

    assign led[0] = clk_in; //So that we can see the clock
    assign led[5] = ~QC_out;
    assign led[4] = ~QB_out;
    assign led[3] = ~QA_out;

endmodule