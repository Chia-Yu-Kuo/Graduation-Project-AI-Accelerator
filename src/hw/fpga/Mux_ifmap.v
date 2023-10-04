`include "Define.v"

module Mux_ifmap (img,ofmap1,ofmap2,data_out,sel);
    input [`img_wid-1:0] img; //0
    input [`psum_wid-1:0] ofmap1,ofmap2; //1  ,2 
    input [1:0] sel;
    output[`ifmap_wid-1:0] data_out;

    assign data_out = (sel=='d2) ? ofmap2[23:8] : 
                      (sel=='d1) ? ofmap1[23:8] : 
                      (sel=='d0) ? img[15:0]    : 'd0;

endmodule