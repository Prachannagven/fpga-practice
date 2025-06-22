module PinCounter(
    input sys_clk,          //clk input
    input sys_rst_n,        //reset mapped to the button on the board
    output reg pin_84,      //External pin connected to 84
    output reg out_z        //Mapped output
);
    //Counter state var
    reg [15:0] counter;

    //Flag to track the previous pin value
    reg prev_sys_rst_n;
    
    always @(posedge sys_clk) begin
        if(sys_rst_n !== prev_sys_rst_n && !sys_rst_n) begin
            counter <= counter + 1'b1;
            pin_84 = !pin_84;
        end
        prev_sys_rst_n <= sys_rst_n;
    end
endmodule