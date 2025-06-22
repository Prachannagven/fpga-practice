module main (
    input wire clk,
    output wire [5:0] led
);
    localparam WAIT_TIME = 27000000;
    reg [5:0] ledCounter = 6'b0;
    reg [24:0] clkCounter = 25'b0;
    
    clock_divider #(
        .DIVISOR(2700000)
    ) div_10Hz (
        .clk(clk),
        .rst(1'b0),
        .clk_out(clk_10Hz)
    );

    always @(posedge clk_10Hz) begin
        ledCounter <= ledCounter + 1'b1;
    end

    assign led = ~ledCounter;

endmodule