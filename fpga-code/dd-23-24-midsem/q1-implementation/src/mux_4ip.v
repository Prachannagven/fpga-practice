module mux_4ip(
    input wire [3:0] external_ip,
    input wire [1:0] control_ip,
    input wire en,
    output reg mux_op
);

    always @(*) begin
        if (en) begin
            case (control_ip)
                2'b00: mux_op = external_ip[0];
                2'b01: mux_op = external_ip[1];
                2'b10: mux_op = external_ip[2];
                2'b11: mux_op = external_ip[3];
                default: mux_op = 1'b0;
            endcase
        end else begin
            mux_op = 1'b0;
        end
    end

endmodule
