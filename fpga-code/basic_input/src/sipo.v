//Single input parallel output shift register
//I want reset, data in, data out and a clock, as well as enable

module sipo #(parameter WIDTH=6)
   (
    input wire clk,
    input wire rst,
    input wire s_in,
    output reg [WIDTH-1:0] p_out
   );

    always @(posedge clk)
        if (rst)
            p_out <= 0;
        else
            p_out <= {s_in, p_out[WIDTH-1:1]};
endmodule