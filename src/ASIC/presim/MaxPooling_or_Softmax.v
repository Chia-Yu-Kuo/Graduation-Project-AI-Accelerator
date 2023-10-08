`include "Define.v"

module MaxPooling_or_Softmax (clk,rst,cnt,clear,data_in,data_out,idx);
    input clk,rst,clear;
    input [`cnt_wid-1:0] cnt;
    input signed [`psum_wid-1:0] data_in;
    output [`psum_wid-1:0] data_out;
    output reg [`PS_wid-1:0] idx;

    reg signed [`psum_wid-1:0] max;

    assign data_out = max;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            max <= 'd0;
            idx <= 'd0;
        end
        else begin
            if (clear) begin
                max <= 'd0;
                idx <= 'd0;
            end
            else begin
                if (data_in > max) begin
                    max <= data_in;
                    idx <= {24'b0,cnt};
                end
            end
        end
    end

    
endmodule