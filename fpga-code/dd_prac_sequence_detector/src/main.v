module main(
    input wire CLK_sig,
    input wire SIG_sig,
    input wire RST_sig,
    output wire [5:0] LEDs
);

    //Initializing Wires
    wire Q_A_sig;
    wire Q_B_sig;
    wire Q_A_bar;
    wire Q_B_bar;
    wire D_A_sig;
    wire D_B_sig;
    wire OUTPUT_sig;

    //Command statements
    assign D_A_sig = (Q_A_sig&Q_B_bar) | (SIG_sig&Q_A_bar&Q_B_bar);
    assign D_B_sig = (SIG_sig&Q_A_bar&Q_B_bar) | (SIG_sig&Q_A_sig&Q_B_sig) | ((~SIG_sig)&Q_A_sig&Q_B_sig);

    D_FF FF_A
       (.RST(RST_sig),
        .D(D_A_sig),
        .CLK(CLK_sig),
        .Q_out(Q_A_sig),
        .Q_out_bar(Q_A_bar)
       );   
 
    D_FF FF_B
       (.RST(RST_sig),
        .D(D_B_sig),
        .CLK(CLK_sig),
        .Q_out(Q_B_sig),
        .Q_out_bar(Q_B_bar)
       );

    assign OUTPUT_sig = Q_A_sig&Q_B_sig&(SIG_sig);
    assign LEDs[0] = ~OUTPUT_sig; //Because the LED on board the Tang Nano 9k is an active low LED, so needs to be inverted
    assign LEDs[1] = OUTPUT_sig;//LED 10
    assign LEDs[2] = ~CLK_sig;  //LED 16
    assign LEDs[3] = ~SIG_sig;  //LED 15
    assign LEDs[4] = ~Q_A_sig;  //LED 14
    assign LEDs[5] = ~Q_B_sig;  //LED 13

endmodule