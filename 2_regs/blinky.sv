module blinky(  input   logic i_clk,
                output  logic o_led );

    parameter int WIDTH = 27;
    logic [WIDTH - 1:0] counter;
    initial counter = 0;

    always_ff @(posedge i_clk)
        counter <= counter + 1'b1;
    assign o_led = counter[WIDTH - 1];
endmodule
