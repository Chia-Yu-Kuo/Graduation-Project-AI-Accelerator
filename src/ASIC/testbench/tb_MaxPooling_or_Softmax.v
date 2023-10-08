`include "MaxPooling_or_Softmax.v"
`timescale 1ns/10ps

`define CYCLE 10 

module tb_MaxPooling_or_Softmax;
reg clk,rst,clear;
reg [`cnt_wid-1:0] cnt;
reg signed [`psum_wid-1:0] data_in;
wire [`psum_wid-1:0] data_out;
wire [`PS_wid-1:0] idx;


always @(posedge clk or posedge rst) begin
	if (rst) begin
		cnt <= 'd0;
	end
	else begin
		if (clear) begin
			cnt <= 'd0;
		end
		else begin
			cnt <= cnt +'d1;
		end
	end
end

MaxPooling_or_Softmax maxpooling_or_softmax
(
    .clk(clk),
	.rst(rst),
	.cnt(cnt),
	.clear(clear),
	.data_in(data_in),
	.data_out(data_out),
	.idx(idx)
);

always #(`CYCLE/2) clk=~clk;

initial begin
        clk<=1'b1;
    #(`CYCLE*1) rst<=1;
    #(`CYCLE*1) rst<=0;
    #(`CYCLE*1) clear = 'd1;
    #(`CYCLE*1) clear = 'd0; data_in = 'd1;
    #(`CYCLE*1) data_in = 'd1;
    #(`CYCLE*1) data_in = 'd5;
    #(`CYCLE*1) data_in = 'd111;
    #(`CYCLE*1) data_in = 'd666;
    #(`CYCLE*1) data_in = 'd222;
    #(`CYCLE*1) data_in = -'d1;
    #(`CYCLE*1) data_in = 'd987;
    #(`CYCLE*1) clear = 'd1;
    #(`CYCLE*1) clear = 'd0; data_in = 'd6;
    #(`CYCLE*1) data_in = 'd45;
    #(`CYCLE*1) data_in = 'd999;
    #(`CYCLE*1) data_in = 'd1024;
    #(`CYCLE*1) data_in = 'd6;
    $finish;
end

initial begin
    $dumpfile("tb_MaxPooling_or_Softmax.vcd");
    $dumpvars(0, tb_MaxPooling_or_Softmax);
end

always @(*) begin
    $display($time, "data_out: %d , idx : %d",data_out,idx);
end

endmodule