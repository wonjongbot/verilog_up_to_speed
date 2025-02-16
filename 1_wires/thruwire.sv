`default_nettype none

module thruwire( input  logic [7:0] i_rx,
                 output logic [7:0] o_tx);
    assign o_tx = i_rx;
endmodule
