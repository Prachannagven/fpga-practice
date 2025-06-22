module clk_divider #(
    parameter DIVISOR = 1350000
)(
    input wire clk_in,
    input wire rst,
    output reg clk_out
);

    localparam WIDTH = $clog2(DIVISOR + 1);
    reg [WIDTH-1:0] counter = 0;

    wire [WIDTH-1:0] max_count = (DIVISOR - 1) & ((1 << WIDTH) - 1);

    always @(posedge clk_in) begin
        if (rst) begin
            counter <= 0;
            clk_out <= 0;
        end else begin
            if (counter == max_count) begin
                counter <= 0;
                clk_out <= ~clk_out;
            end else begin
                counter <= counter + 1'd1;
            end
        end
    end

endmodule
