module SRAM(clk,rst,wen,waddr,wdata,raddr,rdata);
    parameter width = 16;
    parameter size = 4096;
    parameter addr_wid = 12;

    input clk,rst;
    input wen;
    input [addr_wid-1:0] waddr,raddr;
    input [width-1:0] wdata;
    output [width-1:0] rdata;

    reg [width-1:0] mem [0:size-1];

    integer i1;
    //write(sequential)
    always @(posedge clk or posedge rst) 
    begin
        if (rst) begin
            for ( i1=0 ; i1<size ; i1=i1+1 ) begin
                mem[i1] <= 'd0;
            end
        end
        else begin
            if (wen) 
            begin
                mem[waddr] <=wdata;        
            end   
        end 
    end

    //read(comb)    
    assign  rdata = mem[raddr];

endmodule
