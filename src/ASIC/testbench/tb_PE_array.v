`include "PE_array.v"
`include "PE_vec.v"
`include "PE.v"
`timescale 1ns/10ps

`define CYCLE 10 

module tb_PE_array;
reg clk,rst;
reg ifmap_pe_wen,weight_pe_wen;
reg i_buff_wen,w_buff_wen,p_buff_wen,fc_reg_wen;
reg i_buff_clear,w_buff_clear,fc_reg_clear;
reg [`ifmap_wid-1:0] i_buff_w_data;
reg [`ifmap_buff_wid-1:0] i_buff_w_addr;
reg [`weight_wid-1:0] w_buff_w_data;
reg [`weight_buff_wid-1:0] w_buff_w_addr;
reg align_conv1,align_conv2;
reg [`psum_buff_wid-1:0] p_buff_r_addr;
reg [`psum_wid-1:0] fc_reg_in;
wire [`psum_wid-1:0] p_buff_r_data;
wire [`psum_wid-1:0] fc_reg_out;

integer i1;

PE_array pe_array
(
    .clk(clk),
    .rst(rst),
    .ifmap_pe_wen(ifmap_pe_wen),
    .weight_pe_wen(weight_pe_wen),                 //27 can write each time
    .i_buff_w_data(i_buff_w_data),
    .i_buff_w_addr(i_buff_w_addr),
    .i_buff_wen(i_buff_wen),
    .i_buff_clear(i_buff_clear),    //one can write each time
    .w_buff_w_data(w_buff_w_data),
    .w_buff_w_addr(w_buff_w_addr),
    .w_buff_wen(w_buff_wen),
    .w_buff_clear(w_buff_clear),    //one can write each time
    .align_conv1(align_conv1),
    .align_conv2(align_conv2),
    .p_buff_r_addr(p_buff_r_addr),
    .p_buff_r_data(p_buff_r_data),
    .p_buff_wen(p_buff_wen),
    .fc_reg_in(fc_reg_in),
    .fc_reg_out(fc_reg_out),
    .fc_reg_wen(fc_reg_wen),
    .fc_reg_clear(fc_reg_clear)
);

always #(`CYCLE/2) clk=~clk;

