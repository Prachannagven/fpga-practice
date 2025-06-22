module sync_fifo(
    input wire clk,
    input wire rst_n,

    input wire wr_en_i,
    input wire [7:0] data_i,
    output wire full_o,
    
    input wire rd_en_i,
    output reg [7:0] data_0,
    output wire empt_o
);

    parameter DEPTH = 8;
    
    reg [7:0] mem [0:DEPTH-1];
    reg [2:0] wr_ptr;
    reg [2:0] rd_ptr;
    reg [3:0] count;
    
    assign full_o = (count == DEPTH) ? 1 : 0;   //Not necessary to use a ternery but i am because vibes
    assign empty_o = (count == 0) ? 1:0;
    
    //---Handling the writing of data to the FIFO ---//
    always @(posedge clk or negedge rst_n) begin
        if(~rst_n) begin
            wr_ptr <= 3'b0;
        end 
        else begin
            if(wr_en_i) begin
                mem[wr_ptr] <= data_i;
                wr_ptr <= wr_ptr +1;
            end
        end
    end

    //--- Handling the Reading to the FIFO ---//
    always @(posedge clk or negedge rst_n) begin
        if(~rst_n) begin
            rd_ptr <= 3'b0;
        end
        else if (rd_en_i) begin 
            data_o <= mem[rd_ptr];
            rd_ptr <= rd_ptr +1
        end
    end

    //--- Handling the count value ---//
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            count <= 4'd0;
        end
        else begin
            case ({wr_en_i, rd_en_i})
                2'b10: count <= count + 1;
                2'b01: count <= count - 1;
                2'b11: count <= count;
                2'b00: count <= count;
                default: count <= count;
            endcase
        end
    end


endmodule