`include "Define.v"

module Router_4_1 (
    data_in,
    data_out
);
    input [3:0] data_in;
    output data_out;

    assign data_out = |data_in;

endmodule
