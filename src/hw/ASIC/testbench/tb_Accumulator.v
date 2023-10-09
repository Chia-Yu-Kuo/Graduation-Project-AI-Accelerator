`include "Accumulator.v"
`timescale 1ns/10ps

`define CYCLE 10 

module tb_Accumulator;
reg clk;
reg rst;
reg signed[`psum_wid-1:0] pe_out,psum_or_bias;
wire signed[`psum_wid-1:0] result;

Accumulator accumulator
(
    .pe_out(pe_out),
    .psum_or_bias(psum_or_bias),
    .result(result)
);

always #(`CYCLE/2) clk=~clk;

initial begin
        clk<=1'b1;
    #(`CYCLE*1) rst<=1;
    #(`CYCLE*1) rst<=0;
    #(`CYCLE*1) pe_out= 'd8; psum_or_bias= 'd9;
    #(`CYCLE*1) pe_out= -'d8; psum_or_bias= 'd9;
    #(`CYCLE*1) pe_out= 'd8; psum_or_bias= -'d9;
    #(`CYCLE*1) pe_out= -'d8; psum_or_bias= -'d9;
    $finish;
end

initial begin
    $dumpfile("tb_Accumulator.vcd");
    $dumpvars(0, tb_Accumulator);
end

always @(*) begin
    $display($time, "%d + %d = %d",pe_out,psum_or_bias,result);
end

endmodule