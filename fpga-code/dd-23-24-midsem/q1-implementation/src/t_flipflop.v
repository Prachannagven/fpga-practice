module t_flipflop(
    input wire t_state,
    input wire clk,
    input wire rst,
    output reg Q,
    output wire Q_bar
);

    always @(posedge clk)
        if(rst)
            Q <= 0;
        else if(t_state)
            Q <= ~Q;
        else if(~t_state)
            Q <= Q;


    assign Q_bar = ~Q;

endmodule