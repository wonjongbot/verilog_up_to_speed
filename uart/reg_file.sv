`default_nettype none;

module reg_file
#(
    parameter   int DATA_WIDTH = 8,
                int ADDR_WIDTH = 4
)
(
    input  logic i_clk,
    input  logic i_w_en,
    input  logic [ADDR_WIDTH-1:0] i_w_addr, i_r_addr,
    input  logic [DATA_WIDTH-1:0] i_w_data,
    output logic [DATA_WIDTH-1:0] o_r_data
);
    logic [DATA_WIDTH-1:0] regs [2**ADDR_WIDTH];

    always_ff @(posedge i_clk) begin
        if (i_w_en)
            regs[i_w_addr] <= i_w_data;
    end

    assign o_r_data = regs[i_r_addr];

endmodule
