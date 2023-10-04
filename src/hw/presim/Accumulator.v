`include "Define.v"

module Accumulator (
    pe_out,
    psum_or_bias,
    result
);
    input [`psum_wid-1:0] pe_out, psum_or_bias;
    output [`psum_wid-1:0] result;

    assign result = $signed(pe_out) + $signed(psum_or_bias);

endmodule
