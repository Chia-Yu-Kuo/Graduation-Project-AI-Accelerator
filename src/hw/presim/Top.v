`include "Define.v"
`include "Accumulator.v"
`include "Controller.v"
`include "MaxPooling_or_Softmax.v"
`include "Mux_ifmap.v"
`include "Mux_of12.v"
`include "Mux_ofmap.v"
`include "Mux_psum_or_bias.v"
`include "PE_array.v"
`include "PE_vec.v"
`include "PE.v"
`include "ReLU.v"

module Top (
    clk,
    rst,
    start,
    done,
    predict,
    bram_img_addr,
    bram_img_data,
    bram_weight_addr,
    bram_weight_data,
    bram_bias_addr,
    bram_bias_data,
    bram_ofmap1_raddr,
    bram_ofmap1_rdata,
    bram_ofmap1_wen,
    bram_ofmap1_waddr,
    bram_ofmap1_wdata,
    bram_ofmap2_raddr,
    bram_ofmap2_rdata,
    bram_ofmap2_wen,
    bram_ofmap2_waddr,
    bram_ofmap2_wdata
);
    input clk, rst, start;
    output done;
    output [`PS_wid-1:0] predict;
    output [`bram_img_wid-1:0] bram_img_addr;
    input [`img_wid-1:0] bram_img_data;
    output [`bram_weight_wid-1:0] bram_weight_addr;
    input [`weight_wid-1:0] bram_weight_data;
    output [`bram_bias_wid-1:0] bram_bias_addr;
    input [`bias_wid-1:0] bram_bias_data;
    output bram_ofmap1_wen, bram_ofmap2_wen;
    output [`bram_ofmap1_wid-1:0] bram_ofmap1_raddr, bram_ofmap1_waddr;
    output [`bram_ofmap2_wid-1:0] bram_ofmap2_raddr, bram_ofmap2_waddr;
    input [`psum_wid-1:0] bram_ofmap1_rdata, bram_ofmap2_rdata;
    output [`psum_wid-1:0] bram_ofmap1_wdata, bram_ofmap2_wdata;

    //inter connected wire
    //ctrl
    wire [`cnt_wid-1:0] cnt;
    wire bram_img_ren, bram_weight_ren, bram_bias_ren, bram_ofmap1_ren, bram_ofmap2_ren;
    wire i_buff_wen, w_buff_wen, p_buff_wen, fc_reg_wen, i_buff_clear, w_buff_clear, fc_reg_clear;
    wire align_conv1, align_conv2;
    wire [ `ifmap_buff_wid-1:0] i_buff_w_addr;
    wire [`weight_buff_wid-1:0] w_buff_w_addr;
    wire [  `psum_buff_wid-1:0] p_buff_r_addr;
    wire ifmap_pe_wen, weight_pe_wen, reg_pe_clear;
    wire MPSF_clear;
    wire mux_of12_in_sel, mux_of12_sel;
    wire [1:0] mux_if_sel, mux_pb_sel, mux_of_sel;
    //pe_array
    wire [`psum_wid-1:0] p_buff_r_data;
    wire [`psum_wid-1:0] fc_reg_out;
    //accumulator
    wire signed [`psum_wid-1:0] accu_result;
    //relu
    wire signed [`psum_wid-1:0] relu_data_out;
    //MPSF
    wire [`psum_wid-1:0] mpsf_data_out;
    //MUX
    wire [`ifmap_wid-1:0] mux_if_data_out;
    wire [`psum_wid-1:0] mux_pb_data_out;
    wire [`psum_wid-1:0] mux_of_data_out;
    wire [`psum_wid-1:0] mux_of12_data_out;

    //fanout ofmap12 wdata
    assign bram_ofmap1_wdata = mux_of_data_out;
    assign bram_ofmap2_wdata = mux_of_data_out;


    //bram (off-chip DRAM build in testbench)

    //top module
    Controller controller (
        .clk(clk),
        .rst(rst),
        .start(start),
        .done(done),
        .cnt(cnt),
        .bram_img_ren(bram_img_ren),
        .bram_img_addr(bram_img_addr),
        .bram_weight_ren(bram_weight_ren),
        .bram_weight_addr(bram_weight_addr),
        .bram_bias_ren(bram_bias_ren),
        .bram_bias_addr(bram_bias_addr),
        .bram_ofmap1_ren(bram_ofmap1_ren),
        .bram_ofmap1_raddr(bram_ofmap1_raddr),
        .bram_ofmap1_wen(bram_ofmap1_wen),
        .bram_ofmap1_waddr(bram_ofmap1_waddr),
        .bram_ofmap2_ren(bram_ofmap2_ren),
        .bram_ofmap2_raddr(bram_ofmap2_raddr),
        .bram_ofmap2_wen(bram_ofmap2_wen),
        .bram_ofmap2_waddr(bram_ofmap2_waddr),
        .i_buff_wen(i_buff_wen),
        .i_buff_w_addr(i_buff_w_addr),
        .i_buff_clear(i_buff_clear),
        .w_buff_wen(w_buff_wen),
        .w_buff_w_addr(w_buff_w_addr),
        .w_buff_clear(w_buff_clear),
        .p_buff_wen(p_buff_wen),
        .p_buff_r_addr(p_buff_r_addr),
        .align_conv1(align_conv1),
        .align_conv2(align_conv2),
        .fc_reg_wen(fc_reg_wen),
        .fc_reg_clear(fc_reg_clear),
        .ifmap_pe_wen(ifmap_pe_wen),
        .weight_pe_wen(weight_pe_wen),
        .reg_pe_clear(reg_pe_clear),
        .MPSF_clear(MPSF_clear),
        .mux_if_sel(mux_if_sel),
        .mux_of_sel(mux_of_sel),
        .mux_pb_sel(mux_pb_sel),
        .mux_of12_sel(mux_of12_sel)
    );

    PE_array pe_array (
        .clk          (clk),
        .rst          (rst),
        .ifmap_pe_wen (ifmap_pe_wen),
        .weight_pe_wen(weight_pe_wen),     //27 can write each time
        .reg_pe_clear (reg_pe_clear),
        .i_buff_w_data(mux_if_data_out),
        .i_buff_w_addr(i_buff_w_addr),
        .i_buff_wen   (i_buff_wen),
        .i_buff_clear (i_buff_clear),      //one can write each time
        .w_buff_w_data(bram_weight_data),
        .w_buff_w_addr(w_buff_w_addr),
        .w_buff_wen   (w_buff_wen),
        .w_buff_clear (w_buff_clear),      //one can write each time
        .align_conv1  (align_conv1),
        .align_conv2  (align_conv2),
        .p_buff_r_addr(p_buff_r_addr),
        .p_buff_r_data(p_buff_r_data),
        .p_buff_wen   (p_buff_wen),
        .fc_reg_in    (accu_result),
        .fc_reg_out   (fc_reg_out),
        .fc_reg_wen   (fc_reg_wen),
        .fc_reg_clear (fc_reg_clear)
    );

    Accumulator accumulator (
        .pe_out(p_buff_r_data),
        .psum_or_bias(mux_pb_data_out),
        .result(accu_result)
    );

    ReLU relu (
        .data_in (accu_result),
        .data_out(relu_data_out)
    );

    MaxPooling_or_Softmax maxpooling_or_softmax (
        .clk(clk),
        .rst(rst),
        .cnt(cnt),
        .clear(MPSF_clear),
        .data_in(mux_of12_data_out),
        .data_out(mpsf_data_out),
        .idx(predict)
    );
    Mux_ifmap mux_ifmap (
        .img(bram_img_data),
        .ofmap1(bram_ofmap1_rdata),
        .ofmap2(bram_ofmap2_rdata),
        .data_out(mux_if_data_out),
        .sel(mux_if_sel)
    );
    Mux_psum_or_bias Mux_psum_or_bias (
        .psum(bram_ofmap2_rdata),
        .fc_reg(fc_reg_out),
        .bias(bram_bias_data),
        .data_out(mux_pb_data_out),
        .sel(mux_pb_sel)
    );
    Mux_ofmap Mux_ofmap (
        .relu_out(relu_data_out),
        .accu_out(accu_result),
        .pool_out(mpsf_data_out),
        .data_out(mux_of_data_out),
        .sel(mux_of_sel)
    );
    Mux_of12 mux_of12 (
        .ofmap1(bram_ofmap1_rdata),
        .ofmap2(bram_ofmap2_rdata),
        .data_out(mux_of12_data_out),
        .sel(mux_of12_sel)
    );






endmodule
