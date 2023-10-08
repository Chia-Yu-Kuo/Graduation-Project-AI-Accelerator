`timescale 1ns/10ps
`include "ReLU.v"

`define CYCLE 10 

module tb_ReLU;
reg clk;
reg rst;
reg signed [`psum_wid-1:0] data_in;
wire signed [`psum_wid-1:0] data_out;

ReLU relu
(
    .data_in(data_in),
    .data_out(data_out)
);

always #(`CYCLE/2) clk=~clk;

initial begin
        clk<=1'b1;
    #(`CYCLE*1) data_in = 'd5;
    #(`CYCLE*1) data_in = 'd8;
    #(`CYCLE*1) data_in = 'd10;
    #(`CYCLE*1) data_in = 'd6985;
    #(`CYCLE*1) data_in = 'd4421;
    #(`CYCLE*1) data_in = -'d8;
    #(`CYCLE*1) data_in = 'd8;
    #(`CYCLE*1) data_in = -'d5487;
    #(`CYCLE*1) data_in = 'd6985;
    #(`CYCLE*1) data_in = -'d8745;
    $finish;
end

initial begin
    $dumpfile("tb_ReLU.vcd");
    $dumpvars(0, tb_ReLU);
end

always @(*) begin
    $display($time, "data_out:  %d",data_out);
end

endmodule