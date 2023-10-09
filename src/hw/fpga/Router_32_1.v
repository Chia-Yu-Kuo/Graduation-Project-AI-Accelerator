`include "Define.v"

module Router_32_1 (
    data_in,
    data_out_rst,
    data_out_start
);
    input [`PS_wid-1:0] data_in;
    output data_out_rst;
    output data_out_start;

    assign data_out_rst   = data_in[0];
    assign data_out_start = data_in[1];
endmodule
