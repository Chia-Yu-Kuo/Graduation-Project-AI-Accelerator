`include "Define.v"

module PE_vec (
    clk,
    rst,  /*PE_keep_result,*/
    ifmap_wen,
    weight_wen,  //suppose every pe update synchronsize
    reg_clear,
    PE1_ifmap,
    PE1_weight,
    PE2_ifmap,
    PE2_weight,
    PE3_ifmap,
    PE3_weight,
    psum
);

    input clk, rst;
    input ifmap_wen, weight_wen, reg_clear;
    input signed [`ifmap_wid-1:0] PE1_ifmap, PE2_ifmap, PE3_ifmap;
    input signed [`weight_wid-1:0] PE1_weight, PE2_weight, PE3_weight;
    output signed [`psum_wid-1:0] psum;

    wire signed [`psum_wid-1:0] PE1_psum, PE2_psum, PE3_psum;
    PE pe1 (
        .clk(clk),
        .rst(rst),
        .ifmap(PE1_ifmap),
        .ifmap_wen(ifmap_wen),
        .weight(PE1_weight),
        .weight_wen(weight_wen),
        .reg_clear(reg_clear),
        .psum(PE1_psum)
    );
    PE pe2 (
        .clk(clk),
        .rst(rst),
        .ifmap(PE2_ifmap),
        .ifmap_wen(ifmap_wen),
        .weight(PE2_weight),
        .weight_wen(weight_wen),
        .reg_clear(reg_clear),
        .psum(PE2_psum)
    );
    PE pe3 (
        .clk(clk),
        .rst(rst),
        .ifmap(PE3_ifmap),
        .ifmap_wen(ifmap_wen),
        .weight(PE3_weight),
        .weight_wen(weight_wen),
        .reg_clear(reg_clear),
        .psum(PE3_psum)
    );
    /*
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            psum <= 'd0;
        end
        else begin
            if (PE_keep_result) begin
                psum <= PE1_psum + PE2_psum + PE3_psum
            end
        end
    end
    */
    assign psum = PE1_psum + PE2_psum + PE3_psum;


endmodule
