module dimmer(
    input logic i_clk,
    output logic o_led
);
    parameter int WIDTH = 12;
    logic [WIDTH - 1:0] counter;

    always_ff @(posedge i_clk)
        counter <= counter + 1'b1;
    assign o_led = (counter[3:0] < counter[WIDTH - 1: WIDTH - 4]);
endmodule

