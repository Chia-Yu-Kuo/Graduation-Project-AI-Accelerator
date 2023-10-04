`include "Define.v"

module Controller (
    clk,
    rst,
    start,
    done,
    cnt,
    //bram
    bram_img_ren,
    bram_img_addr,
    bram_weight_ren,
    bram_weight_addr,
    bram_bias_ren,
    bram_bias_addr,
    bram_ofmap1_ren,
    bram_ofmap1_raddr,
    bram_ofmap1_wen,
    bram_ofmap1_waddr,
    bram_ofmap2_ren,
    bram_ofmap2_raddr,
    bram_ofmap2_wen,
    bram_ofmap2_waddr,
    //buffer
    i_buff_wen,
    i_buff_w_addr,
    i_buff_clear,
    w_buff_wen,
    w_buff_w_addr,
    w_buff_clear,
    p_buff_wen,
    p_buff_r_addr,
    align_conv1,
    align_conv2,
    fc_reg_wen,
    fc_reg_clear,
    //pe (use fanout wen to 3*27 pe(Synchronize update))
    ifmap_pe_wen,
    weight_pe_wen,
    reg_pe_clear,
    /*
                  PE_Vec1_1_ifmap_wen,PE_Vec1_1_weight_wen,PE_Vec1_2_ifmap_wen,PE_Vec1_2_weight_wen,PE_Vec1_3_ifmap_wen,PE_Vec1_3_weight_wen,
                  PE_Vec2_1_ifmap_wen,PE_Vec2_1_weight_wen,PE_Vec2_2_ifmap_wen,PE_Vec2_2_weight_wen,PE_Vec2_3_ifmap_wen,PE_Vec2_3_weight_wen,
                  PE_Vec3_1_ifmap_wen,PE_Vec3_1_weight_wen,PE_Vec3_2_ifmap_wen,PE_Vec3_2_weight_wen,PE_Vec3_3_ifmap_wen,PE_Vec3_3_weight_wen,
                  PE_Vec4_1_ifmap_wen,PE_Vec4_1_weight_wen,PE_Vec4_2_ifmap_wen,PE_Vec4_2_weight_wen,PE_Vec4_3_ifmap_wen,PE_Vec4_3_weight_wen,
                  PE_Vec5_1_ifmap_wen,PE_Vec5_1_weight_wen,PE_Vec5_2_ifmap_wen,PE_Vec5_2_weight_wen,PE_Vec5_3_ifmap_wen,PE_Vec5_3_weight_wen,
                  PE_Vec6_1_ifmap_wen,PE_Vec6_1_weight_wen,PE_Vec6_2_ifmap_wen,PE_Vec6_2_weight_wen,PE_Vec6_3_ifmap_wen,PE_Vec6_3_weight_wen,
                  PE_Vec7_1_ifmap_wen,PE_Vec7_1_weight_wen,PE_Vec7_2_ifmap_wen,PE_Vec7_2_weight_wen,PE_Vec7_3_ifmap_wen,PE_Vec7_3_weight_wen,
                  PE_Vec8_1_ifmap_wen,PE_Vec8_1_weight_wen,PE_Vec8_2_ifmap_wen,PE_Vec8_2_weight_wen,PE_Vec8_3_ifmap_wen,PE_Vec8_3_weight_wen,
                  PE_Vec9_1_ifmap_wen,PE_Vec9_1_weight_wen,PE_Vec9_2_ifmap_wen,PE_Vec9_2_weight_wen,PE_Vec9_3_ifmap_wen,PE_Vec9_3_weight_wen,
                  PE_Vec10_1_ifmap_wen,PE_Vec10_1_weight_wen,PE_Vec10_2_ifmap_wen,PE_Vec10_2_weight_wen,PE_Vec10_3_ifmap_wen,PE_Vec10_3_weight_wen,
                  PE_Vec11_1_ifmap_wen,PE_Vec11_1_weight_wen,PE_Vec11_2_ifmap_wen,PE_Vec11_2_weight_wen,PE_Vec11_3_ifmap_wen,PE_Vec11_3_weight_wen,
                  PE_Vec12_1_ifmap_wen,PE_Vec12_1_weight_wen,PE_Vec12_2_ifmap_wen,PE_Vec12_2_weight_wen,PE_Vec12_3_ifmap_wen,PE_Vec12_3_weight_wen,
                  PE_Vec13_1_ifmap_wen,PE_Vec13_1_weight_wen,PE_Vec13_2_ifmap_wen,PE_Vec13_2_weight_wen,PE_Vec13_3_ifmap_wen,PE_Vec13_3_weight_wen,
                  PE_Vec14_1_ifmap_wen,PE_Vec14_1_weight_wen,PE_Vec14_2_ifmap_wen,PE_Vec14_2_weight_wen,PE_Vec14_3_ifmap_wen,PE_Vec14_3_weight_wen,
                  PE_Vec15_1_ifmap_wen,PE_Vec15_1_weight_wen,PE_Vec15_2_ifmap_wen,PE_Vec15_2_weight_wen,PE_Vec15_3_ifmap_wen,PE_Vec15_3_weight_wen,
                  PE_Vec16_1_ifmap_wen,PE_Vec16_1_weight_wen,PE_Vec16_2_ifmap_wen,PE_Vec16_2_weight_wen,PE_Vec16_3_ifmap_wen,PE_Vec16_3_weight_wen,
                  PE_Vec17_1_ifmap_wen,PE_Vec17_1_weight_wen,PE_Vec17_2_ifmap_wen,PE_Vec17_2_weight_wen,PE_Vec17_3_ifmap_wen,PE_Vec17_3_weight_wen,
                  PE_Vec18_1_ifmap_wen,PE_Vec18_1_weight_wen,PE_Vec18_2_ifmap_wen,PE_Vec18_2_weight_wen,PE_Vec18_3_ifmap_wen,PE_Vec18_3_weight_wen,
                  PE_Vec19_1_ifmap_wen,PE_Vec19_1_weight_wen,PE_Vec19_2_ifmap_wen,PE_Vec19_2_weight_wen,PE_Vec19_3_ifmap_wen,PE_Vec19_3_weight_wen,
                  PE_Vec20_1_ifmap_wen,PE_Vec20_1_weight_wen,PE_Vec20_2_ifmap_wen,PE_Vec20_2_weight_wen,PE_Vec20_3_ifmap_wen,PE_Vec20_3_weight_wen,
                  PE_Vec21_1_ifmap_wen,PE_Vec21_1_weight_wen,PE_Vec21_2_ifmap_wen,PE_Vec21_2_weight_wen,PE_Vec21_3_ifmap_wen,PE_Vec21_3_weight_wen,
                  PE_Vec22_1_ifmap_wen,PE_Vec22_1_weight_wen,PE_Vec22_2_ifmap_wen,PE_Vec22_2_weight_wen,PE_Vec22_3_ifmap_wen,PE_Vec22_3_weight_wen,
                  PE_Vec23_1_ifmap_wen,PE_Vec23_1_weight_wen,PE_Vec23_2_ifmap_wen,PE_Vec23_2_weight_wen,PE_Vec23_3_ifmap_wen,PE_Vec23_3_weight_wen,
                  PE_Vec24_1_ifmap_wen,PE_Vec24_1_weight_wen,PE_Vec24_2_ifmap_wen,PE_Vec24_2_weight_wen,PE_Vec24_3_ifmap_wen,PE_Vec24_3_weight_wen,
                  PE_Vec25_1_ifmap_wen,PE_Vec25_1_weight_wen,PE_Vec25_2_ifmap_wen,PE_Vec25_2_weight_wen,PE_Vec25_3_ifmap_wen,PE_Vec25_3_weight_wen,
                  PE_Vec26_1_ifmap_wen,PE_Vec26_1_weight_wen,PE_Vec26_2_ifmap_wen,PE_Vec26_2_weight_wen,PE_Vec26_3_ifmap_wen,PE_Vec26_3_weight_wen,
                  PE_Vec27_1_ifmap_wen,PE_Vec27_1_weight_wen,PE_Vec27_2_ifmap_wen,PE_Vec27_2_weight_wen,PE_Vec27_3_ifmap_wen,PE_Vec27_3_weight_wen,
                  PE_Vec28_1_ifmap_wen,PE_Vec28_1_weight_wen,PE_Vec28_2_ifmap_wen,PE_Vec28_2_weight_wen,PE_Vec28_3_ifmap_wen,PE_Vec28_3_weight_wen,
    */
    //other ctrl signal
    MPSF_clear,
    mux_if_sel,
    mux_of_sel,
    mux_pb_sel,
    mux_of12_sel
);
    /*BRAM
    1.img
        write by bram ctrl from ps
        read by controller (ren=1)

    2.weight
        write by .coe
        read by controller

    3.bias
        write by .coe
        read by controller

    4.ofmap
        write by controller
        read by controller
    */
    input clk, rst, start;
    output done;
    output [`cnt_wid-1:0] cnt;

    output bram_img_ren, bram_weight_ren, bram_bias_ren, bram_ofmap1_ren, bram_ofmap2_ren;
    output reg bram_ofmap1_wen, bram_ofmap2_wen;
    output reg [`bram_img_wid-1:0] bram_img_addr;
    output reg [`bram_weight_wid-1:0] bram_weight_addr;
    output reg [`bram_bias_wid-1:0] bram_bias_addr;
    output reg [`bram_ofmap1_wid-1:0] bram_ofmap1_raddr, bram_ofmap1_waddr;
    output reg [`bram_ofmap2_wid-1:0] bram_ofmap2_raddr, bram_ofmap2_waddr;
    output reg i_buff_wen,w_buff_wen,p_buff_wen,fc_reg_wen,i_buff_clear,w_buff_clear,fc_reg_clear;
    output align_conv1, align_conv2;
    output [`ifmap_buff_wid-1:0] i_buff_w_addr;
    output [`weight_buff_wid-1:0] w_buff_w_addr;
    output [`psum_buff_wid-1:0] p_buff_r_addr;
    output reg ifmap_pe_wen, weight_pe_wen;
    output reg_pe_clear;
    /*
    output reg PE_Vec1_1_ifmap_wen,PE_Vec1_1_weight_wen,PE_Vec1_2_ifmap_wen,PE_Vec1_2_weight_wen,PE_Vec1_3_ifmap_wen,PE_Vec1_3_weight_wen,
               PE_Vec2_1_ifmap_wen,PE_Vec2_1_weight_wen,PE_Vec2_2_ifmap_wen,PE_Vec2_2_weight_wen,PE_Vec2_3_ifmap_wen,PE_Vec2_3_weight_wen,
               PE_Vec3_1_ifmap_wen,PE_Vec3_1_weight_wen,PE_Vec3_2_ifmap_wen,PE_Vec3_2_weight_wen,PE_Vec3_3_ifmap_wen,PE_Vec3_3_weight_wen,
               PE_Vec4_1_ifmap_wen,PE_Vec4_1_weight_wen,PE_Vec4_2_ifmap_wen,PE_Vec4_2_weight_wen,PE_Vec4_3_ifmap_wen,PE_Vec4_3_weight_wen,
               PE_Vec5_1_ifmap_wen,PE_Vec5_1_weight_wen,PE_Vec5_2_ifmap_wen,PE_Vec5_2_weight_wen,PE_Vec5_3_ifmap_wen,PE_Vec5_3_weight_wen,
               PE_Vec6_1_ifmap_wen,PE_Vec6_1_weight_wen,PE_Vec6_2_ifmap_wen,PE_Vec6_2_weight_wen,PE_Vec6_3_ifmap_wen,PE_Vec6_3_weight_wen,
               PE_Vec7_1_ifmap_wen,PE_Vec7_1_weight_wen,PE_Vec7_2_ifmap_wen,PE_Vec7_2_weight_wen,PE_Vec7_3_ifmap_wen,PE_Vec7_3_weight_wen,
               PE_Vec8_1_ifmap_wen,PE_Vec8_1_weight_wen,PE_Vec8_2_ifmap_wen,PE_Vec8_2_weight_wen,PE_Vec8_3_ifmap_wen,PE_Vec8_3_weight_wen,
               PE_Vec9_1_ifmap_wen,PE_Vec9_1_weight_wen,PE_Vec9_2_ifmap_wen,PE_Vec9_2_weight_wen,PE_Vec9_3_ifmap_wen,PE_Vec9_3_weight_wen,
               PE_Vec10_1_ifmap_wen,PE_Vec10_1_weight_wen,PE_Vec10_2_ifmap_wen,PE_Vec10_2_weight_wen,PE_Vec10_3_ifmap_wen,PE_Vec10_3_weight_wen,
               PE_Vec11_1_ifmap_wen,PE_Vec11_1_weight_wen,PE_Vec11_2_ifmap_wen,PE_Vec11_2_weight_wen,PE_Vec11_3_ifmap_wen,PE_Vec11_3_weight_wen,
               PE_Vec12_1_ifmap_wen,PE_Vec12_1_weight_wen,PE_Vec12_2_ifmap_wen,PE_Vec12_2_weight_wen,PE_Vec12_3_ifmap_wen,PE_Vec12_3_weight_wen,
               PE_Vec13_1_ifmap_wen,PE_Vec13_1_weight_wen,PE_Vec13_2_ifmap_wen,PE_Vec13_2_weight_wen,PE_Vec13_3_ifmap_wen,PE_Vec13_3_weight_wen,
               PE_Vec14_1_ifmap_wen,PE_Vec14_1_weight_wen,PE_Vec14_2_ifmap_wen,PE_Vec14_2_weight_wen,PE_Vec14_3_ifmap_wen,PE_Vec14_3_weight_wen,
               PE_Vec15_1_ifmap_wen,PE_Vec15_1_weight_wen,PE_Vec15_2_ifmap_wen,PE_Vec15_2_weight_wen,PE_Vec15_3_ifmap_wen,PE_Vec15_3_weight_wen,
               PE_Vec16_1_ifmap_wen,PE_Vec16_1_weight_wen,PE_Vec16_2_ifmap_wen,PE_Vec16_2_weight_wen,PE_Vec16_3_ifmap_wen,PE_Vec16_3_weight_wen,
               PE_Vec17_1_ifmap_wen,PE_Vec17_1_weight_wen,PE_Vec17_2_ifmap_wen,PE_Vec17_2_weight_wen,PE_Vec17_3_ifmap_wen,PE_Vec17_3_weight_wen,
               PE_Vec18_1_ifmap_wen,PE_Vec18_1_weight_wen,PE_Vec18_2_ifmap_wen,PE_Vec18_2_weight_wen,PE_Vec18_3_ifmap_wen,PE_Vec18_3_weight_wen,
               PE_Vec19_1_ifmap_wen,PE_Vec19_1_weight_wen,PE_Vec19_2_ifmap_wen,PE_Vec19_2_weight_wen,PE_Vec19_3_ifmap_wen,PE_Vec19_3_weight_wen,
               PE_Vec20_1_ifmap_wen,PE_Vec20_1_weight_wen,PE_Vec20_2_ifmap_wen,PE_Vec20_2_weight_wen,PE_Vec20_3_ifmap_wen,PE_Vec20_3_weight_wen,
               PE_Vec21_1_ifmap_wen,PE_Vec21_1_weight_wen,PE_Vec21_2_ifmap_wen,PE_Vec21_2_weight_wen,PE_Vec21_3_ifmap_wen,PE_Vec21_3_weight_wen,
               PE_Vec22_1_ifmap_wen,PE_Vec22_1_weight_wen,PE_Vec22_2_ifmap_wen,PE_Vec22_2_weight_wen,PE_Vec22_3_ifmap_wen,PE_Vec22_3_weight_wen,
               PE_Vec23_1_ifmap_wen,PE_Vec23_1_weight_wen,PE_Vec23_2_ifmap_wen,PE_Vec23_2_weight_wen,PE_Vec23_3_ifmap_wen,PE_Vec23_3_weight_wen,
               PE_Vec24_1_ifmap_wen,PE_Vec24_1_weight_wen,PE_Vec24_2_ifmap_wen,PE_Vec24_2_weight_wen,PE_Vec24_3_ifmap_wen,PE_Vec24_3_weight_wen,
               PE_Vec25_1_ifmap_wen,PE_Vec25_1_weight_wen,PE_Vec25_2_ifmap_wen,PE_Vec25_2_weight_wen,PE_Vec25_3_ifmap_wen,PE_Vec25_3_weight_wen,
               PE_Vec26_1_ifmap_wen,PE_Vec26_1_weight_wen,PE_Vec26_2_ifmap_wen,PE_Vec26_2_weight_wen,PE_Vec26_3_ifmap_wen,PE_Vec26_3_weight_wen,
               PE_Vec27_1_ifmap_wen,PE_Vec27_1_weight_wen,PE_Vec27_2_ifmap_wen,PE_Vec27_2_weight_wen,PE_Vec27_3_ifmap_wen,PE_Vec27_3_weight_wen,
               PE_Vec28_1_ifmap_wen,PE_Vec28_1_weight_wen,PE_Vec28_2_ifmap_wen,PE_Vec28_2_weight_wen,PE_Vec28_3_ifmap_wen,PE_Vec28_3_weight_wen;
    */
    output MPSF_clear;
    output reg mux_of12_sel;
    output reg [1:0] mux_if_sel, mux_pb_sel, mux_of_sel;
    /*
//layer
    parameter  CONV1 = 3'd0;
    parameter  MP1   = 3'd1;
    parameter  CONV2 = 3'd2;
    parameter  MP2   = 3'd3;
    parameter  FC1   = 3'd4;
    parameter  FC2   = 3'd5;
    parameter  SF    = 3'd6;
    parameter  DONE  = 3'd7;
*/
    //state
    //wait start
    parameter WAIT_START = 5'd0;
    //CONV1
    parameter LD_3COL2BUFF_C1 = 5'd1;
    parameter MAC_C1 = 5'd2;
    parameter PP_STR_LD_C1 = 5'd3;
    parameter ONE_OFMAP_DONE_C1 = 5'd4;
    parameter CONV1_DONE = 5'd5;
    //MP1
    parameter READ4_MP1 = 5'd6;
    parameter STR_MP1 = 5'd7;
    parameter MP1_DONE = 5'd8;
    //CONV28
    parameter LD_3COL2BUFF_C2 = 5'd9;
    parameter MAC_C2 = 5'd10;
    parameter PP_STR_LD_C2 = 5'd11;
    parameter ONE_OFMAP_DONE_C2 = 5'd12;
    parameter CONV2_DONE = 5'd13;
    //MP2
    parameter READ4_MP2 = 5'd14;
    parameter STR_MP2 = 5'd15;
    parameter MP2_DONE = 5'd16;
    //FC1
    parameter LD_3COL2BUFF_F1 = 5'd17;
    parameter MAC1_F1 = 5'd18;
    parameter LD_3COL2BUFF_ACCU28_1 = 5'd19;
    parameter MAC2_F1 = 5'd20;
    parameter LD_3COL2BUFF_ACCU28_2 = 5'd21;
    parameter MAC3_F1 = 5'd22;
    parameter ACCU28_STR_F1 = 5'd23;
    parameter FC1_DONE = 5'd24;
    //FC2
    parameter LD_3COL2BUFF_F2 = 5'd25;
    parameter MAC_F2 = 5'd26;
    parameter ACCU28_STR_F2 = 5'd27;
    parameter FC2_DONE = 5'd28;
    //SF
    parameter SF = 5'd29;
    //DONE
    parameter DONE = 5'd30;


    //reg [2:0] ly,nly;
    reg [4:0] st, nst;
    reg [6:0] iter, niter;  //for ofmap num     = as depth in FC
    reg [9:0] channel_cnt, channel_ncnt;  //for ifmap channel     = as depth in FC
    reg [7:0] stride_cnt, stride_ncnt;  //related to # ofmap
    reg [`cnt_wid-1:0] cnt;
    //ifmap & (ofmap = accumulate) addr index (NOT center) (for conv only)
    reg [4:0] row_i, col_i;
    wire [9:0] depth_i;
    reg [4:0] row_o, col_o;
    wire [6:0] depth_o;
    reg  [6:0] buff_addr;

    assign depth_i = channel_cnt;
    assign depth_o = iter;

    assign bram_img_ren = 1'd1;
    assign bram_weight_ren = 1'd1;
    assign bram_bias_ren = 1'd1;
    assign bram_ofmap1_ren = 1'd1;
    assign bram_ofmap2_ren = 1'd1;

    //state,cnt
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            st <= WAIT_START;
            iter <= 7'd0;
            channel_cnt <= 'd0;
            stride_cnt <= 5'd0;
            cnt <= 8'd0;
        end else begin
            st <= nst;
            iter <= niter;
            channel_cnt <= channel_ncnt;
            stride_cnt <= stride_ncnt;
            cnt <= (st != nst) ? 8'd0 : cnt + 8'd1;
        end
    end
    //nst
    always @(*) begin
        case (st)
            WAIT_START: begin
                if (start) nst = LD_3COL2BUFF_C1;
                else nst = WAIT_START;
            end
            LD_3COL2BUFF_C1: begin
                if (cnt == 8'd95) nst = MAC_C1;  //30+1+1+30+1+1+30+1+1
                else nst = LD_3COL2BUFF_C1;
            end
            MAC_C1: begin
                nst = PP_STR_LD_C1;
            end
            PP_STR_LD_C1: begin
                if (stride_cnt == `C1_w - 'd1 && cnt == `C1_h - 'd1)
                    nst = ONE_OFMAP_DONE_C1;  //1img done
                else if (cnt == `img_h + 'd1)
                    nst = MAC_C1;  //1cycle from buff to reg    //1ofmap_col done
                else nst = PP_STR_LD_C1;
            end
            ONE_OFMAP_DONE_C1: begin
                if (iter == `C1_c - 'd1) nst = CONV1_DONE;  //8img done
                else nst = LD_3COL2BUFF_C1;
            end
            CONV1_DONE: begin
                nst = READ4_MP1;
            end
            READ4_MP1: begin
                if (cnt == 'd3) nst = STR_MP1;
                else nst = READ4_MP1;
            end
            STR_MP1: begin
                if (iter == `C1_c - 'd1 && stride_cnt == `S2_s - 1) nst = MP1_DONE;
                else nst = READ4_MP1;
            end
            MP1_DONE: begin  //need str last MP
                nst = LD_3COL2BUFF_C2;
            end
            LD_3COL2BUFF_C2: begin
                if (cnt == 8'd89) nst = MAC_C2;  // (14+14+1+1)*3
                else nst = LD_3COL2BUFF_C2;
            end
            MAC_C2: begin
                nst = PP_STR_LD_C2;
            end
            PP_STR_LD_C2: begin
                if(channel_cnt==`C1_c-'d1 && stride_cnt==`C3_w-'d1 && cnt==(`C3_h*2)-'d1)
                    nst = ONE_OFMAP_DONE_C2;  //c:0,2,4,6       //1ofmap done
                else if (stride_cnt == `C3_w - 'd1 && cnt == (`C3_h * 2) - 'd1)
                    nst = LD_3COL2BUFF_C2;  //two channel done
                else if (cnt == (`S2_h * 2 + 'd1)) nst = MAC_C2;
                else nst = PP_STR_LD_C2;
            end
            ONE_OFMAP_DONE_C2: begin
                if (iter == `C3_c - 'd1  /*niter==`C3_c*/) nst = CONV2_DONE;
                else nst = LD_3COL2BUFF_C2;
            end
            CONV2_DONE: begin
                nst = READ4_MP2;
            end
            READ4_MP2: begin
                if (cnt == 'd3) nst = STR_MP2;
                else nst = READ4_MP2;
            end
            STR_MP2: begin
                if (iter == `C3_c - 'd1 && stride_cnt == `S4_s - 1) nst = MP2_DONE;
                else nst = READ4_MP2;
            end
            MP2_DONE: begin  //need str last pooling
                nst = LD_3COL2BUFF_F1;
            end
            LD_3COL2BUFF_F1: begin
                if (cnt == 8'd254) nst = MAC1_F1;  //(3*28+1)*3
                else nst = LD_3COL2BUFF_F1;
            end
            MAC1_F1: begin
                nst = LD_3COL2BUFF_ACCU28_1;
            end
            LD_3COL2BUFF_ACCU28_1: begin
                if (cnt == 8'd254) nst = MAC2_F1;  //9*28+3
                else nst = LD_3COL2BUFF_ACCU28_1;
            end
            MAC2_F1: begin
                nst = LD_3COL2BUFF_ACCU28_2;
            end
            LD_3COL2BUFF_ACCU28_2: begin
                if (cnt == 8'd72) nst = MAC3_F1;  //72+1   (<3*28)
                else nst = LD_3COL2BUFF_ACCU28_2;
            end
            MAC3_F1: begin
                nst = ACCU28_STR_F1;
            end
            ACCU28_STR_F1: begin
                if (cnt == 8'd27 && iter == 7'd127) nst = FC1_DONE;
                else if (cnt == 8'd27) nst = LD_3COL2BUFF_F1;
                else nst = ACCU28_STR_F1;
            end
            FC1_DONE: begin
                nst = LD_3COL2BUFF_F2;
            end
            LD_3COL2BUFF_F2: begin
                if (cnt == 8'd129) nst = MAC_F2;  //(3*28+1)+(44+1)
                else nst = LD_3COL2BUFF_F2;
            end
            MAC_F2: begin
                nst = ACCU28_STR_F2;
            end
            ACCU28_STR_F2: begin
                if (cnt == 8'd27 && iter == 7'd9) nst = FC2_DONE;
                else if (cnt == 8'd27) nst = LD_3COL2BUFF_F2;
                else nst = ACCU28_STR_F2;
            end
            FC2_DONE: begin
                nst = SF;
            end
            SF: begin
                if (cnt == 8'd9) nst = DONE;
                else nst = SF;
            end
            DONE: begin
                nst = WAIT_START;
            end
            default: nst = WAIT_START;
        endcase
    end
    //niter
    always @(*) begin
        if ((st==ONE_OFMAP_DONE_C1||st==ONE_OFMAP_DONE_C2)||
            ((st==STR_MP1&&stride_cnt==`S2_s-1)||(st==STR_MP2&&stride_cnt==`S4_s-1))||
            (st==ACCU28_STR_F1&&st!=nst)||(st==ACCU28_STR_F2&&st!=nst))
            niter = iter + 'd1;
        else if((st==CONV1_DONE)||(st==MP1_DONE)||(st==CONV2_DONE)||(st==MP2_DONE)||
                (st==FC1_DONE)||(st==FC2_DONE))
            niter = 'd0;
        else niter = iter;
    end
    //channel_ncnt
    always @(*) begin
        //be a channel idx in "CONV2" 
        if((st==PP_STR_LD_C2&&(nst==LD_3COL2BUFF_C2||cnt==`S2_h-'d1))||(st==LD_3COL2BUFF_C2&&(cnt=='d13 || cnt=='d43 ||cnt=='d73 )))
            channel_ncnt = channel_cnt + 'd1;  //cnt=(14+1+1)*3
        else if(st==MAC_C2||(st==LD_3COL2BUFF_C2&&(cnt=='d27 || cnt=='d57 /*||cnt=='d87*/ )))
            channel_ncnt = channel_cnt - 'd1;
        else if (st == ONE_OFMAP_DONE_C2) channel_ncnt = 'd0;
        ////be a "depth" of ifmap in  FC    (same as weight)
        else if((st==LD_3COL2BUFF_F1||st==LD_3COL2BUFF_ACCU28_1)&&((cnt!='d84 && cnt!='d169 && cnt!='d254)))
            channel_ncnt = (channel_cnt == 'd15) ? 'd0 : channel_cnt + 'd1;  //fc1   
        else if (st == LD_3COL2BUFF_ACCU28_2 && cnt < 'd72)
            channel_ncnt = (channel_cnt == 'd15) ? 'd0 : channel_cnt + 'd1;  //fc1
        else if (st == LD_3COL2BUFF_F2 && (cnt < 'd84 || (cnt > 'd84 && cnt < 'd129)))
            channel_ncnt = channel_cnt + 'd1;  //fc2
        else if ((st == ACCU28_STR_F1 && st != nst) || (st == ACCU28_STR_F2 && st != nst))
            channel_ncnt = 'd0;  //initialize depth each iter
        else if (st == SF) channel_ncnt = channel_cnt + 'd1;
        else channel_ncnt = channel_cnt;
    end
    //stride_ncnt
    always @(*) begin
        if ((st == PP_STR_LD_C1 && nst == MAC_C1) || (st == PP_STR_LD_C2 && nst == MAC_C2))
            stride_ncnt = stride_cnt + 'd1;
        else if (st == STR_MP1) stride_ncnt = (stride_cnt == `S2_s - 1) ? 'd0 : stride_cnt + 'd1;
        else if (st == STR_MP2) stride_ncnt = (stride_cnt == `S4_s - 1) ? 'd0 : stride_cnt + 'd1;
        else if((st==ONE_OFMAP_DONE_C1)||(st==PP_STR_LD_C2&&(nst==LD_3COL2BUFF_C2||nst==ONE_OFMAP_DONE_C2)))
            stride_ncnt = 'd0;
        else stride_ncnt = stride_cnt;
    end


    //bram
    //wen  
    always @(*) begin
        bram_ofmap1_wen = 1'b0;
        bram_ofmap2_wen = 1'b0;
        case (st)
            PP_STR_LD_C1: begin
                if (cnt < `C1_h) bram_ofmap1_wen = 1'b1;
            end
            STR_MP1: begin
                bram_ofmap1_wen = 1'b1;
            end
            PP_STR_LD_C2: begin
                if (cnt < (`C3_h * 2)) bram_ofmap2_wen = 1'b1;
            end
            STR_MP2: begin
                bram_ofmap2_wen = 1'b1;
            end
            ACCU28_STR_F1: begin
                if (cnt == 8'd27) bram_ofmap2_wen = 1'b1;
            end
            ACCU28_STR_F2: begin
                if (cnt == 8'd27) bram_ofmap2_wen = 1'b1;
            end
        endcase
    end
    //addr
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            bram_weight_addr <= 'd0;
            bram_bias_addr   <= 'd0;
        end else begin
            case (st)
                //weight:
                LD_3COL2BUFF_C1: begin
                    if (cnt < 'd2 || (cnt > 'd31 && cnt < 'd34) || (cnt > 'd63 && cnt < 'd66))
                        bram_weight_addr <= bram_weight_addr + 'd3;  //row+1   //9*8=72 + 9*8*16
                    else if (cnt == 'd2 || cnt == 'd34)
                        bram_weight_addr <= bram_weight_addr - 'd5;  //col+1
                    else if (cnt == 'd95) bram_weight_addr <= bram_weight_addr + 'd1;  //channel +1
                end
                LD_3COL2BUFF_C2: begin
                    if(cnt<'d3 || (cnt>'d13&&cnt<'d16) || (cnt>'d29&&cnt<'d33)|| (cnt>'d43&&cnt<'d46)|| (cnt>'d59&&cnt<'d63)||(cnt>'d73&&cnt<'d76))
                        bram_weight_addr <= bram_weight_addr + 'd3;
                    else if (cnt == 'd16 || cnt == 'd46)
                        bram_weight_addr <= bram_weight_addr - 'd14;
                    else if (cnt == 8'd89) bram_weight_addr <= bram_weight_addr + 'd1;
                end
                LD_3COL2BUFF_F1, LD_3COL2BUFF_ACCU28_1: begin
                    if (cnt != 'd84 && cnt != 'd169 && cnt != 'd254)
                        bram_weight_addr <= bram_weight_addr +'d1; //(252*128)*2      //push to reg dont add1
                end
                LD_3COL2BUFF_ACCU28_2: begin
                    if (cnt < 'd72) bram_weight_addr <= bram_weight_addr + 'd1;  //72*128
                end
                LD_3COL2BUFF_F2: begin
                    if (cnt < 'd84 || (cnt > 'd84 && cnt < 'd129))
                        bram_weight_addr <= bram_weight_addr + 'd1;  //128*10
                end
                //bias
                ONE_OFMAP_DONE_C1: bram_bias_addr <= bram_bias_addr + 'd1;  //8
                ONE_OFMAP_DONE_C2: bram_bias_addr <= bram_bias_addr + 'd1;  //16
                ACCU28_STR_F1, ACCU28_STR_F2: begin
                    if (st != nst) bram_bias_addr <= bram_bias_addr + 'd1;  // +128 +10  
                end
            endcase
        end
    end
    always @(*) begin
        bram_img_addr = ((row_i << 5) - (row_i << 1)) + col_i;  //row_i*30+col_i 
        //
        bram_ofmap1_waddr = (st==READ4_MP1||st==STR_MP1||st==MP1_DONE) ? 'd6272 + ((depth_o<<8)-(depth_o<<6)+(depth_o<<2)+stride_cnt)  /*((depth_o<<8)-(depth_o<<6)+(depth_o<<2))+ ((row_o<<4)-(row_o<<1))+ col_o*/ :    //MP1 output
        ((depth_o<<10)-(depth_o<<8)+(depth_o<<4))+ ((row_o<<5)-(row_o<<2))+ col_o;         //CONV1 output
        //
        bram_ofmap1_raddr = (st==READ4_MP1||st==STR_MP1||st==MP1_DONE) ? ((depth_o<<10)-(depth_o<<8)+(depth_o<<4))+ ((row_i<<5)-(row_i<<2))+ col_i :      //depth_i*784 + row*28 +col     //MP1 input
        'd6272 + ((depth_i<<8)-(depth_i<<6)+(depth_i<<2))+ ((row_i<<4)-(row_i<<1))+ col_i;   //depth_i*196 + row*14 +col     //conv2 input        
        //       
        bram_ofmap2_waddr = (st==PP_STR_LD_C2) ? ((depth_o<<7)+(depth_o<<4))+ ((row_o<<3)+(row_o<<2))+ col_o:     //d*144+r*12+c      //CONV2 output
        (st==STR_MP2) ? 'd2304+ ((depth_o<<5)+(depth_o<<2)+stride_cnt)/*((depth_o<<5)+(depth_o<<2))+ ((row_o<<2)+(row_o<<1))+ col_o*/:    //d*36+r*6+c       //MP2 output       
        (st == ACCU28_STR_F1) ? 'd2880 + depth_o :  //FC1 output
        (st == ACCU28_STR_F2) ? 'd3008 + depth_o : 'd4095;  //FC2 output
        //
        bram_ofmap2_raddr = (st==PP_STR_LD_C2) ? ((depth_o<<7)+(depth_o<<4))+ ((row_o<<3)+(row_o<<2))+ col_o :     //d*144+r*12+c      CONV2 accumulate input | MP2 input//
        (st==READ4_MP2) ? ((depth_o<<7)+(depth_o<<4))+ ((row_i<<3)+(row_i<<2))+ col_i :
        (st==LD_3COL2BUFF_F1||st==LD_3COL2BUFF_ACCU28_1||st==LD_3COL2BUFF_ACCU28_2) ? 'd2304 + ((depth_i<<5)+(depth_i<<2))+((row_i<<2)+(row_i<<1))+col_i  /*'d2304 + depth_i */ :  //36*d + 6*r +c        //Flatten input
        (st == LD_3COL2BUFF_F2) ? 'd2880 + depth_i :  //FC2 input
        (st == SF) ? 'd3008 + depth_i : 'd4095;  //SF input  
    end
    always @(posedge clk or posedge rst) begin  //for conv only
        if (rst) begin
            row_i <= 'd0;
            col_i <= 'd0;
            row_o <= 'd0;
            col_o <= 'd0;
        end else begin
            case (st)
                LD_3COL2BUFF_C1: begin
                    row_i <= (row_i == `img_h + 'd1) ? 'd0 : row_i + 'd1;
                    col_i <= (row_i == `img_h + 'd1) ? col_i + 'd1 : col_i;
                end
                PP_STR_LD_C1: begin
                    row_i <= (st != nst) ? 'd0 : row_i + 'd1;  //r
                    col_i <= (nst==ONE_OFMAP_DONE_C1) ? 'd0 : 
                         (nst==MAC_C1) ? col_i+'d1 : col_i;
                    row_o <= (cnt < 'd27) ? row_o + 'd1 : 'd0;  //w
                    col_o <= (nst==ONE_OFMAP_DONE_C1) ? 'd0 :
                         (nst==MAC_C1) ? col_o+'d1 : col_o;
                end
                READ4_MP1: begin
                    if (cnt == 'd0 || cnt == 'd2) begin
                        row_i <= row_i + 'd1;
                    end else if (cnt == 'd1) begin
                        row_i <= row_i - 'd1;
                        col_i <= col_i + 'd1;
                    end else if (cnt == 'd3) begin
                        row_i <= (row_i=='d27&&col_i=='d27) ? 'd0 : (col_i=='d27) ? row_i + 'd1 : row_i - 'd1;
                        col_i <= (row_i=='d27&&col_i=='d27) ? 'd0 : (col_i=='d27) ? 'd0 : col_i + 'd1;
                    end
                end
                LD_3COL2BUFF_C2: begin
                    row_i <= (cnt=='d13 || cnt=='d29 || cnt=='d43 || cnt=='d59 || cnt=='d73 || cnt=='d89) ? 'd0 : row_i +'d1;
                    col_i <= (cnt == 'd29 || cnt == 'd59 || cnt == 'd89) ? col_i + 'd1 : col_i;
                end
                PP_STR_LD_C2: begin
                    row_i <= (st != nst || cnt == 'd13) ? 'd0 : row_i + 'd1;
                    col_i <= (nst==LD_3COL2BUFF_C2 || nst==ONE_OFMAP_DONE_C2) ? 'd0 :
                         (nst==MAC_C2) ? col_i+'d1 : col_i;
                    row_o <= (cnt=='d11 || cnt>='d23) ? 'd0 : row_o+'d1;         //need use wen defend
                    col_o <= (nst==LD_3COL2BUFF_C2 || nst==ONE_OFMAP_DONE_C2) ? 'd0 :
                         (nst==MAC_C2) ? col_o+'d1 : col_o;
                end
                READ4_MP2: begin
                    if (cnt == 'd0 || cnt == 'd2) begin
                        row_i <= row_i + 'd1;
                    end else if (cnt == 'd1) begin
                        row_i <= row_i - 'd1;
                        col_i <= col_i + 'd1;
                    end else if (cnt == 'd3) begin
                        row_i <= (row_i=='d11&&col_i=='d11) ? 'd0 : (col_i=='d11) ? row_i + 'd1 : row_i - 'd1;
                        col_i <= (row_i=='d11&&col_i=='d11) ? 'd0 : (col_i=='d11) ? 'd0 : col_i + 'd1;
                    end
                end
                MP2_DONE: begin
                    row_i <= 'd0;
                    col_i <= 'd0;

                end
                LD_3COL2BUFF_F1, LD_3COL2BUFF_ACCU28_1: begin
                    if ((cnt != 'd84 && cnt != 'd169 && cnt != 'd254)) begin
                        row_i <= (row_i=='d5&&col_i=='d5&&channel_cnt=='d15) ? 'd0 : (col_i=='d5&&channel_cnt=='d15) ? row_i + 'd1 : row_i ;
                        col_i <= (col_i=='d5&&channel_cnt=='d15) ? 'd0 : (channel_cnt=='d15) ? col_i + 'd1 : col_i;
                    end
                end
                LD_3COL2BUFF_ACCU28_2: begin
                    if (cnt != 'd72) begin

                        col_i <= (col_i=='d5&&channel_cnt=='d15) ? 'd0 : (channel_cnt=='d15) ? col_i + 'd1 : col_i;
                    end
                end
                ACCU28_STR_F1, ACCU28_STR_F2: begin
                    row_i <= 'd0;
                    col_i <= 'd0;
                end
                /*
        else if((st==LD_3COL2BUFF_F1||st==LD_3COL2BUFF_ACCU28_1)&&((cnt!='d84 && cnt!='d169 && cnt!='d254)))
            channel_ncnt = channel_cnt + 'd1;  //fc1   
        else if (st == LD_3COL2BUFF_ACCU28_2 && cnt < 'd72) channel_ncnt = channel_cnt + 'd1;  //fc1
        */
            endcase
        end
    end

    //PE  wen 
    always @(*) begin
        case (st)
            LD_3COL2BUFF_C1: begin
                if (cnt == 'd31 || cnt == 'd63 || cnt == 'd95) begin
                    ifmap_pe_wen  = 1'd1;
                    weight_pe_wen = 1'd1;
                end else begin
                    ifmap_pe_wen  = 1'd0;
                    weight_pe_wen = 1'd0;
                end
            end
            PP_STR_LD_C1: begin
                if (cnt == 'd31) begin
                    ifmap_pe_wen  = 1'd1;
                    weight_pe_wen = 1'd0;
                end else begin
                    ifmap_pe_wen  = 1'd0;
                    weight_pe_wen = 1'd0;
                end
            end
            LD_3COL2BUFF_C2: begin
                if (cnt == 'd29 || cnt == 'd59 || cnt == 'd89) begin
                    ifmap_pe_wen  = 1'd1;
                    weight_pe_wen = 1'd1;
                end else begin
                    ifmap_pe_wen  = 1'd0;
                    weight_pe_wen = 1'd0;
                end
            end
            PP_STR_LD_C2: begin
                if (cnt == 'd29) begin
                    ifmap_pe_wen  = 1'd1;
                    weight_pe_wen = 1'd0;
                end else begin
                    ifmap_pe_wen  = 1'd0;
                    weight_pe_wen = 1'd0;
                end
            end
            LD_3COL2BUFF_F1: begin
                if (cnt == 'd84 || cnt == 'd169 || cnt == 'd254) begin
                    ifmap_pe_wen  = 1'd1;
                    weight_pe_wen = 1'd1;
                end else begin
                    ifmap_pe_wen  = 1'd0;
                    weight_pe_wen = 1'd0;
                end
            end
            LD_3COL2BUFF_ACCU28_1: begin
                if (cnt == 'd84 || cnt == 'd169 || cnt == 'd254) begin
                    ifmap_pe_wen  = 1'd1;
                    weight_pe_wen = 1'd1;
                end else begin
                    ifmap_pe_wen  = 1'd0;
                    weight_pe_wen = 1'd0;
                end
            end
            LD_3COL2BUFF_ACCU28_2: begin
                if (cnt == 'd72) begin
                    ifmap_pe_wen  = 1'd1;
                    weight_pe_wen = 1'd1;
                end else begin
                    ifmap_pe_wen  = 1'd0;
                    weight_pe_wen = 1'd0;
                end
            end
            LD_3COL2BUFF_F2: begin
                if (cnt == 'd84 || cnt == 'd129) begin
                    ifmap_pe_wen  = 1'd1;
                    weight_pe_wen = 1'd1;
                end else begin
                    ifmap_pe_wen  = 1'd0;
                    weight_pe_wen = 1'd0;
                end
            end
            default: begin
                ifmap_pe_wen  = 1'd0;
                weight_pe_wen = 1'd0;
            end
        endcase
    end

    assign reg_pe_clear = (st == MAC2_F1 || st == FC1_DONE || st == ACCU28_STR_F2);




    //Buff  
    //clear
    always @(*) begin
        i_buff_clear = ((st==LD_3COL2BUFF_C1&&(cnt=='d31||cnt=='d63))||(st==LD_3COL2BUFF_C2&&(cnt=='d29||cnt=='d59))||(st==LD_3COL2BUFF_F2&&cnt=='d84)||st==MAC_C1||st==ONE_OFMAP_DONE_C1||st==MAC_C2||st==ONE_OFMAP_DONE_C2||st==MAC1_F1||st==MAC2_F1||st==MAC3_F1||st==MAC_F2) ? 1'b1 : 1'b0;
        w_buff_clear = ((st==LD_3COL2BUFF_C1&&(cnt=='d31||cnt=='d63))||(st==LD_3COL2BUFF_C2&&(cnt=='d29||cnt=='d59))||(st==LD_3COL2BUFF_F2&&cnt=='d84)||st==MAC_C1||st==ONE_OFMAP_DONE_C1||st==MAC_C2||st==ONE_OFMAP_DONE_C2||st==MAC1_F1||st==MAC2_F1||st==MAC3_F1||st==MAC_F2) ? 1'b1 : 1'b0;
        fc_reg_clear = (st == LD_3COL2BUFF_F1 || st == LD_3COL2BUFF_F2) ? 1'b1 : 1'b0;
    end

    //enable       
    always @(*) begin
        i_buff_wen = 1'b0;
        w_buff_wen = 1'b0;
        p_buff_wen = 1'b0;
        fc_reg_wen = 1'b0;
        case (st)
            LD_3COL2BUFF_C1: begin
                i_buff_wen = ( cnt!='d30 && cnt!='d31 && cnt!='d62 && cnt!='d63 && cnt!='d94 && cnt!='d95) ? 1'd1 : 1'd0;
                w_buff_wen = (cnt<'d3 || (cnt>'d31&&cnt<'d35) || (cnt>'d63&&cnt<'d67)) ? 1'd1 : 1'd0;
            end
            MAC_C1: begin
                p_buff_wen = 1'b1;
            end
            PP_STR_LD_C1: begin
                i_buff_wen = (cnt != 'd30 && cnt != 'd31) ? 1'd1 : 1'd0;
            end
            LD_3COL2BUFF_C2: begin
                i_buff_wen = ( cnt!='d28 && cnt!='d29 && cnt!='d58 && cnt!='d59 && cnt!='d88 && cnt!='d89 ) ? 1'd1 : 1'd0;
                w_buff_wen = (cnt<'d3 || (cnt>'d13&&cnt<'d17) || (cnt>'d29&&cnt<'d33)|| (cnt>'d43&&cnt<'d47)|| (cnt>'d59&&cnt<'d63)||(cnt>'d73&&cnt<'d77)) ? 1'd1 : 1'd0;
            end
            MAC_C2: begin
                p_buff_wen = 1'b1;
            end
            PP_STR_LD_C2: begin
                i_buff_wen = (cnt != 'd28 && cnt != 'd29) ? 1'd1 : 1'd0;
            end
            LD_3COL2BUFF_F1: begin
                i_buff_wen = (cnt != 'd84 && cnt != 'd169 && cnt != 'd254) ? 1'd1 : 1'd0;
                w_buff_wen = (cnt != 'd84 && cnt != 'd169 && cnt != 'd254) ? 1'd1 : 1'd0;
            end
            MAC1_F1: begin
                p_buff_wen = 1'b1;
            end
            LD_3COL2BUFF_ACCU28_1: begin
                i_buff_wen = (cnt != 'd84 && cnt != 'd169 && cnt != 'd254) ? 1'd1 : 1'd0;
                w_buff_wen = (cnt != 'd84 && cnt != 'd169 && cnt != 'd254) ? 1'd1 : 1'd0;
                fc_reg_wen = (cnt < 'd28) ? 1'b1 : 1'b0;
            end
            MAC2_F1: begin
                p_buff_wen = 1'b1;
            end
            LD_3COL2BUFF_ACCU28_2: begin
                i_buff_wen = (cnt != 'd72) ? 1'd1 : 1'd0;
                w_buff_wen = (cnt != 'd72) ? 1'd1 : 1'd0;
                fc_reg_wen = (cnt < 'd28) ? 1'b1 : 1'b0;
            end
            MAC3_F1: begin
                p_buff_wen = 1'b1;
            end
            ACCU28_STR_F1: begin
                fc_reg_wen = 1'b1;
            end
            LD_3COL2BUFF_F2: begin
                i_buff_wen = (cnt != 'd84 && cnt != 'd129) ? 1'd1 : 1'd0;
                w_buff_wen = (cnt != 'd84 && cnt != 'd129) ? 1'd1 : 1'd0;
            end
            MAC_F2: begin
                p_buff_wen = 1'b1;
            end
            ACCU28_STR_F2: begin
                fc_reg_wen = 1'b1;
            end
        endcase
    end

    assign align_conv1 = ((st==LD_3COL2BUFF_C1&&(cnt=='d30||cnt=='d62||cnt=='d94))||(st==PP_STR_LD_C1&&cnt=='d30));
    assign align_conv2 = ((st==LD_3COL2BUFF_C2&&(cnt=='d28||cnt=='d58||cnt=='d88))||(st==PP_STR_LD_C2&&cnt=='d28));

    //addr
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            buff_addr <= 'd0;
        end else begin
            case (st)
                LD_3COL2BUFF_C1: begin  //0~30  *3
                    buff_addr <= (cnt=='d31||cnt=='d63||cnt=='d95) ? 'd0 : buff_addr+'d1;
                end
                PP_STR_LD_C1: begin  //0~30
                    buff_addr <= (cnt == 'd31 || nst == ONE_OFMAP_DONE_C1) ? 'd0 : buff_addr + 'd1;
                end
                LD_3COL2BUFF_C2: begin  //0~13 36~49 *3
                    buff_addr <= (cnt=='d29||cnt=='d59||cnt=='d89) ? 'd0 :
                                 (cnt=='d13||cnt=='d43||cnt=='d73) ? 'd36 : buff_addr+'d1;
                end
                PP_STR_LD_C2: begin  //0~13 36~49
                    buff_addr <= (cnt == 'd29 || nst==LD_3COL2BUFF_C2 || nst==ONE_OFMAP_DONE_C2) ? 'd0 : (cnt == 'd13) ? 'd36 : buff_addr + 'd1;
                end
                LD_3COL2BUFF_F1: begin  //0~83 *3
                    buff_addr <= (cnt=='d84 || cnt=='d169 || cnt=='d254) ? 'd0 : buff_addr+'d1;
                end
                LD_3COL2BUFF_ACCU28_1: begin  //0~83 *3
                    buff_addr <= (cnt=='d84 || cnt=='d169 || cnt=='d254) ? 'd0 : buff_addr+'d1;
                end
                LD_3COL2BUFF_ACCU28_2: begin  //0~71
                    buff_addr <= (cnt == 'd72) ? 'd0 : buff_addr + 'd1;
                end
                LD_3COL2BUFF_F2: begin  //0~83 0~43
                    buff_addr <= (cnt == 'd84 || cnt == 'd129) ? 'd0 : buff_addr + 'd1;
                end
                default: begin
                    buff_addr <= 'd0;
                end
            endcase
        end
    end
    assign i_buff_w_addr = buff_addr;
    assign w_buff_w_addr = buff_addr;
    assign p_buff_r_addr = cnt[4:0];  //always in PP st fisrt 28 cycle acc

    //MUX   
    always @(*) begin
        mux_if_sel   = 'd3;
        mux_of_sel   = 'd3;
        mux_pb_sel   = 'd3;
        mux_of12_sel = 'd1;
        case (st)
            //CONV1
            LD_3COL2BUFF_C1: begin
                mux_if_sel = 'd0;
            end
            PP_STR_LD_C1: begin
                mux_if_sel = 'd0;
                mux_of_sel = 'd0;
                mux_pb_sel = 'd2;
            end
            //MP1
            READ4_MP1, STR_MP1: begin
                mux_of_sel   = 'd2;
                mux_of12_sel = 'd0;
            end
            //CONV2
            LD_3COL2BUFF_C2: begin
                mux_if_sel = 'd1;
            end
            PP_STR_LD_C2: begin
                mux_if_sel = 'd1;
                mux_of_sel = ((channel_cnt == `C1_c - 'd1 || channel_cnt == `C1_c - 'd2) && cnt>='d12) ? 'd0 : 'd1;
                mux_pb_sel = (channel_cnt == 'd0 && cnt < 'd12) ? 'd2 : 'd0;
            end
            //MP2
            READ4_MP2, STR_MP2: begin
                mux_of_sel   = 'd2;
                mux_of12_sel = 'd1;
            end
            //FC1
            LD_3COL2BUFF_F1: begin
                mux_if_sel = 'd2;
            end
            LD_3COL2BUFF_ACCU28_1: begin
                mux_if_sel = 'd2;
                mux_pb_sel = (cnt == 'd0) ? 'd2 : 'd1;
            end
            LD_3COL2BUFF_ACCU28_2: begin
                mux_if_sel = 'd2;
                mux_pb_sel = 'd1;
            end
            ACCU28_STR_F1: begin
                mux_of_sel = 'd0;
                mux_pb_sel = 'd1;
            end
            //FC2
            LD_3COL2BUFF_F2: begin
                mux_if_sel = 'd2;
            end
            ACCU28_STR_F2: begin
                mux_of_sel = 'd0;
                mux_pb_sel = (cnt == 'd0) ? 'd2 : 'd1;
            end
            //SF
            SF: begin
                mux_of12_sel = 'd1;
            end
        endcase
    end

    //Other
    assign done = (st == DONE) ? 'd1 : 'd0;
    assign MPSF_clear = (st == CONV1_DONE || st == STR_MP1 || st==CONV2_DONE || st == STR_MP2 || st == FC2_DONE) ? 'd1 : 'd0;






endmodule
