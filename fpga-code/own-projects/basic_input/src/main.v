// Simple module that routes input `state` to output `led`
module main (
    input wire clock,
    input wire reset,
    input wire state,      // Input signal (e.g., from a switch or button)
    output wire[5:0] led        // Output signal (e.g., to an LED)
);
    wire [5:0] a_out;

    sipo #(.WIDTH(6)) a
       (.clk(clock),
        .rst(reset),
        .s_in(state),
        .p_out(a_out)
       );
    
    assign led = ~a_out;

endmodule
