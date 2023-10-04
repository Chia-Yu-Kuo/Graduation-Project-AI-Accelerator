`include "Define.v"

module ReLU (data_in,data_out);
    input signed [`psum_wid-1:0] data_in;
    output signed [`psum_wid-1:0] data_out;

    assign data_out = (data_in > $signed('d0)) ? data_in : 'd0;

endmodule