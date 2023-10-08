`include "Define.v"

module Mux_of12 (ofmap1,ofmap2,data_out,sel);

    input [`psum_wid-1:0] ofmap1; //0
    input [`psum_wid-1:0] ofmap2; //1
    input sel;
    output [`psum_wid-1:0] data_out;
    
    assign data_out = (sel) ? ofmap2 : ofmap1;

endmodule