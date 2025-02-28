module uart
    #(
        parameter   int DBIT = 8,
                    int SB_TICK = 16
    )
    (
        input logic i_clk, i_rst_n,
        input [10:0] divisor,
        input [DBIT-1:0] tx_din,
        output [DBIT-1:0] rx_dout,
        output logic o_tx_busy, o_rx_busy
    );

    logic tick;

    logic tx2rx;

    baude_gen u_baude_gen (.i_clk(i_clk), .i_rst_n(i_rst_n), .i_divisor(divisor), .o_tick(tick));
    uart_tx #(.DBIT(DBIT), .SB_TICK(SB_TICK)) u_uart_tx
        (   .i_clk(i_clk), .i_rst_n(i_rst_n), .i_tx_en(1'b1), .i_tick(tick),
            .i_din(tx_din), .o_tx_busy(o_tx_busy), .o_tx(tx2rx)  );

    uart_rx #(.DBIT(DBIT), .SB_TICK(SB_TICK)) u_uart_rx
        (   .i_clk(i_clk), .i_rst_n(i_rst_n), .i_rx(tx2rx),
            .i_tick(tick), .o_dout(rx_dout), .o_rx_busy(o_rx_busy));
endmodule
