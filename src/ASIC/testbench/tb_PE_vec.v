`include "PE_vec.v"
`include "PE.v"
`timescale 1ns/10ps

`define CYCLE 10 

module tb_PE_vec;
reg clk,rst;
reg ifmap_wen,weight_wen;
reg signed [`ifmap_wid-1:0] PE1_ifmap,PE2_ifmap,PE3_ifmap;
reg signed [`weight_wid-1:0] PE1_weight,PE2_weight,PE3_weight;
wire signed [`psum_wid-1:0] psum;

PE_vec pe_vec
(
    .clk(clk),
    .rst(rst),
    .ifmap_wen(ifmap_wen),
    .weight_wen(weight_wen), 
    .PE1_ifmap(PE1_ifmap),
    .PE1_weight(PE1_weight),
    .PE2_ifmap(PE2_ifmap),
    .PE2_weight(PE2_weight),
    .PE3_ifmap(PE3_ifmap),
    .PE3_weight(PE3_weight),
    .psum(psum) 
);

always #(`CYCLE/2) clk=~clk;

initial begin
        clk<=1'b1;
    #(`CYCLE*1) rst = 'd1;
    #(`CYCLE*1) rst = 'd0;
    #(`CYCLE*1) ifmap_wen = 0;weight_wen = 0;
    #(`CYCLE*1) PE1_ifmap = 1;PE1_weight = -1;PE2_ifmap = 2;PE2_weight = 9;PE3_ifmap = 7;PE3_weight = -7;
    #(`CYCLE*1) ifmap_wen = 1;weight_wen = 1;
    #(`CYCLE*1) ifmap_wen = 0;weight_wen = 0;
    #(`CYCLE*1) PE1_ifmap = 5;PE1_weight = 0;PE2_ifmap = 4;PE2_weight = 2;PE3_ifmap = 8;PE3_weight = 11;
    #(`CYCLE*1) ifmap_wen = 1;weight_wen = 1;
    #(`CYCLE*1) ifmap_wen = 0;weight_wen = 0;
    #(`CYCLE*1) PE1_ifmap = 3;PE1_weight = 3;PE2_ifmap = 6;PE2_weight = -4;PE3_ifmap = 9;PE3_weight = 6;
    #(`CYCLE*1) ifmap_wen = 1;weight_wen = 1;
    #(`CYCLE*1) ifmap_wen = 0;weight_wen = 0;     //CONV out1
    #(`CYCLE*1) PE1_ifmap = 2;PE2_ifmap = 8;PE3_ifmap = 7;
    #(`CYCLE*1) ifmap_wen = 1;
    #(`CYCLE*1) ifmap_wen = 0;     //CONV out2       
    #(`CYCLE*1) PE1_ifmap = 4;PE2_ifmap = 9;PE3_ifmap = 8;
    #(`CYCLE*1) ifmap_wen = 1;
    #(`CYCLE*1) ifmap_wen = 0;     //CONV out3
    #(`CYCLE*1) PE1_ifmap = 3;PE2_ifmap = 1;PE3_ifmap = 9;
    #(`CYCLE*1) ifmap_wen = 1;
    #(`CYCLE*1) ifmap_wen = 0;     //CONV out4
    #(`CYCLE*1) PE1_ifmap = 5;PE2_ifmap = 3;PE3_ifmap = 10;
    #(`CYCLE*1) ifmap_wen = 1;
    #(`CYCLE*1) ifmap_wen = 0;     //CONV out5
    #(`CYCLE*1) PE1_ifmap = 6;PE2_ifmap = 4;PE3_ifmap = 1;
    #(`CYCLE*1) ifmap_wen = 1;
    #(`CYCLE*1) ifmap_wen = 0;     //CONV out6
    #(`CYCLE*1) PE1_ifmap = 7;PE2_ifmap = 5;PE3_ifmap = 2;
    #(`CYCLE*1) ifmap_wen = 1;
    #(`CYCLE*1) ifmap_wen = 0;     //CONV out7
    #(`CYCLE*1) PE1_ifmap = 15;PE2_ifmap = 6;PE3_ifmap = 3;
    #(`CYCLE*1) ifmap_wen = 1;
    #(`CYCLE*1) ifmap_wen = 0;     //CONV out8
    $finish;
end



initial begin
    $dumpfile("tb_PE_vec.vcd");
    $dumpvars(0, tb_PE_vec);
end

always @(*) begin
    $display($time, "psum:  %d",psum);
end

endmodule