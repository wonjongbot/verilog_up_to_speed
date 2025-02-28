module baude_gen(
    input logic i_clk, i_rst_n,
    input logic [10:0] i_divisor,
    output logic o_tick
    );

    logic [10:0] r_reg;
    logic [10:0] r_next;

    always_ff @(posedge i_clk) begin
        if (~i_rst_n)
            r_reg <= 0;
        else
            r_reg <= r_next;
    end

    assign r_next = (r_reg == i_divisor) ? 0 : r_reg + 1;
    assign o_tick = (r_reg == 1);

endmodule
