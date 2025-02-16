module strobe(  input logic i_clk,
                output logic o_led);
    parameter int WIDTH = 12;
    reg [WIDTH - 1:0] cnt;

    always_ff @(posedge i_clk)
    cnt <= cnt + 1'b1;
    assign o_led = &cnt[WIDTH - 1:WIDTH - 3];
endmodule
