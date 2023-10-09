`include "Define.v"

module Mux_psum_or_bias (
    psum,
    fc_reg,
    bias,
    data_out,
    sel
);
    //input clk,rst;
    input [`psum_wid-1:0] psum;  //0
    input [`psum_wid-1:0] fc_reg;  //1
    input [`bias_wid-1:0] bias;  //2
    input [1:0] sel;
    output [`psum_wid-1:0] data_out;

    assign data_out = (sel=='d2) ? {{8{bias[15]}},bias,8'b0} /*{{16{bias[15]}},bias}*/ :
                      (sel=='d1) ? fc_reg :
                      (sel=='d0) ? psum  : 'd0;

endmodule
