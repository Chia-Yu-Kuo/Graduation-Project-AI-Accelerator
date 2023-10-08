`timescale 1ns/10ps
`include "Controller.v"
`define CYCLE 10 

module tb_Controller;
reg clk,rst,start;
wire done;
wire [`cnt_wid-1:0] cnt;
wire bram_img_ren,bram_weight_ren,bram_bias_ren, bram_ofmap1_ren, bram_ofmap2_ren;
wire bram_ofmap1_wen, bram_ofmap2_wen;
wire [`bram_img_wid-1:0] bram_img_addr;
wire [`bram_weight_wid-1:0] bram_weight_addr;
wire [`bram_bias_wid-1:0] bram_bias_addr;
wire [`bram_ofmap1_wid-1:0] bram_ofmap1_raddr,bram_ofmap1_waddr;
wire [`bram_ofmap2_wid-1:0] bram_ofmap2_raddr,bram_ofmap2_waddr;
wire i_buff_wen,w_buff_wen,p_buff_wen,fc_reg_wen,i_buff_clear,w_buff_clear,fc_reg_clear;
wire align_conv1,align_conv2;
wire [`ifmap_buff_wid-1:0] i_buff_w_addr;
wire [`weight_buff_wid-1:0] w_buff_w_addr;
wire [`psum_buff_wid-1:0] p_buff_r_addr;
wire ifmap_pe_wen,weight_pe_wen;
wire MPSF_clear;
wire mux_of12_in_sel,mux_of12_out_sel;
wire [1:0] mux_if_sel,mux_pb_sel,mux_of_sel;

wire [4:0] st;
assign st=controller.st;

Controller controller
(
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
    .MPSF_clear(MPSF_clear),
    .mux_if_sel(mux_if_sel),
    .mux_of_sel(mux_of_sel),
    .mux_pb_sel(mux_pb_sel),
    .mux_of12_in_sel(mux_of12_in_sel),
    .mux_of12_out_sel(mux_of12_out_sel)
);

always #(`CYCLE/2) clk=~clk;

initial begin
        clk<=1'b1;
    #(`CYCLE*1) rst = 'd1;
    #(`CYCLE*1) rst = 'd0;
    #(`CYCLE*1) start = 'd1;
    #(`CYCLE*1) start = 'd0;
    wait(done);
    #(`CYCLE*3);
    $finish;
end

initial begin
    $dumpfile("tb_Controller.vcd");
    $dumpvars(0, tb_Controller);
end

always @(*) begin
    $display($time, "st:  %d",st);
end

endmodule