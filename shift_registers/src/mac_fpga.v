module shift_registers(
    input wire [1:0] cmd,
    input wire       clk,
    input wire       d_in,
    output wire      d_out,
    output wire [5:0] led
);


    parameter WIDTH = 3;

    //Writing out the remainder of the wires from the diagram
    wire [(WIDTH-1):0] a_out;
    wire [(WIDTH-1):0] b_out;
    wire [(2*WIDTH-1):0] sum_in;
    wire [(2*WIDTH-1):0] sum_out;
    wire reset;
    wire p_ld;
    wire ab_en;
    wire ab_clk;
    wire c_en;
    wire c_clk;

    assign ab_clk = ab_en&clk;              //Clock is set up to only enable the device when clock is high
    assign c_clk = c_en&clk;                //Similar clock setup for the PIPO register

    //You can get these commands by drawing the complete table then drawing kmaps to find the signal requirements
    assign reset = ~(cmd[1] | cmd[0]);      //Assigning the reset command to the reset wire
    assign p_ld = cmd[1] * (~cmd[0]);       //Assigning the parallel load command based on the command bits
    assign c_en = cmd[1] | (~cmd[0]);       //Assigning the c_en based on command bits
    assign ab_en = ~cmd[1];                 //Assigning the ab_en based on the command bits


    //Initializing the two SIPO shift registers so that we can input data
    sipo #(.WIDTH(WIDTH)) a
       (.clk(ab_clk),
        .reset(reset),
        .s_in(d_in),
        .p_out(a_out)
       );

    sipo #(.WIDTH(WIDTH)) b
       (.clk(ab_clk),
        .reset(reset),
        .s_in(a_out[0]),
        .p_out(b_out)
       );

    //Initializing the PIPO register to act like we want it to
    pipo #(.WIDTH(2*WIDTH)) c
       (.reset(reset),
        .clk(c_clk),
        .p_ld(p_ld), 
        .s_in(sum_out[2*WIDTH-1]),
        .p_in(sum_out), 
        .p_out(sum_in)
       );

    assign sum_out = a_out*b_out + sum_in;
    assign d_out = sum_in[2*WIDTH-1];

    //Using the built in LEDs for debugging the code
    assign led[2:0] = a_out;
    assign led[5:3] = b_out;
        
endmodule