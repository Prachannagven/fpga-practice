module clock_divider #(
    parameter DIVISOR = 13500000  // Divide by 2 × DIVISOR
)(
    input wire clk,           // Input clock
    input wire rst,           // Synchronous reset
    output reg clk_out        // Output divided clock
);

    localparam WIDTH = $clog2(DIVISOR + 1);
    reg [WIDTH-1:0] clkCounter = 0;

    always @(posedge clk) begin
        if (rst) begin
            clkCounter <= 0;
            clk_out <= 0;
        end else begin
            if (clkCounter == DIVISOR - 1'd1) begin
                clkCounter <= 0;
                clk_out <= ~clk_out;
            end else begin
                clkCounter <= clkCounter + 1'b1;
            end
        end
    end

endmodule
