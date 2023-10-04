module SROM(raddr,rdata);
    parameter width = 16;
    parameter size = 4096;
    parameter addr_wid = 12;

    input [addr_wid-1:0]raddr;
    output [width-1:0] rdata;

    reg [width-1:0] mem [0:size-1];

    //read(comb)    
    assign  rdata = mem[raddr];

endmodule
