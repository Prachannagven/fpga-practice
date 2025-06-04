//Verilog code for a parallel input parallel output shift register
//Default width is 16 bits
//Should take a parallel input of the width and a parallel output of the width

module pipo #(parameter WIDTH = 16)
   (
    input wire reset,
    input wire clk,
    input wire p_ld,
    input wire s_in,
    input wire [(WIDTH-1):0] p_in,
    output reg [(WIDTH-1):0] p_out
   );

    always @(posedge clk)
        if(reset)
            p_out = 'b0;
        else if (p_ld)
            p_out = p_in;
        else
            p_out = {p_out[(WIDTH-1-1):0], s_in}; 

endmodule