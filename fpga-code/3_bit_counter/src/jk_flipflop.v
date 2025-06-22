module jk_flipflop(
    input wire j,
    input wire k,
    input wire clk,
    input wire rst,
    output reg Q,
    output wire Q_bar
);
    
    always @(posedge clk or posedge rst) begin
        if (rst)
            Q <= 0;
        else if (j && k)
            Q <= ~Q;
        else if (j)
            Q <= 1;
        else if (k)
            Q <= 0;
    end

    assign Q_bar = ~Q;
            
endmodule