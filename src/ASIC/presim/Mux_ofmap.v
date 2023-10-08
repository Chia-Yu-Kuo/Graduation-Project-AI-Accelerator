`include "Define.v"

module Mux_ofmap (relu_out,accu_out,pool_out,data_out,sel);
    input [`psum_wid-1:0] relu_out; //0
    input [`psum_wid-1:0] accu_out; //1  
    input [`psum_wid-1:0] pool_out; //2
    input [1:0] sel;
    output[`psum_wid-1:0] data_out;

    assign data_out = (sel==2'd0) ? relu_out : 
                      (sel==2'd1) ? accu_out : 
                      (sel==2'd2) ? pool_out : 'd0;

endmodule