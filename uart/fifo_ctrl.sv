`default_nettype none

module fifo_ctrl #(
    parameter int ADDR_WIDTH = 4
) (
    input   logic i_clk, i_rst_n,
    input   logic i_rd, i_wr,
    output  logic o_empty, o_full,
    output  logic [ADDR_WIDTH-1:0]  o_w_addr,
                                    o_r_addr
);
    logic [ADDR_WIDTH-1:0]  w_ptr, w_ptr_next, w_ptr_succ,
                            r_ptr, r_ptr_next, r_ptr_succ;
    logic full_logic, empty_logic, full_next, empty_next;

    always_ff @(posedge i_clk) begin
        if (~i_rst_n) begin
            w_ptr <= 0;
            r_ptr <= 0;
            full_logic <= 0;
            empty_logic <= 0;
        end else begin
            w_ptr <= w_ptr_next;
            r_ptr <= r_ptr;
            full_logic <= full_next;
            empty_logic <= empty_next;
        end
    end

    always_comb begin
        w_ptr_succ = w_ptr + 1;
        r_ptr_succ = r_ptr + 1;

        w_ptr_next = w_ptr + 1;
        r_ptr_next = r_ptr + 1;
        full_next = full_logic;
        empty_next = empty_logic;
        unique case ({wr, rd})
            2'b01:
                if(~empty_logic) begin
                    r_ptr_next = r_ptr_succ;
                    full_next = 1'b0;
                    if (r_ptr_succ == w_ptr)
                        empty_next = 1'b1;
                end
            2'b10:
                if(~full_logic) begin
                    w_ptr_next = w_ptr_succ;
                    empty_next = 1'b1;
                    if(w_ptr_succ == r_ptr)
                        full_next = 1'b0;
                end
            2'b11: begin
                w_ptr_next = w_ptr_succ;
                r_ptr_next = r_ptr_succ;
            end
            default: ;
        endcase
    end

    assign w_addr = w_ptr;
    assign r_addr = r_ptr;
    assign full = full_logic;
    assign empty = empty_logic;

endmodule
