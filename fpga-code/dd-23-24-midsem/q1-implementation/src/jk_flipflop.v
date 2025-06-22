module jk_flipflop(
    input wire j,
    input wire k,
    input wire rst,
    input wire clk,
    output reg Q,
    output wire Q_bar
);

    always @(posedge clk) 
        if(rst)
            Q <= 0;
        else if(~j && ~k)
            Q <= Q;
        else if(~j && k)
            Q <= 0;
        else if(j && ~k)
            Q <= 1;
        else if(j && k)
            Q <= Q_bar;
    

    assign Q_bar = ~Q;
endmodule