/* verilator lint_off WIDTHEXPAND */
`default_nettype none;
module uart_rx
    #(
    parameter   int DBIT = 8,
                int SB_TICK = 16
    )
    (
    input logic i_clk, i_rst_n,
    input logic i_rx, i_tick,
    output logic [DBIT-1:0] o_dout,
    output logic o_rx_busy, o_rx_valid
    );
    parameter int SMP_SIZE_LOG = 4;
    // fsm states
    typedef enum {IDLE, START, DATA, STOP} state_t;

    state_t state, state_next;
    logic [SMP_SIZE_LOG - 1:0] smp_ctr, smp_ctr_next;
    logic [$clog2(DBIT)-1:0] n_bits, n_bits_next;
    logic [DBIT-1:0] rs_reg, rs_next;

    always_ff @(posedge i_clk)begin
        if(~i_rst_n) begin
            state <= IDLE;
            smp_ctr <= 0;
            n_bits <= 0;
            rs_reg <= 0;
        end
        else begin
            state <= state_next;
            smp_ctr <= smp_ctr_next;
            n_bits <= n_bits_next;
            rs_reg <= rs_next;
        end
    end

    always_comb begin
        state_next = state;
        o_rx_busy = 1'b1;
        smp_ctr_next = smp_ctr;
        n_bits_next = n_bits;
        rs_next = rs_reg;

        case (state)
            IDLE: begin
                if(~i_rx) begin
                    state_next = START;
                    smp_ctr_next = 0;
                end
            end
            START: begin
                if(i_tick) begin
                    if(smp_ctr == ((1 << SMP_SIZE_LOG) - 1)/2) begin
                        state_next = DATA;
                        smp_ctr_next = 0;
                        n_bits_next = 0;
                    end
                    else begin
                        smp_ctr_next = smp_ctr + 1;
                    end
                end
            end
            DATA: begin
                if (i_tick) begin
                    if(smp_ctr == ((1 << SMP_SIZE_LOG) - 1))begin
                            smp_ctr_next = 0;
                            rs_next = {i_rx, rs_reg[7:1]};
                            if (n_bits == (DBIT - 1)) begin
                                state_next = STOP;
                            end
                            else begin
                                n_bits_next = n_bits + 1;
                            end
                    end
                    else begin
                        smp_ctr_next = smp_ctr + 1;
                    end
                end
            end
            STOP: begin
                if (i_tick) begin
                    if(smp_ctr == (SB_TICK-1)) begin
                        state_next = IDLE;
                        o_rx_busy = 1'b0;
                    end
                    else begin
                        smp_ctr_next = smp_ctr + 1;
                    end
                end
            end
            default: ;
        endcase
    end

    assign o_dout = rs_reg;

endmodule
/* verilator lint_off WIDTHEXPAND */
