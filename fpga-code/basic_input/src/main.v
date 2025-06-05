// Simple module that routes input `d_in` to output `led`
module main (
    input wire clock,
    input wire [1:0] cmd,
    input wire d_in,      // Input signal (e.g., from a switch or button)
    output wire[5:0] led,        // Output signal (e.g., to an LED)
    output wire dout
);

    wire enable;
    wire reset;
    wire [5:0] a_out;

    assign enable = ~(cmd[0]&cmd[1]);
    assign reset = ~cmd[0]&cmd[1];

    sipo #(.WIDTH(6)) a
       (.clk(clock),
        .rst(reset),
        .s_in(d_in),
        .en(enable),
        .p_out(a_out)
       );
    
    assign led = ~a_out;

    

endmodule
