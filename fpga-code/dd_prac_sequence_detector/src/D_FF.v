module D_FF
   (input wire D,
    input wire RST,
    input wire CLK,
    output reg Q_out,
    output wire Q_out_bar
   );

    always @(posedge CLK) begin
        if(~RST)
            Q_out <= 1'b0;
        else 
            Q_out <= D;
    end
    
    assign Q_out_bar = ~Q_out;

endmodule