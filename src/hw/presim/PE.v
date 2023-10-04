`include "Define.v"

module PE (
    clk,
    rst,
    ifmap,
    ifmap_wen,
    reg_clear,
    weight,
    weight_wen,
    psum
);
    input clk, rst;
    input ifmap_wen, weight_wen, reg_clear;
    input signed [`ifmap_wid-1:0] ifmap;
    input signed [`weight_wid-1:0] weight;
    output signed [`psum_wid-1:0] psum;

    //FIFO reg
    reg signed [`ifmap_wid-1:0] ifmap_reg[0:2];
    reg signed [`weight_wid-1:0] weight_reg[0:2];

    integer i1;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            for (i1 = 0; i1 < 3; i1 = i1 + 1) begin
                ifmap_reg[i1]  <= 'd0;
                weight_reg[i1] <= 'd0;
            end
        end else begin
            if (reg_clear) begin
                for (i1 = 0; i1 < 3; i1 = i1 + 1) begin
                    ifmap_reg[i1]  <= 'd0;
                    weight_reg[i1] <= 'd0;
                end
            end else begin
                if (ifmap_wen) begin
                    ifmap_reg[2] <= ifmap;
                    ifmap_reg[1] <= ifmap_reg[2];
                    ifmap_reg[0] <= ifmap_reg[1];
                end
                if (weight_wen) begin
                    weight_reg[2] <= weight;
                    weight_reg[1] <= weight_reg[2];
                    weight_reg[0] <= weight_reg[1];
                end
            end
        end
    end

    assign psum = ifmap_reg[2]*weight_reg[2] + ifmap_reg[1]*weight_reg[1] + ifmap_reg[0]*weight_reg[0];

endmodule
