//sipo_sr

//Serial Input Parallel Output Shift Register
//if Reset = 1, the register resets to 0
//otherwise shift all bits by 1 and load the new bit
//Default value of Width is 16, but you can also load a custom one in the top leve module

module sipo #(parameter WIDTH = 16)
    (
    input wire clk,
    input wire reset,
    input wire s_in,
    output reg [(WIDTH-1):0] p_out
    );

    
    always @(posedge clk)
        if(reset)
            p_out = 'b0;
        else
            p_out <= {s_in, p_out[(WIDTH-1):1]};
endmodule