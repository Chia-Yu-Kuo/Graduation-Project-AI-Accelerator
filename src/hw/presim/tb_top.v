`timescale 1ns / 10ps
`ifdef syn
`include "./Top_syn.v"
`include "./tsmc18.v"
`else
`include "./Top.v"
`endif
`include "./SRAM.v"
`include "./SROM.v"
`include "./Define.v"

`define CYCLE 10.0    // Cycle time
`define MAX 10000000    // Max cycle number

`define test_img_path "./../../sw/test_img.hex"                          
`define weight_path "./../../sw/weights.hex"                          
`define bias_path "./../../sw/bias.hex"                          
`define test_label_path "./../../sw/test_label.hex"      

`define weight_end 76232
`define weight_end_data 16'hFFB6


module tb_top;

    reg clk, rst, start;
    wire done;
    wire [`PS_wid-1:0] predict;
    wire [`bram_img_wid-1:0] bram_img_addr;
    wire [`img_wid-1:0] bram_img_data;
    wire [`bram_weight_wid-1:0] bram_weight_addr;
    wire [`weight_wid-1:0] bram_weight_data;
    wire [`bram_bias_wid-1:0] bram_bias_addr;
    wire [`bias_wid-1:0] bram_bias_data;
    wire bram_ofmap1_wen, bram_ofmap2_wen;
    wire [`bram_ofmap1_wid-1:0] bram_ofmap1_raddr, bram_ofmap1_waddr;
    wire [`bram_ofmap2_wid-1:0] bram_ofmap2_raddr, bram_ofmap2_waddr;
    wire [`psum_wid-1:0] bram_ofmap1_rdata, bram_ofmap2_rdata;
    wire [`psum_wid-1:0] bram_ofmap1_wdata, bram_ofmap2_wdata;




    reg     [31:0] label;
    integer        num = 10000;  // total test data                                
    integer        err;  // total number of errors compared to golden data
    integer idx, iteration;
    integer fp_r_i, fp_r_l, cnt;

    Top top (
        .clk(clk),
        .rst(rst),
        .start(start),
        .done(done),
        .predict(predict),
        .bram_img_addr(bram_img_addr),
        .bram_img_data(bram_img_data),
        .bram_weight_addr(bram_weight_addr),
        .bram_weight_data(bram_weight_data),
        .bram_bias_addr(bram_bias_addr),
        .bram_bias_data(bram_bias_data),
        .bram_ofmap1_raddr(bram_ofmap1_raddr),
        .bram_ofmap1_rdata(bram_ofmap1_rdata),
        .bram_ofmap1_wen(bram_ofmap1_wen),
        .bram_ofmap1_waddr(bram_ofmap1_waddr),
        .bram_ofmap1_wdata(bram_ofmap1_wdata),
        .bram_ofmap2_raddr(bram_ofmap2_raddr),
        .bram_ofmap2_rdata(bram_ofmap2_rdata),
        .bram_ofmap2_wen(bram_ofmap2_wen),
        .bram_ofmap2_waddr(bram_ofmap2_waddr),
        .bram_ofmap2_wdata(bram_ofmap2_wdata)
    );
    SROM #(
        .width(32),
        .size(900),
        .addr_wid(10)
    ) im (
        .raddr(bram_img_addr),
        .rdata(bram_img_data)
    );
    SROM #(
        .width(16),
        .size(76232),
        .addr_wid(17)
    ) wm (
        .raddr(bram_weight_addr),
        .rdata(bram_weight_data)
    );
    SROM #(
        .width(16),
        .size(162),
        .addr_wid(8)
    ) bm (
        .raddr(bram_bias_addr),
        .rdata(bram_bias_data)
    );
    SRAM #(
        .width(32),
        .size(7840),
        .addr_wid(13)
    ) of1m (
        .clk  (clk),
        .rst  (rst),
        .wen  (bram_ofmap1_wen),
        .waddr(bram_ofmap1_waddr),
        .wdata(bram_ofmap1_wdata),
        .raddr(bram_ofmap1_raddr),
        .rdata(bram_ofmap1_rdata)
    );
    SRAM #(
        .width(32),
        .size(3018),
        .addr_wid(12)
    ) of2m (
        .clk  (clk),
        .rst  (rst),
        .wen  (bram_ofmap2_wen),
        .waddr(bram_ofmap2_waddr),
        .wdata(bram_ofmap2_wdata),
        .raddr(bram_ofmap2_raddr),
        .rdata(bram_ofmap2_rdata)
    );

    always #(`CYCLE / 2) clk = ~clk;

    initial begin
        clk = 0;
        err = 0;
        iteration = 0;
        // Load ROM data
        $readmemh(`weight_path, wm.mem);
        $readmemh(`bias_path, bm.mem);

        // Wait until end of weight
        wait (wm.mem[`weight_end-1] == `weight_end_data);
        $display("\nWM write Done\n");

        /*
        repeat(num)begin
          //load test img & label
          $readmemh(`test_img_path, im.mem);
          $readmemh(`test_label_path,label);

          // Wait until end of execution
          wait(im.mem[899] == 8'hff);
          $display("\nIM write Done\n");
        */

        fp_r_i = $fopen(`test_img_path, "r");
        fp_r_l = $fopen(`test_label_path, "r");

        repeat (1) begin
            idx = 0;
            //im
            repeat (900) begin
                cnt = $fscanf(fp_r_i, "%h", im.mem[idx]);
                idx = idx + 1;
                //if(!$feof(fp_r_i)) break;
            end
            //label            
            cnt = $fscanf(fp_r_l, "%h", label);


            //rst & start
            #(`CYCLE) rst = 1;
            #(`CYCLE) rst = 0;
            start = 1;
            #(`CYCLE) start = 0;
            wait (done);
            $display(
                "0:%h, 1:%h, 2:%h,, 3:%h, 4:%h, 5:%h, 6:%h, 7:%h, 8:%h, 9:%h, predict:%d, label:%d ",
                of2m.mem[3008], of2m.mem[3009], of2m.mem[3010], of2m.mem[3011], of2m.mem[3012],
                of2m.mem[3013], of2m.mem[3014], of2m.mem[3015], of2m.mem[3016], of2m.mem[3017],
                predict, label);


            if (predict != label) begin
                err = err + 1;
                $display("test [%d] predict:%h , but label is %h", iteration, predict, label);
            end
            iteration = iteration + 1;
        end

        $fclose(fp_r_i);
        $fclose(fp_r_l);


        // Print result
        result(err);
        $finish;

    end

    task result;
        input integer err;
        begin
            if (err === 0) begin
                $display("\n");
                $display("\n");
                $display("                                      `;-.          ___,");
                $display("        ****************************    `.`\\_...._/`.-\"`");
                $display("        **                        **      \\        /      ,");
                $display("        **                        **      /()   () \\   .' `-._");
                $display("        **   Congratulations !!   **     |)  .    ()\\ /   _.'");
                $display("        **                        **     \\  -'-     ,; '. <");
                $display("        **                        **      ;.__     ,;|   > \\");
                $display("        **   Simulation PASS!!    **     / ,    / ,  |.-'.-'");
                $display("        **                        **    (_/    (_/ ,;|.<`");
                $display("        **                        **      \\    ,     ;-`");
                $display("        ****************************       >   \\    /");
                $display("                                          (_,-'`> .'");
                $display("                                               (_,'");
                $display("\n");
            end else begin
                $display("\n");
                $display("\n");
                $display("        ****************************     /*\\_...._/*^\\");
                $display("        **                        **    (/^\\       / \\)  ,");
                $display("        **                        **      / X   X  \\   .' `-._");
                $display("        **   OOPS!                **     |)  .    ()\\ /   _.'");
                $display("        **                        **     \\   ^     ,; '. <");
                $display("        **                        **      ;.__     ,;|   > \\");
                $display("        **   Simulation Failed!!  **     / ,    / ,  |.-'.-'");
                $display("        **                        **    (_/    (_/ ,;|.<`");
                $display("        **                        **      \\    ,     ;-`");
                $display("        ****************************       >   \\    /");
                $display("                                          (_,-'`> .'");
                $display("                                               (_,'");
                $display("         Totally has %d errors", err);
                $display("\n");
            end
        end
    endtask

`ifdef syn
    initial $sdf_annotate("./postsim/Top_syn.sdf", Top);
`endif

    initial begin
        $dumpfile("wave.fsdb");
        $dumpvars;
    end

    initial begin
        #(`CYCLE * `MAX) $finish;
    end

endmodule
