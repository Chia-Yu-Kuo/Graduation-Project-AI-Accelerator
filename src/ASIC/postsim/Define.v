/*
///////include///////
`include "Accumulator.v"
`include "Bias_buff.v"
`include "Controller.v"
`include "Maxpooling_or_Softmax.v"
`include "Mux_ifmap.v"
`include "Mux_of12.v"
`include "Mux_ofmap.v"
`include "Mux_psum_or_bias.v"
`include "PE_array.v"
`include "PE_vec.v"
`include "PE.v"
`include "ReLU.v"
*/
///////define////////
//ctrl
`define cnt_wid 8

//pe_wid
`define img_wid 32
`define ifmap_wid 16
`define weight_wid 16
`define bias_wid 16
`define psum_wid 32
`define PS_wid 32

//bram addr wid
`define bram_img_wid 10
`define bram_weight_wid 17
`define bram_bias_wid 8
`define bram_ofmap1_wid 13
`define bram_ofmap2_wid 12

/*
    1.img
        32b*(30*30=900)
    2.weight
        16b*76232
    3.bias
        16b*162
    4.ofmap1
        32b*(28*28*8 + 14*14*8 = 7840)
    5.ofmap2
        32b*(12*12*16 + 6*6*16  + 128 +10 = 3018)
*/

/*dig
    1.ifmap 8+8    (img: 16 + (8+8))
    2.ofmap 16+16 
    3.weight 8+8
    4.bias 8+8
*/

//buffer size
`define bias_buff_size 1
`define bias_buff_wid 1
`define weight_buff_size 84
`define weight_buff_wid 7
`define ifmap_buff_size 84
`define ifmap_buff_wid 7 
`define psum_buff_size 28
`define psum_buff_wid 5


//img & ifmap size
`define  img_h 'd30
`define  img_w 'd30
`define  img_s 'd900
`define  C1_h  'd28
`define  C1_w  'd28
`define  C1_s  'd784
`define  S2_h  'd14
`define  S2_w  'd14
`define  S2_s  'd196
`define  C3_h  'd12 
`define  C3_w  'd12
`define  C3_s  'd144
`define  S4_h  'd6 
`define  S4_w  'd6
`define  S4_s  'd36 
`define  C5_h  'd576
`define  F6_h  'd128
`define  out_h 'd10 
 

//channel num
`define img_c   'd1 
`define C1_c    'd8
`define C3_c    'd16