initial begin
        clk<=1'b1;
    #(`CYCLE*1) rst = 'd1;
    #(`CYCLE*1) rst = 'd0;
    #(`CYCLE*1) ifmap_pe_wen = 0;weight_pe_wen = 0;
    ////////////////////////////////////////////////////////CONV1 test///////////////////////////////////////////////
    //clr buff
    #(`CYCLE*1) i_buff_clear = 1;w_buff_clear = 1;
    #(`CYCLE*1) i_buff_clear = 0;w_buff_clear = 0;
    //w buff
    #(`CYCLE*1) i_buff_w_data = 1; w_buff_w_data =-1; i_buff_w_addr = 0; w_buff_w_addr =0; i_buff_wen = 1; w_buff_wen = 1; 
    #(`CYCLE*1) i_buff_w_data = 2; w_buff_w_data = 9; i_buff_w_addr = 1; w_buff_w_addr =1;
    #(`CYCLE*1) i_buff_w_data = 7; w_buff_w_data =-7; i_buff_w_addr = 2; w_buff_w_addr =2;
    #(`CYCLE*1) i_buff_w_data = 1;                    i_buff_w_addr = 3; w_buff_wen = 0;
    #(`CYCLE*1) i_buff_w_data = 6;                    i_buff_w_addr = 4; 
    //sort
    #(`CYCLE*1) align_conv1 = 1; i_buff_wen = 0; 
    //pe wen
    #(`CYCLE*1) ifmap_pe_wen = 1;weight_pe_wen = 1; align_conv1 = 0;
    #(`CYCLE*1) ifmap_pe_wen = 0;weight_pe_wen = 0;
    //clr buff
    #(`CYCLE*1) i_buff_clear = 1;w_buff_clear = 1;
    #(`CYCLE*1) i_buff_clear = 0;w_buff_clear = 0;
    //w buff
    #(`CYCLE*1) i_buff_w_data = 5; w_buff_w_data = 0; i_buff_w_addr = 0; w_buff_w_addr =0; i_buff_wen = 1; w_buff_wen = 1; 
    #(`CYCLE*1) i_buff_w_data = 4; w_buff_w_data = 2; i_buff_w_addr = 1; w_buff_w_addr =1;
    #(`CYCLE*1) i_buff_w_data = 8; w_buff_w_data =11; i_buff_w_addr = 2; w_buff_w_addr =2;
    #(`CYCLE*1) i_buff_w_data = 8;                    i_buff_w_addr = 3; w_buff_wen = 0;
    #(`CYCLE*1) i_buff_w_data = 4;                    i_buff_w_addr = 4; 
    //sort
    #(`CYCLE*1) align_conv1 = 1; i_buff_wen = 0; 
    //pe wen
    #(`CYCLE*1) ifmap_pe_wen = 1;weight_pe_wen = 1; align_conv1 = 0;
    #(`CYCLE*1) ifmap_pe_wen = 0;weight_pe_wen = 0;
    //clr buff
    #(`CYCLE*1) i_buff_clear = 1;w_buff_clear = 1;
    #(`CYCLE*1) i_buff_clear = 0;w_buff_clear = 0;
    //w buff
    #(`CYCLE*1) i_buff_w_data = 3; w_buff_w_data = 3; i_buff_w_addr = 0; w_buff_w_addr =0; i_buff_wen = 1; w_buff_wen = 1; 
    #(`CYCLE*1) i_buff_w_data = 6; w_buff_w_data =-4; i_buff_w_addr = 1; w_buff_w_addr =1;
    #(`CYCLE*1) i_buff_w_data = 9; w_buff_w_data = 6; i_buff_w_addr = 2; w_buff_w_addr =2;
    #(`CYCLE*1) i_buff_w_data = 7;                    i_buff_w_addr = 3; w_buff_wen = 0;
    #(`CYCLE*1) i_buff_w_data = 3;                    i_buff_w_addr = 4; 
    //sort
    #(`CYCLE*1) align_conv1 = 1; i_buff_wen = 0; 
    //pe wen
    #(`CYCLE*1) ifmap_pe_wen = 1;weight_pe_wen = 1; align_conv1 = 0;
    #(`CYCLE*1) ifmap_pe_wen = 0;weight_pe_wen = 0;   
    //psum_buff
    #(`CYCLE*1) p_buff_wen = 1;
    #(`CYCLE*1) p_buff_wen = 0;
    #(`CYCLE*1) i1=0;  p_buff_r_addr = i1; 
    repeat(27)begin
        #(`CYCLE*1) i1=i1+1; p_buff_r_addr = i1; 
    end
    //CONV out1
    //clr buff
    #(`CYCLE*1) i_buff_clear = 1;w_buff_clear = 1;
    #(`CYCLE*1) i_buff_clear = 0;w_buff_clear = 0;
    //w buff
    #(`CYCLE*1) i_buff_w_data = 2; i_buff_w_addr = 0; i_buff_wen = 1; 
    #(`CYCLE*1) i_buff_w_data = 8; i_buff_w_addr = 1;
    #(`CYCLE*1) i_buff_w_data = 7; i_buff_w_addr = 2;
    #(`CYCLE*1) i_buff_w_data = 6; i_buff_w_addr = 3; 
    #(`CYCLE*1) i_buff_w_data = 7; i_buff_w_addr = 4; 
    //sort
    #(`CYCLE*1) align_conv1 = 1; i_buff_wen = 0; 
    //pe wen
    #(`CYCLE*1) ifmap_pe_wen = 1; align_conv1 = 0;
    #(`CYCLE*1) ifmap_pe_wen = 0;     
    //psum_buff
    #(`CYCLE*1) p_buff_wen = 1;
    #(`CYCLE*1) p_buff_wen = 0;
    #(`CYCLE*1) i1=0;  p_buff_r_addr = i1; 
    repeat(27)begin
        #(`CYCLE*1) p_buff_r_addr = i1; i1=i1+1;
    end
    //CONV out2 
    //clr buff
    #(`CYCLE*1) i_buff_clear = 1;w_buff_clear = 1;
    #(`CYCLE*1) i_buff_clear = 0;w_buff_clear = 0;
    //w buff
    #(`CYCLE*1) i_buff_w_data = 4; i_buff_w_addr = 0; i_buff_wen = 1; 
    #(`CYCLE*1) i_buff_w_data = 9; i_buff_w_addr = 1;
    #(`CYCLE*1) i_buff_w_data = 8; i_buff_w_addr = 2;
    #(`CYCLE*1) i_buff_w_data = 6; i_buff_w_addr = 3; 
    #(`CYCLE*1) i_buff_w_data = 7; i_buff_w_addr = 4; 
    //sort
    #(`CYCLE*1) align_conv1 = 1; i_buff_wen = 0; 
    //pe wen
    #(`CYCLE*1) ifmap_pe_wen = 1; align_conv1 = 0;
    #(`CYCLE*1) ifmap_pe_wen = 0;     
    //psum_buff
    #(`CYCLE*1) p_buff_wen = 1;
    #(`CYCLE*1) p_buff_wen = 0;
    #(`CYCLE*1) i1=0;  p_buff_r_addr = i1; 
    repeat(27)begin
        #(`CYCLE*1) p_buff_r_addr = i1; i1=i1+1;
    end
    //CONV out3
    //clr buff
    #(`CYCLE*1) i_buff_clear = 1;w_buff_clear = 1;
    #(`CYCLE*1) i_buff_clear = 0;w_buff_clear = 0;
    //w buff
    #(`CYCLE*1) i_buff_w_data = 3; i_buff_w_addr = 0; i_buff_wen = 1; 
    #(`CYCLE*1) i_buff_w_data = 1; i_buff_w_addr = 1;
    #(`CYCLE*1) i_buff_w_data = 9; i_buff_w_addr = 2;
    #(`CYCLE*1) i_buff_w_data = 6; i_buff_w_addr = 3; 
    #(`CYCLE*1) i_buff_w_data = 7; i_buff_w_addr = 4; 
    //sort
    #(`CYCLE*1) align_conv1 = 1; i_buff_wen = 0; 
    //pe wen
    #(`CYCLE*1) ifmap_pe_wen = 1; align_conv1 = 0;
    #(`CYCLE*1) ifmap_pe_wen = 0;     
    //psum_buff
    #(`CYCLE*1) p_buff_wen = 1;
    #(`CYCLE*1) p_buff_wen = 0;
    #(`CYCLE*1) i1=0;  p_buff_r_addr = i1; 
    repeat(27)begin
        #(`CYCLE*1) p_buff_r_addr = i1; i1=i1+1;
    end
    //CONV out4
    ////////////////////////////////////////////////////////CONV2 test///////////////////////////////////////////////
    //clr buff
    #(`CYCLE*1) i_buff_clear = 1;w_buff_clear = 1;
    #(`CYCLE*1) i_buff_clear = 0;w_buff_clear = 0;
    //w buff
    #(`CYCLE*1) i_buff_w_data = 1; w_buff_w_data =-1; i_buff_w_addr = 0; w_buff_w_addr =0; i_buff_wen = 1; w_buff_wen = 1; 
    #(`CYCLE*1) i_buff_w_data = 2; w_buff_w_data = 9; i_buff_w_addr = 1; w_buff_w_addr =1;
    #(`CYCLE*1) i_buff_w_data = 7; w_buff_w_data =-7; i_buff_w_addr = 2; w_buff_w_addr =2;
    #(`CYCLE*1) i_buff_w_data = 1;                    i_buff_w_addr = 3; w_buff_wen = 0;
    #(`CYCLE*1) i_buff_w_data = 6;                    i_buff_w_addr = 4; 
    #(`CYCLE*1) i_buff_w_data = 1; w_buff_w_data =-1; i_buff_w_addr = 36; w_buff_w_addr =36; i_buff_wen = 1; w_buff_wen = 1; 
    #(`CYCLE*1) i_buff_w_data = 2; w_buff_w_data = 9; i_buff_w_addr = 37; w_buff_w_addr =37;
    #(`CYCLE*1) i_buff_w_data = 7; w_buff_w_data =-7; i_buff_w_addr = 38; w_buff_w_addr =38;
    #(`CYCLE*1) i_buff_w_data = 1;                    i_buff_w_addr = 39; w_buff_wen = 0;
    #(`CYCLE*1) i_buff_w_data = 6;                    i_buff_w_addr = 40; 
    //sort
    #(`CYCLE*1) align_conv2 = 1; i_buff_wen = 0; 
    //pe wen
    #(`CYCLE*1) ifmap_pe_wen = 1;weight_pe_wen = 1; align_conv2 = 0;
    #(`CYCLE*1) ifmap_pe_wen = 0;weight_pe_wen = 0;
    //clr buff
    #(`CYCLE*1) i_buff_clear = 1;w_buff_clear = 1;
    #(`CYCLE*1) i_buff_clear = 0;w_buff_clear = 0;
    //w buff
    #(`CYCLE*1) i_buff_w_data = 5; w_buff_w_data = 0; i_buff_w_addr = 0; w_buff_w_addr =0; i_buff_wen = 1; w_buff_wen = 1; 
    #(`CYCLE*1) i_buff_w_data = 4; w_buff_w_data = 2; i_buff_w_addr = 1; w_buff_w_addr =1;
    #(`CYCLE*1) i_buff_w_data = 8; w_buff_w_data =11; i_buff_w_addr = 2; w_buff_w_addr =2;
    #(`CYCLE*1) i_buff_w_data = 8;                    i_buff_w_addr = 3; w_buff_wen = 0;
    #(`CYCLE*1) i_buff_w_data = 4;                    i_buff_w_addr = 4; 
    #(`CYCLE*1) i_buff_w_data = 5; w_buff_w_data = 0; i_buff_w_addr = 36; w_buff_w_addr =36; i_buff_wen = 1; w_buff_wen = 1; 
    #(`CYCLE*1) i_buff_w_data = 4; w_buff_w_data = 2; i_buff_w_addr = 37; w_buff_w_addr =37;
    #(`CYCLE*1) i_buff_w_data = 8; w_buff_w_data =11; i_buff_w_addr = 38; w_buff_w_addr =38;
    #(`CYCLE*1) i_buff_w_data = 8;                    i_buff_w_addr = 39; w_buff_wen = 0;
    #(`CYCLE*1) i_buff_w_data = 4;                    i_buff_w_addr = 40; 
    //sort
    #(`CYCLE*1) align_conv2 = 1; i_buff_wen = 0; 
    //pe wen
    #(`CYCLE*1) ifmap_pe_wen = 1;weight_pe_wen = 1; align_conv2 = 0;
    #(`CYCLE*1) ifmap_pe_wen = 0;weight_pe_wen = 0;
    //clr buff
    #(`CYCLE*1) i_buff_clear = 1;w_buff_clear = 1;
    #(`CYCLE*1) i_buff_clear = 0;w_buff_clear = 0;
    //w buff
    #(`CYCLE*1) i_buff_w_data = 3; w_buff_w_data = 3; i_buff_w_addr = 0; w_buff_w_addr =0; i_buff_wen = 1; w_buff_wen = 1; 
    #(`CYCLE*1) i_buff_w_data = 6; w_buff_w_data =-4; i_buff_w_addr = 1; w_buff_w_addr =1;
    #(`CYCLE*1) i_buff_w_data = 9; w_buff_w_data = 6; i_buff_w_addr = 2; w_buff_w_addr =2;
    #(`CYCLE*1) i_buff_w_data = 7;                    i_buff_w_addr = 3; w_buff_wen = 0;
    #(`CYCLE*1) i_buff_w_data = 3;                    i_buff_w_addr = 4; 
    #(`CYCLE*1) i_buff_w_data = 3; w_buff_w_data = 3; i_buff_w_addr = 36; w_buff_w_addr =36; i_buff_wen = 1; w_buff_wen = 1; 
    #(`CYCLE*1) i_buff_w_data = 6; w_buff_w_data =-4; i_buff_w_addr = 37; w_buff_w_addr =37;
    #(`CYCLE*1) i_buff_w_data = 9; w_buff_w_data = 6; i_buff_w_addr = 38; w_buff_w_addr =38;
    #(`CYCLE*1) i_buff_w_data = 7;                    i_buff_w_addr = 39; w_buff_wen = 0;
    #(`CYCLE*1) i_buff_w_data = 3;                    i_buff_w_addr = 40; 
    //sort
    #(`CYCLE*1) align_conv2 = 1; i_buff_wen = 0; 
    //pe wen
    #(`CYCLE*1) ifmap_pe_wen = 1;weight_pe_wen = 1; align_conv2 = 0;
    #(`CYCLE*1) ifmap_pe_wen = 0;weight_pe_wen = 0;   
    //psum_buff
    #(`CYCLE*1) p_buff_wen = 1;
    #(`CYCLE*1) p_buff_wen = 0;
    
    #(`CYCLE*1) i1=0;  p_buff_r_addr = i1; 
    repeat(27)begin
        #(`CYCLE*1) p_buff_r_addr = i1; i1=i1+1;
    end
    //CONV out1
    //clr buff
    #(`CYCLE*1) i_buff_clear = 1;w_buff_clear = 1;
    #(`CYCLE*1) i_buff_clear = 0;w_buff_clear = 0;
    //w buff
    #(`CYCLE*1) i_buff_w_data = 2; i_buff_w_addr = 0; i_buff_wen = 1; 
    #(`CYCLE*1) i_buff_w_data = 8; i_buff_w_addr = 1;
    #(`CYCLE*1) i_buff_w_data = 7; i_buff_w_addr = 2;
    #(`CYCLE*1) i_buff_w_data = 6; i_buff_w_addr = 3; 
    #(`CYCLE*1) i_buff_w_data = 7; i_buff_w_addr = 4; 
    #(`CYCLE*1) i_buff_w_data = 2; i_buff_w_addr = 36; i_buff_wen = 1; 
    #(`CYCLE*1) i_buff_w_data = 8; i_buff_w_addr = 37;
    #(`CYCLE*1) i_buff_w_data = 7; i_buff_w_addr = 38;
    #(`CYCLE*1) i_buff_w_data = 6; i_buff_w_addr = 39; 
    #(`CYCLE*1) i_buff_w_data = 7; i_buff_w_addr = 40; 
    //sort
    #(`CYCLE*1) align_conv2 = 1; i_buff_wen = 0; 
    //pe wen
    #(`CYCLE*1) ifmap_pe_wen = 1; align_conv2 = 0;
    #(`CYCLE*1) ifmap_pe_wen = 0;     
    //psum_buff
    #(`CYCLE*1) p_buff_wen = 1;
    #(`CYCLE*1) p_buff_wen = 0;
    #(`CYCLE*1) i1=0;  p_buff_r_addr = i1; 
    repeat(27)begin
        #(`CYCLE*1) p_buff_r_addr = i1; i1=i1+1;
    end
    //CONV out2 
    //clr buff
    #(`CYCLE*1) i_buff_clear = 1;w_buff_clear = 1;
    #(`CYCLE*1) i_buff_clear = 0;w_buff_clear = 0;
    //w buff
    #(`CYCLE*1) i_buff_w_data = 4; i_buff_w_addr = 0; i_buff_wen = 1; 
    #(`CYCLE*1) i_buff_w_data = 9; i_buff_w_addr = 1;
    #(`CYCLE*1) i_buff_w_data = 8; i_buff_w_addr = 2;
    #(`CYCLE*1) i_buff_w_data = 6; i_buff_w_addr = 3; 
    #(`CYCLE*1) i_buff_w_data = 7; i_buff_w_addr = 4; 
    #(`CYCLE*1) i_buff_w_data = 4; i_buff_w_addr = 36; i_buff_wen = 1; 
    #(`CYCLE*1) i_buff_w_data = 9; i_buff_w_addr = 37;
    #(`CYCLE*1) i_buff_w_data = 8; i_buff_w_addr = 38;
    #(`CYCLE*1) i_buff_w_data = 6; i_buff_w_addr = 39; 
    #(`CYCLE*1) i_buff_w_data = 7; i_buff_w_addr = 40; 
    //sort
    #(`CYCLE*1) align_conv2 = 1; i_buff_wen = 0; 
    //pe wen
    #(`CYCLE*1) ifmap_pe_wen = 1; align_conv2 = 0;
    #(`CYCLE*1) ifmap_pe_wen = 0;     
    //psum_buff
    #(`CYCLE*1) p_buff_wen = 1;
    #(`CYCLE*1) p_buff_wen = 0;
    #(`CYCLE*1) i1=0;  p_buff_r_addr = i1; 
    repeat(27)begin
        #(`CYCLE*1) p_buff_r_addr = i1; i1=i1+1;
    end
    //CONV out3
    //clr buff
    #(`CYCLE*1) i_buff_clear = 1;w_buff_clear = 1;
    #(`CYCLE*1) i_buff_clear = 0;w_buff_clear = 0;
    //w buff
    #(`CYCLE*1) i_buff_w_data = 3; i_buff_w_addr = 0; i_buff_wen = 1; 
    #(`CYCLE*1) i_buff_w_data = 1; i_buff_w_addr = 1;
    #(`CYCLE*1) i_buff_w_data = 9; i_buff_w_addr = 2;
    #(`CYCLE*1) i_buff_w_data = 6; i_buff_w_addr = 3; 
    #(`CYCLE*1) i_buff_w_data = 7; i_buff_w_addr = 4; 
    #(`CYCLE*1) i_buff_w_data = 3; i_buff_w_addr = 36; i_buff_wen = 1; 
    #(`CYCLE*1) i_buff_w_data = 1; i_buff_w_addr = 37;
    #(`CYCLE*1) i_buff_w_data = 9; i_buff_w_addr = 38;
    #(`CYCLE*1) i_buff_w_data = 6; i_buff_w_addr = 39; 
    #(`CYCLE*1) i_buff_w_data = 7; i_buff_w_addr = 40; 
    //sort
    #(`CYCLE*1) align_conv2 = 1; i_buff_wen = 0; 
    //pe wen
    #(`CYCLE*1) ifmap_pe_wen = 1; align_conv2 = 0;
    #(`CYCLE*1) ifmap_pe_wen = 0;     
    //psum_buff
    #(`CYCLE*1) p_buff_wen = 1;
    #(`CYCLE*1) p_buff_wen = 0;
    #(`CYCLE*1) i1=0;  p_buff_r_addr = i1; 
    repeat(27)begin
        #(`CYCLE*1) p_buff_r_addr = i1; i1=i1+1;
    end
    //CONV out4
    ////////////////////////////////////////////////////////FC test///////////////////////////////////////////////
    $finish;
end



initial begin
    $dumpfile("tb_PE_array.vcd");
    $dumpvars(0, tb_PE_array);
end

always @(*) begin
    $display($time, "p_buff_r_data[%d]:  %d",i1,p_buff_r_data);
end
always @(*) begin
    $display($time, "fc_reg_out:  %d",fc_reg_out);
end

endmodule