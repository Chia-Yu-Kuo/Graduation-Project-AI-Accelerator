`include "Define.v"

module Router_12_10 (
    data_in,
    data_out
);
    input [11:0] data_in;
    output [9:0] data_out;

    assign data_out = data_in[11:2];

endmodule
