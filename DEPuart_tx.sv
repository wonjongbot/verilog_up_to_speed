`default_nettype none;

module uart_tx #(
    parameter   int DBIT = 8,
                int SB_TICK = 16
                
    )
    (
    input logic i_clk,
    input logic i_rstn,
    input logic i_write,
    input logic [7:0] i_data,
    output logic o_busy,
    output logic o_uart_tx
    );

    // moore fsm for data transmission
    typedef enum logic [3:0] {
        IDLE = 4'h0,
        START = 4'h1,
        DBIT_0 = 4'h2,
        DBIT_1 = 4'h3,
        DBIT_2 = 4'h4,
        DBIT_3 = 4'h5,
        DBIT_4 = 4'h6,
        DBIT_5 = 4'h7,
        DBIT_6 = 4'h8,
        DBIT_7 = 4'h9,
        FINAL = 4'ha
    } state_t;

    parameter CLKS_PER_BAUD = 24'd1458;
    state_t state, nextstate;
    logic [8:0] lsreg; // left shift register for outgoing data
    logic [23:0] ctr;
    logic baud_stb;

    initial o_busy = 1'b0;
    initial state = IDLE;
    initial lsreg = 9'h1ff;

    always_ff @(posedge i_clk) begin
        if (~rstn)
            state <= IDLE;
        else if ((i_wr) && (!o_busy))
            state <= START;
        else
            state <= state_next;
    end

    // state transition logic (moore)
    always_comb begin
        case(state)
            IDLE: begin
                o_busy = 1'b0;
                nextstate = IDLE;
            end
            START: begin
                o_busy = 1'b1;
                nextstate = DBIT_0;
            end
            FINAL: begin
                o_busy = 1'b1;
                nextstate = IDLE;
            end
            default: begin
                o_busy = 1'b1;
                nextstate = state + 1;
            end
        endcase
    end

    // outgoing data logic
    always_ff @(posedge i_clk) begin
        if((i_wr) && (!o_busy))
            lsreg <= {i_data, 1'b0};
        else
            lsreg <= {1'b1, lsreg[8:1]};
    end

    assign o_uart_tx = lsreg[0];

    // clock divider
    initial ctr = 0;
    always @(posedge i_clk) begin
        if((i_wr)&&(!o_busy))
            ctr <= 
    end

endmodule
