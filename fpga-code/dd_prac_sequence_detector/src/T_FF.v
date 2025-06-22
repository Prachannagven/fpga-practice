module T_FF
   (input wire T,
    input wire RST,
    input wire CLK,
    output reg Q_out,
    output wire Q_out_bar
   );

    always @(posedge CLK) begin
        if(~RST)
            Q_out <= 1'b0;
        else if(T)
            Q_out <= ~Q_out;
        else 
            Q_out <= Q_out;
    end
    
    assign Q_out_bar = ~Q_out;

endmodule