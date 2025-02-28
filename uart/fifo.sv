`default_nettype none;

module fifo #(
    parameter   int DATA_WIDTH = 8,
                int ADDR_WIDTH = 4
) (
    input   logic i_clk, i_rsn_n,
    input   logic i_rd, i_wr,
    input   logic [DATA_WIDTH-1:0] i_w_data,
    output  logic o_empty, o_full,
    output  logic [DATA_WIDTH-1:0] o_r_data
);

    reg_file #(.DATA_WIDTH(DATA_WIDTH), .ADDR_WIDTH(ADDR_WIDTH))
        u_reg_file (.i_clk(i_clk), .i_w_en(), .i_w_addr(), .i_r_addr(),
                    .i_w_data(), .i_r_data());
    
endmodule
