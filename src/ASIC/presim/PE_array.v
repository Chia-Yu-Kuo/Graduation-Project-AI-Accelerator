`include "Define.v"

module PE_array (
    clk,
    rst,
    ifmap_pe_wen,
    weight_pe_wen,  //28 can write each time
    reg_pe_clear,
    i_buff_w_data,
    i_buff_w_addr,
    i_buff_wen,
    i_buff_clear,  //one can write each time
    w_buff_w_data,
    w_buff_w_addr,
    w_buff_wen,
    w_buff_clear,  //one can write each time
    align_conv1,
    align_conv2,
    p_buff_r_addr,
    p_buff_r_data,
    p_buff_wen,
    fc_reg_in,
    fc_reg_out,
    fc_reg_wen,
    fc_reg_clear
);
    input clk, rst;
    input ifmap_pe_wen, weight_pe_wen, reg_pe_clear;
    input i_buff_wen, w_buff_wen, p_buff_wen, fc_reg_wen;
    input i_buff_clear, w_buff_clear, fc_reg_clear;
    input [`ifmap_wid-1:0] i_buff_w_data;
    input [`ifmap_buff_wid-1:0] i_buff_w_addr;
    input [`weight_wid-1:0] w_buff_w_data;
    input [`weight_buff_wid-1:0] w_buff_w_addr;
    input align_conv1, align_conv2;
    input [`psum_buff_wid-1:0] p_buff_r_addr;
    input [`psum_wid-1:0] fc_reg_in;
    output [`psum_wid-1:0] p_buff_r_data;
    output reg [`psum_wid-1:0] fc_reg_out;

    wire [  `psum_wid-1:0] psum_array [  0:`psum_buff_size-1];  //betwen vec and buff

    reg  [ `ifmap_wid-1:0] ifmap_buff [ 0:`ifmap_buff_size-1];  //3*28
    reg  [`weight_wid-1:0] weight_buff[0:`weight_buff_size-1];  //3*28
    reg  [  `psum_wid-1:0] psum_buff  [  0:`psum_buff_size-1];  //28

    integer i1, i2, i3;
    //buff 
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            for (i1 = 0; i1 < `ifmap_buff_size; i1 = i1 + 1) begin
                ifmap_buff[i1] <= 'd0;
            end
            for (i2 = 0; i2 < `weight_buff_size; i2 = i2 + 1) begin
                weight_buff[i2] <= 'd0;
            end
            for (i3 = 0; i3 < `psum_buff_size; i3 = i3 + 1) begin
                psum_buff[i3] <= 'd0;
            end
            fc_reg_out <= 'd0;
        end else begin
            if (i_buff_clear) begin
                for (i1 = 0; i1 < `ifmap_buff_size; i1 = i1 + 1) begin
                    ifmap_buff[i1] <= 'd0;
                end
            end else if (i_buff_wen) begin  //when sort wen need 0
                ifmap_buff[i_buff_w_addr] <= i_buff_w_data;
            end

            if (w_buff_clear) begin
                for (i2 = 0; i2 < `weight_buff_size; i2 = i2 + 1) begin
                    weight_buff[i2] <= 'd0;
                end
            end else if (w_buff_wen) begin  //when sort wen need 0
                weight_buff[w_buff_w_addr] <= w_buff_w_data;
            end
            if (align_conv1) begin  //CONV1 sort
                ifmap_buff[0]   <= ifmap_buff[0];
                ifmap_buff[1]   <= ifmap_buff[1];
                ifmap_buff[3]   <= ifmap_buff[1];
                ifmap_buff[2]   <= ifmap_buff[2];
                ifmap_buff[4]   <= ifmap_buff[2];
                ifmap_buff[6]   <= ifmap_buff[2];
                ifmap_buff[5]   <= ifmap_buff[3];
                ifmap_buff[7]   <= ifmap_buff[3];
                ifmap_buff[9]   <= ifmap_buff[3];
                ifmap_buff[8]   <= ifmap_buff[4];
                ifmap_buff[10]  <= ifmap_buff[4];
                ifmap_buff[12]  <= ifmap_buff[4];
                ifmap_buff[11]  <= ifmap_buff[5];
                ifmap_buff[13]  <= ifmap_buff[5];
                ifmap_buff[15]  <= ifmap_buff[5];
                ifmap_buff[14]  <= ifmap_buff[6];
                ifmap_buff[16]  <= ifmap_buff[6];
                ifmap_buff[18]  <= ifmap_buff[6];
                ifmap_buff[17]  <= ifmap_buff[7];
                ifmap_buff[19]  <= ifmap_buff[7];
                ifmap_buff[21]  <= ifmap_buff[7];
                ifmap_buff[20]  <= ifmap_buff[8];
                ifmap_buff[22]  <= ifmap_buff[8];
                ifmap_buff[24]  <= ifmap_buff[8];
                ifmap_buff[23]  <= ifmap_buff[9];
                ifmap_buff[25]  <= ifmap_buff[9];
                ifmap_buff[27]  <= ifmap_buff[9];
                ifmap_buff[26]  <= ifmap_buff[10];
                ifmap_buff[28]  <= ifmap_buff[10];
                ifmap_buff[30]  <= ifmap_buff[10];
                ifmap_buff[29]  <= ifmap_buff[11];
                ifmap_buff[31]  <= ifmap_buff[11];
                ifmap_buff[33]  <= ifmap_buff[11];
                ifmap_buff[32]  <= ifmap_buff[12];
                ifmap_buff[34]  <= ifmap_buff[12];
                ifmap_buff[36]  <= ifmap_buff[12];
                ifmap_buff[35]  <= ifmap_buff[13];
                ifmap_buff[37]  <= ifmap_buff[13];
                ifmap_buff[39]  <= ifmap_buff[13];
                ifmap_buff[38]  <= ifmap_buff[14];
                ifmap_buff[40]  <= ifmap_buff[14];
                ifmap_buff[42]  <= ifmap_buff[14];
                ifmap_buff[41]  <= ifmap_buff[15];
                ifmap_buff[43]  <= ifmap_buff[15];
                ifmap_buff[45]  <= ifmap_buff[15];
                ifmap_buff[44]  <= ifmap_buff[16];
                ifmap_buff[46]  <= ifmap_buff[16];
                ifmap_buff[48]  <= ifmap_buff[16];
                ifmap_buff[47]  <= ifmap_buff[17];
                ifmap_buff[49]  <= ifmap_buff[17];
                ifmap_buff[51]  <= ifmap_buff[17];
                ifmap_buff[50]  <= ifmap_buff[18];
                ifmap_buff[52]  <= ifmap_buff[18];
                ifmap_buff[54]  <= ifmap_buff[18];
                ifmap_buff[53]  <= ifmap_buff[19];
                ifmap_buff[55]  <= ifmap_buff[19];
                ifmap_buff[57]  <= ifmap_buff[19];
                ifmap_buff[56]  <= ifmap_buff[20];
                ifmap_buff[58]  <= ifmap_buff[20];
                ifmap_buff[60]  <= ifmap_buff[20];
                ifmap_buff[59]  <= ifmap_buff[21];
                ifmap_buff[61]  <= ifmap_buff[21];
                ifmap_buff[63]  <= ifmap_buff[21];
                ifmap_buff[62]  <= ifmap_buff[22];
                ifmap_buff[64]  <= ifmap_buff[22];
                ifmap_buff[66]  <= ifmap_buff[22];
                ifmap_buff[65]  <= ifmap_buff[23];
                ifmap_buff[67]  <= ifmap_buff[23];
                ifmap_buff[69]  <= ifmap_buff[23];
                ifmap_buff[68]  <= ifmap_buff[24];
                ifmap_buff[70]  <= ifmap_buff[24];
                ifmap_buff[72]  <= ifmap_buff[24];
                ifmap_buff[71]  <= ifmap_buff[25];
                ifmap_buff[73]  <= ifmap_buff[25];
                ifmap_buff[75]  <= ifmap_buff[25];
                ifmap_buff[74]  <= ifmap_buff[26];
                ifmap_buff[76]  <= ifmap_buff[26];
                ifmap_buff[78]  <= ifmap_buff[26];
                ifmap_buff[77]  <= ifmap_buff[27];
                ifmap_buff[79]  <= ifmap_buff[27];
                ifmap_buff[81]  <= ifmap_buff[27];
                ifmap_buff[80]  <= ifmap_buff[28];
                ifmap_buff[82]  <= ifmap_buff[28];
                ifmap_buff[83]  <= ifmap_buff[29];

                weight_buff[0]  <= weight_buff[0];
                weight_buff[3]  <= weight_buff[0];
                weight_buff[6]  <= weight_buff[0];
                weight_buff[9]  <= weight_buff[0];
                weight_buff[12] <= weight_buff[0];
                weight_buff[15] <= weight_buff[0];
                weight_buff[18] <= weight_buff[0];
                weight_buff[21] <= weight_buff[0];
                weight_buff[24] <= weight_buff[0];
                weight_buff[27] <= weight_buff[0];
                weight_buff[30] <= weight_buff[0];
                weight_buff[33] <= weight_buff[0];
                weight_buff[36] <= weight_buff[0];
                weight_buff[39] <= weight_buff[0];
                weight_buff[42] <= weight_buff[0];
                weight_buff[45] <= weight_buff[0];
                weight_buff[48] <= weight_buff[0];
                weight_buff[51] <= weight_buff[0];
                weight_buff[54] <= weight_buff[0];
                weight_buff[57] <= weight_buff[0];
                weight_buff[60] <= weight_buff[0];
                weight_buff[63] <= weight_buff[0];
                weight_buff[66] <= weight_buff[0];
                weight_buff[69] <= weight_buff[0];
                weight_buff[72] <= weight_buff[0];
                weight_buff[75] <= weight_buff[0];
                weight_buff[78] <= weight_buff[0];
                weight_buff[81] <= weight_buff[0];
                weight_buff[1]  <= weight_buff[1];
                weight_buff[4]  <= weight_buff[1];
                weight_buff[7]  <= weight_buff[1];
                weight_buff[10] <= weight_buff[1];
                weight_buff[13] <= weight_buff[1];
                weight_buff[16] <= weight_buff[1];
                weight_buff[19] <= weight_buff[1];
                weight_buff[22] <= weight_buff[1];
                weight_buff[25] <= weight_buff[1];
                weight_buff[28] <= weight_buff[1];
                weight_buff[31] <= weight_buff[1];
                weight_buff[34] <= weight_buff[1];
                weight_buff[37] <= weight_buff[1];
                weight_buff[40] <= weight_buff[1];
                weight_buff[43] <= weight_buff[1];
                weight_buff[46] <= weight_buff[1];
                weight_buff[49] <= weight_buff[1];
                weight_buff[52] <= weight_buff[1];
                weight_buff[55] <= weight_buff[1];
                weight_buff[58] <= weight_buff[1];
                weight_buff[61] <= weight_buff[1];
                weight_buff[64] <= weight_buff[1];
                weight_buff[67] <= weight_buff[1];
                weight_buff[70] <= weight_buff[1];
                weight_buff[73] <= weight_buff[1];
                weight_buff[76] <= weight_buff[1];
                weight_buff[79] <= weight_buff[1];
                weight_buff[82] <= weight_buff[1];
                weight_buff[2]  <= weight_buff[2];
                weight_buff[5]  <= weight_buff[2];
                weight_buff[8]  <= weight_buff[2];
                weight_buff[11] <= weight_buff[2];
                weight_buff[14] <= weight_buff[2];
                weight_buff[17] <= weight_buff[2];
                weight_buff[20] <= weight_buff[2];
                weight_buff[23] <= weight_buff[2];
                weight_buff[26] <= weight_buff[2];
                weight_buff[29] <= weight_buff[2];
                weight_buff[32] <= weight_buff[2];
                weight_buff[35] <= weight_buff[2];
                weight_buff[38] <= weight_buff[2];
                weight_buff[41] <= weight_buff[2];
                weight_buff[44] <= weight_buff[2];
                weight_buff[47] <= weight_buff[2];
                weight_buff[50] <= weight_buff[2];
                weight_buff[53] <= weight_buff[2];
                weight_buff[56] <= weight_buff[2];
                weight_buff[59] <= weight_buff[2];
                weight_buff[62] <= weight_buff[2];
                weight_buff[65] <= weight_buff[2];
                weight_buff[68] <= weight_buff[2];
                weight_buff[71] <= weight_buff[2];
                weight_buff[74] <= weight_buff[2];
                weight_buff[77] <= weight_buff[2];
                weight_buff[80] <= weight_buff[2];
                weight_buff[83] <= weight_buff[2];

            end else if (align_conv2) begin  //CONV2 sort
                //even PE0~11
                ifmap_buff[0]   <= ifmap_buff[0];
                ifmap_buff[1]   <= ifmap_buff[1];
                ifmap_buff[3]   <= ifmap_buff[1];
                ifmap_buff[2]   <= ifmap_buff[2];
                ifmap_buff[4]   <= ifmap_buff[2];
                ifmap_buff[6]   <= ifmap_buff[2];
                ifmap_buff[5]   <= ifmap_buff[3];
                ifmap_buff[7]   <= ifmap_buff[3];
                ifmap_buff[9]   <= ifmap_buff[3];
                ifmap_buff[8]   <= ifmap_buff[4];
                ifmap_buff[10]  <= ifmap_buff[4];
                ifmap_buff[12]  <= ifmap_buff[4];
                ifmap_buff[11]  <= ifmap_buff[5];
                ifmap_buff[13]  <= ifmap_buff[5];
                ifmap_buff[15]  <= ifmap_buff[5];
                ifmap_buff[14]  <= ifmap_buff[6];
                ifmap_buff[16]  <= ifmap_buff[6];
                ifmap_buff[18]  <= ifmap_buff[6];
                ifmap_buff[17]  <= ifmap_buff[7];
                ifmap_buff[19]  <= ifmap_buff[7];
                ifmap_buff[21]  <= ifmap_buff[7];
                ifmap_buff[20]  <= ifmap_buff[8];
                ifmap_buff[22]  <= ifmap_buff[8];
                ifmap_buff[24]  <= ifmap_buff[8];
                ifmap_buff[23]  <= ifmap_buff[9];
                ifmap_buff[25]  <= ifmap_buff[9];
                ifmap_buff[27]  <= ifmap_buff[9];
                ifmap_buff[26]  <= ifmap_buff[10];
                ifmap_buff[28]  <= ifmap_buff[10];
                ifmap_buff[30]  <= ifmap_buff[10];
                ifmap_buff[29]  <= ifmap_buff[11];
                ifmap_buff[31]  <= ifmap_buff[11];
                ifmap_buff[33]  <= ifmap_buff[11];
                ifmap_buff[32]  <= ifmap_buff[12];
                ifmap_buff[34]  <= ifmap_buff[12];
                ifmap_buff[35]  <= ifmap_buff[13];
                //even
                weight_buff[0]  <= weight_buff[0];
                weight_buff[3]  <= weight_buff[0];
                weight_buff[6]  <= weight_buff[0];
                weight_buff[9]  <= weight_buff[0];
                weight_buff[12] <= weight_buff[0];
                weight_buff[15] <= weight_buff[0];
                weight_buff[18] <= weight_buff[0];
                weight_buff[21] <= weight_buff[0];
                weight_buff[24] <= weight_buff[0];
                weight_buff[27] <= weight_buff[0];
                weight_buff[30] <= weight_buff[0];
                weight_buff[33] <= weight_buff[0];
                weight_buff[1]  <= weight_buff[1];
                weight_buff[4]  <= weight_buff[1];
                weight_buff[7]  <= weight_buff[1];
                weight_buff[10] <= weight_buff[1];
                weight_buff[13] <= weight_buff[1];
                weight_buff[16] <= weight_buff[1];
                weight_buff[19] <= weight_buff[1];
                weight_buff[22] <= weight_buff[1];
                weight_buff[25] <= weight_buff[1];
                weight_buff[28] <= weight_buff[1];
                weight_buff[31] <= weight_buff[1];
                weight_buff[34] <= weight_buff[1];
                weight_buff[2]  <= weight_buff[2];
                weight_buff[5]  <= weight_buff[2];
                weight_buff[8]  <= weight_buff[2];
                weight_buff[11] <= weight_buff[2];
                weight_buff[14] <= weight_buff[2];
                weight_buff[17] <= weight_buff[2];
                weight_buff[20] <= weight_buff[2];
                weight_buff[23] <= weight_buff[2];
                weight_buff[26] <= weight_buff[2];
                weight_buff[29] <= weight_buff[2];
                weight_buff[32] <= weight_buff[2];
                weight_buff[35] <= weight_buff[2];
                //odd PE12~23
                ifmap_buff[36]  <= ifmap_buff[36];
                ifmap_buff[37]  <= ifmap_buff[37];
                ifmap_buff[39]  <= ifmap_buff[37];
                ifmap_buff[38]  <= ifmap_buff[38];
                ifmap_buff[40]  <= ifmap_buff[38];
                ifmap_buff[42]  <= ifmap_buff[38];
                ifmap_buff[41]  <= ifmap_buff[39];
                ifmap_buff[43]  <= ifmap_buff[39];
                ifmap_buff[45]  <= ifmap_buff[39];
                ifmap_buff[44]  <= ifmap_buff[40];
                ifmap_buff[46]  <= ifmap_buff[40];
                ifmap_buff[48]  <= ifmap_buff[40];
                ifmap_buff[47]  <= ifmap_buff[41];
                ifmap_buff[49]  <= ifmap_buff[41];
                ifmap_buff[51]  <= ifmap_buff[41];
                ifmap_buff[50]  <= ifmap_buff[42];
                ifmap_buff[52]  <= ifmap_buff[42];
                ifmap_buff[54]  <= ifmap_buff[42];
                ifmap_buff[53]  <= ifmap_buff[43];
                ifmap_buff[55]  <= ifmap_buff[43];
                ifmap_buff[57]  <= ifmap_buff[43];
                ifmap_buff[56]  <= ifmap_buff[44];
                ifmap_buff[58]  <= ifmap_buff[44];
                ifmap_buff[60]  <= ifmap_buff[44];
                ifmap_buff[59]  <= ifmap_buff[45];
                ifmap_buff[61]  <= ifmap_buff[45];
                ifmap_buff[63]  <= ifmap_buff[45];
                ifmap_buff[62]  <= ifmap_buff[46];
                ifmap_buff[64]  <= ifmap_buff[46];
                ifmap_buff[66]  <= ifmap_buff[46];
                ifmap_buff[65]  <= ifmap_buff[47];
                ifmap_buff[67]  <= ifmap_buff[47];
                ifmap_buff[69]  <= ifmap_buff[47];
                ifmap_buff[68]  <= ifmap_buff[48];
                ifmap_buff[70]  <= ifmap_buff[48];
                ifmap_buff[71]  <= ifmap_buff[49];
                //odd
                weight_buff[36] <= weight_buff[36];
                weight_buff[39] <= weight_buff[36];
                weight_buff[42] <= weight_buff[36];
                weight_buff[45] <= weight_buff[36];
                weight_buff[48] <= weight_buff[36];
                weight_buff[51] <= weight_buff[36];
                weight_buff[54] <= weight_buff[36];
                weight_buff[57] <= weight_buff[36];
                weight_buff[60] <= weight_buff[36];
                weight_buff[63] <= weight_buff[36];
                weight_buff[66] <= weight_buff[36];
                weight_buff[69] <= weight_buff[36];
                weight_buff[37] <= weight_buff[37];
                weight_buff[40] <= weight_buff[37];
                weight_buff[43] <= weight_buff[37];
                weight_buff[46] <= weight_buff[37];
                weight_buff[49] <= weight_buff[37];
                weight_buff[52] <= weight_buff[37];
                weight_buff[55] <= weight_buff[37];
                weight_buff[58] <= weight_buff[37];
                weight_buff[61] <= weight_buff[37];
                weight_buff[64] <= weight_buff[37];
                weight_buff[67] <= weight_buff[37];
                weight_buff[70] <= weight_buff[37];
                weight_buff[38] <= weight_buff[38];
                weight_buff[41] <= weight_buff[38];
                weight_buff[44] <= weight_buff[38];
                weight_buff[47] <= weight_buff[38];
                weight_buff[50] <= weight_buff[38];
                weight_buff[53] <= weight_buff[38];
                weight_buff[56] <= weight_buff[38];
                weight_buff[59] <= weight_buff[38];
                weight_buff[62] <= weight_buff[38];
                weight_buff[65] <= weight_buff[38];
                weight_buff[68] <= weight_buff[38];
                weight_buff[71] <= weight_buff[38];
                //0 
                ifmap_buff[72]  <= 'd0;
                ifmap_buff[73]  <= 'd0;
                ifmap_buff[74]  <= 'd0;
                ifmap_buff[75]  <= 'd0;
                ifmap_buff[76]  <= 'd0;
                ifmap_buff[77]  <= 'd0;
                ifmap_buff[78]  <= 'd0;
                ifmap_buff[79]  <= 'd0;
                ifmap_buff[80]  <= 'd0;
                ifmap_buff[81]  <= 'd0;
                ifmap_buff[82]  <= 'd0;
                ifmap_buff[83]  <= 'd0;
                weight_buff[72] <= 'd0;
                weight_buff[75] <= 'd0;
                weight_buff[78] <= 'd0;
                weight_buff[81] <= 'd0;
                weight_buff[74] <= 'd0;
                weight_buff[77] <= 'd0;
                weight_buff[80] <= 'd0;
                weight_buff[83] <= 'd0;
            end

            if (p_buff_wen) begin
                for (i3 = 0; i3 < `psum_buff_size; i3 = i3 + 1) begin
                    psum_buff[i3] <= psum_array[i3];
                end
            end

            if (fc_reg_clear) begin
                fc_reg_out <= 'd0;
            end else if (fc_reg_wen) begin
                fc_reg_out <= fc_reg_in;
            end
        end
    end

    assign p_buff_r_data = psum_buff[p_buff_r_addr];

    //28*pe_vec
    PE_vec pe_vec0 (
        .clk(clk),
        .rst(rst),
        .ifmap_wen(ifmap_pe_wen),
        .weight_wen(weight_pe_wen),
        .reg_clear(reg_pe_clear),
        .PE1_ifmap(ifmap_buff[0]),
        .PE1_weight(weight_buff[0]),
        .PE2_ifmap(ifmap_buff[1]),
        .PE2_weight(weight_buff[1]),
        .PE3_ifmap(ifmap_buff[2]),
        .PE3_weight(weight_buff[2]),
        .psum(psum_array[0])
    );
    PE_vec pe_vec1 (
        .clk(clk),
        .rst(rst),
        .ifmap_wen(ifmap_pe_wen),
        .weight_wen(weight_pe_wen),
        .reg_clear(reg_pe_clear),
        .PE1_ifmap(ifmap_buff[3]),
        .PE1_weight(weight_buff[3]),
        .PE2_ifmap(ifmap_buff[4]),
        .PE2_weight(weight_buff[4]),
        .PE3_ifmap(ifmap_buff[5]),
        .PE3_weight(weight_buff[5]),
        .psum(psum_array[1])
    );
    PE_vec pe_vec2 (
        .clk(clk),
        .rst(rst),
        .ifmap_wen(ifmap_pe_wen),
        .weight_wen(weight_pe_wen),
        .reg_clear(reg_pe_clear),
        .PE1_ifmap(ifmap_buff[6]),
        .PE1_weight(weight_buff[6]),
        .PE2_ifmap(ifmap_buff[7]),
        .PE2_weight(weight_buff[7]),
        .PE3_ifmap(ifmap_buff[8]),
        .PE3_weight(weight_buff[8]),
        .psum(psum_array[2])
    );
    PE_vec pe_vec3 (
        .clk(clk),
        .rst(rst),
        .ifmap_wen(ifmap_pe_wen),
        .weight_wen(weight_pe_wen),
        .reg_clear(reg_pe_clear),
        .PE1_ifmap(ifmap_buff[9]),
        .PE1_weight(weight_buff[9]),
        .PE2_ifmap(ifmap_buff[10]),
        .PE2_weight(weight_buff[10]),
        .PE3_ifmap(ifmap_buff[11]),
        .PE3_weight(weight_buff[11]),
        .psum(psum_array[3])
    );
    PE_vec pe_vec4 (
        .clk(clk),
        .rst(rst),
        .ifmap_wen(ifmap_pe_wen),
        .weight_wen(weight_pe_wen),
        .reg_clear(reg_pe_clear),
        .PE1_ifmap(ifmap_buff[12]),
        .PE1_weight(weight_buff[12]),
        .PE2_ifmap(ifmap_buff[13]),
        .PE2_weight(weight_buff[13]),
        .PE3_ifmap(ifmap_buff[14]),
        .PE3_weight(weight_buff[14]),
        .psum(psum_array[4])
    );
    PE_vec pe_vec5 (
        .clk(clk),
        .rst(rst),
        .ifmap_wen(ifmap_pe_wen),
        .weight_wen(weight_pe_wen),
        .reg_clear(reg_pe_clear),
        .PE1_ifmap(ifmap_buff[15]),
        .PE1_weight(weight_buff[15]),
        .PE2_ifmap(ifmap_buff[16]),
        .PE2_weight(weight_buff[16]),
        .PE3_ifmap(ifmap_buff[17]),
        .PE3_weight(weight_buff[17]),
        .psum(psum_array[5])
    );
    PE_vec pe_vec6 (
        .clk(clk),
        .rst(rst),
        .ifmap_wen(ifmap_pe_wen),
        .weight_wen(weight_pe_wen),
        .reg_clear(reg_pe_clear),
        .PE1_ifmap(ifmap_buff[18]),
        .PE1_weight(weight_buff[18]),
        .PE2_ifmap(ifmap_buff[19]),
        .PE2_weight(weight_buff[19]),
        .PE3_ifmap(ifmap_buff[20]),
        .PE3_weight(weight_buff[20]),
        .psum(psum_array[6])
    );
    PE_vec pe_vec7 (
        .clk(clk),
        .rst(rst),
        .ifmap_wen(ifmap_pe_wen),
        .weight_wen(weight_pe_wen),
        .reg_clear(reg_pe_clear),
        .PE1_ifmap(ifmap_buff[21]),
        .PE1_weight(weight_buff[21]),
        .PE2_ifmap(ifmap_buff[22]),
        .PE2_weight(weight_buff[22]),
        .PE3_ifmap(ifmap_buff[23]),
        .PE3_weight(weight_buff[23]),
        .psum(psum_array[7])
    );
    PE_vec pe_vec8 (
        .clk(clk),
        .rst(rst),
        .ifmap_wen(ifmap_pe_wen),
        .weight_wen(weight_pe_wen),
        .reg_clear(reg_pe_clear),
        .PE1_ifmap(ifmap_buff[24]),
        .PE1_weight(weight_buff[24]),
        .PE2_ifmap(ifmap_buff[25]),
        .PE2_weight(weight_buff[25]),
        .PE3_ifmap(ifmap_buff[26]),
        .PE3_weight(weight_buff[26]),
        .psum(psum_array[8])
    );
    PE_vec pe_vec9 (
        .clk(clk),
        .rst(rst),
        .ifmap_wen(ifmap_pe_wen),
        .weight_wen(weight_pe_wen),
        .reg_clear(reg_pe_clear),
        .PE1_ifmap(ifmap_buff[27]),
        .PE1_weight(weight_buff[27]),
        .PE2_ifmap(ifmap_buff[28]),
        .PE2_weight(weight_buff[28]),
        .PE3_ifmap(ifmap_buff[29]),
        .PE3_weight(weight_buff[29]),
        .psum(psum_array[9])
    );
    PE_vec pe_vec10 (
        .clk(clk),
        .rst(rst),
        .ifmap_wen(ifmap_pe_wen),
        .weight_wen(weight_pe_wen),
        .reg_clear(reg_pe_clear),
        .PE1_ifmap(ifmap_buff[30]),
        .PE1_weight(weight_buff[30]),
        .PE2_ifmap(ifmap_buff[31]),
        .PE2_weight(weight_buff[31]),
        .PE3_ifmap(ifmap_buff[32]),
        .PE3_weight(weight_buff[32]),
        .psum(psum_array[10])
    );
    PE_vec pe_vec11 (
        .clk(clk),
        .rst(rst),
        .ifmap_wen(ifmap_pe_wen),
        .weight_wen(weight_pe_wen),
        .reg_clear(reg_pe_clear),
        .PE1_ifmap(ifmap_buff[33]),
        .PE1_weight(weight_buff[33]),
        .PE2_ifmap(ifmap_buff[34]),
        .PE2_weight(weight_buff[34]),
        .PE3_ifmap(ifmap_buff[35]),
        .PE3_weight(weight_buff[35]),
        .psum(psum_array[11])
    );
    PE_vec pe_vec12 (
        .clk(clk),
        .rst(rst),
        .ifmap_wen(ifmap_pe_wen),
        .weight_wen(weight_pe_wen),
        .reg_clear(reg_pe_clear),
        .PE1_ifmap(ifmap_buff[36]),
        .PE1_weight(weight_buff[36]),
        .PE2_ifmap(ifmap_buff[37]),
        .PE2_weight(weight_buff[37]),
        .PE3_ifmap(ifmap_buff[38]),
        .PE3_weight(weight_buff[38]),
        .psum(psum_array[12])
    );
    PE_vec pe_vec13 (
        .clk(clk),
        .rst(rst),
        .ifmap_wen(ifmap_pe_wen),
        .weight_wen(weight_pe_wen),
        .reg_clear(reg_pe_clear),
        .PE1_ifmap(ifmap_buff[39]),
        .PE1_weight(weight_buff[39]),
        .PE2_ifmap(ifmap_buff[40]),
        .PE2_weight(weight_buff[40]),
        .PE3_ifmap(ifmap_buff[41]),
        .PE3_weight(weight_buff[41]),
        .psum(psum_array[13])
    );
    PE_vec pe_vec14 (
        .clk(clk),
        .rst(rst),
        .ifmap_wen(ifmap_pe_wen),
        .weight_wen(weight_pe_wen),
        .reg_clear(reg_pe_clear),
        .PE1_ifmap(ifmap_buff[42]),
        .PE1_weight(weight_buff[42]),
        .PE2_ifmap(ifmap_buff[43]),
        .PE2_weight(weight_buff[43]),
        .PE3_ifmap(ifmap_buff[44]),
        .PE3_weight(weight_buff[44]),
        .psum(psum_array[14])
    );
    PE_vec pe_vec15 (
        .clk(clk),
        .rst(rst),
        .ifmap_wen(ifmap_pe_wen),
        .weight_wen(weight_pe_wen),
        .reg_clear(reg_pe_clear),
        .PE1_ifmap(ifmap_buff[45]),
        .PE1_weight(weight_buff[45]),
        .PE2_ifmap(ifmap_buff[46]),
        .PE2_weight(weight_buff[46]),
        .PE3_ifmap(ifmap_buff[47]),
        .PE3_weight(weight_buff[47]),
        .psum(psum_array[15])
    );
    PE_vec pe_vec16 (
        .clk(clk),
        .rst(rst),
        .ifmap_wen(ifmap_pe_wen),
        .weight_wen(weight_pe_wen),
        .reg_clear(reg_pe_clear),
        .PE1_ifmap(ifmap_buff[48]),
        .PE1_weight(weight_buff[48]),
        .PE2_ifmap(ifmap_buff[49]),
        .PE2_weight(weight_buff[49]),
        .PE3_ifmap(ifmap_buff[50]),
        .PE3_weight(weight_buff[50]),
        .psum(psum_array[16])
    );
    PE_vec pe_vec17 (
        .clk(clk),
        .rst(rst),
        .ifmap_wen(ifmap_pe_wen),
        .weight_wen(weight_pe_wen),
        .reg_clear(reg_pe_clear),
        .PE1_ifmap(ifmap_buff[51]),
        .PE1_weight(weight_buff[51]),
        .PE2_ifmap(ifmap_buff[52]),
        .PE2_weight(weight_buff[52]),
        .PE3_ifmap(ifmap_buff[53]),
        .PE3_weight(weight_buff[53]),
        .psum(psum_array[17])
    );
    PE_vec pe_vec18 (
        .clk(clk),
        .rst(rst),
        .ifmap_wen(ifmap_pe_wen),
        .weight_wen(weight_pe_wen),
        .reg_clear(reg_pe_clear),
        .PE1_ifmap(ifmap_buff[54]),
        .PE1_weight(weight_buff[54]),
        .PE2_ifmap(ifmap_buff[55]),
        .PE2_weight(weight_buff[55]),
        .PE3_ifmap(ifmap_buff[56]),
        .PE3_weight(weight_buff[56]),
        .psum(psum_array[18])
    );
    PE_vec pe_vec19 (
        .clk(clk),
        .rst(rst),
        .ifmap_wen(ifmap_pe_wen),
        .weight_wen(weight_pe_wen),
        .reg_clear(reg_pe_clear),
        .PE1_ifmap(ifmap_buff[57]),
        .PE1_weight(weight_buff[57]),
        .PE2_ifmap(ifmap_buff[58]),
        .PE2_weight(weight_buff[58]),
        .PE3_ifmap(ifmap_buff[59]),
        .PE3_weight(weight_buff[59]),
        .psum(psum_array[19])
    );
    PE_vec pe_vec20 (
        .clk(clk),
        .rst(rst),
        .ifmap_wen(ifmap_pe_wen),
        .weight_wen(weight_pe_wen),
        .reg_clear(reg_pe_clear),
        .PE1_ifmap(ifmap_buff[60]),
        .PE1_weight(weight_buff[60]),
        .PE2_ifmap(ifmap_buff[61]),
        .PE2_weight(weight_buff[61]),
        .PE3_ifmap(ifmap_buff[62]),
        .PE3_weight(weight_buff[62]),
        .psum(psum_array[20])
    );
    PE_vec pe_vec21 (
        .clk(clk),
        .rst(rst),
        .ifmap_wen(ifmap_pe_wen),
        .weight_wen(weight_pe_wen),
        .reg_clear(reg_pe_clear),
        .PE1_ifmap(ifmap_buff[63]),
        .PE1_weight(weight_buff[63]),
        .PE2_ifmap(ifmap_buff[64]),
        .PE2_weight(weight_buff[64]),
        .PE3_ifmap(ifmap_buff[65]),
        .PE3_weight(weight_buff[65]),
        .psum(psum_array[21])
    );
    PE_vec pe_vec22 (
        .clk(clk),
        .rst(rst),
        .ifmap_wen(ifmap_pe_wen),
        .weight_wen(weight_pe_wen),
        .reg_clear(reg_pe_clear),
        .PE1_ifmap(ifmap_buff[66]),
        .PE1_weight(weight_buff[66]),
        .PE2_ifmap(ifmap_buff[67]),
        .PE2_weight(weight_buff[67]),
        .PE3_ifmap(ifmap_buff[68]),
        .PE3_weight(weight_buff[68]),
        .psum(psum_array[22])
    );
    PE_vec pe_vec23 (
        .clk(clk),
        .rst(rst),
        .ifmap_wen(ifmap_pe_wen),
        .weight_wen(weight_pe_wen),
        .reg_clear(reg_pe_clear),
        .PE1_ifmap(ifmap_buff[69]),
        .PE1_weight(weight_buff[69]),
        .PE2_ifmap(ifmap_buff[70]),
        .PE2_weight(weight_buff[70]),
        .PE3_ifmap(ifmap_buff[71]),
        .PE3_weight(weight_buff[71]),
        .psum(psum_array[23])
    );
    PE_vec pe_vec24 (
        .clk(clk),
        .rst(rst),
        .ifmap_wen(ifmap_pe_wen),
        .weight_wen(weight_pe_wen),
        .reg_clear(reg_pe_clear),
        .PE1_ifmap(ifmap_buff[72]),
        .PE1_weight(weight_buff[72]),
        .PE2_ifmap(ifmap_buff[73]),
        .PE2_weight(weight_buff[73]),
        .PE3_ifmap(ifmap_buff[74]),
        .PE3_weight(weight_buff[74]),
        .psum(psum_array[24])
    );
    PE_vec pe_vec25 (
        .clk(clk),
        .rst(rst),
        .ifmap_wen(ifmap_pe_wen),
        .weight_wen(weight_pe_wen),
        .reg_clear(reg_pe_clear),
        .PE1_ifmap(ifmap_buff[75]),
        .PE1_weight(weight_buff[75]),
        .PE2_ifmap(ifmap_buff[76]),
        .PE2_weight(weight_buff[76]),
        .PE3_ifmap(ifmap_buff[77]),
        .PE3_weight(weight_buff[77]),
        .psum(psum_array[25])
    );
    PE_vec pe_vec26 (
        .clk(clk),
        .rst(rst),
        .ifmap_wen(ifmap_pe_wen),
        .weight_wen(weight_pe_wen),
        .reg_clear(reg_pe_clear),
        .PE1_ifmap(ifmap_buff[78]),
        .PE1_weight(weight_buff[78]),
        .PE2_ifmap(ifmap_buff[79]),
        .PE2_weight(weight_buff[79]),
        .PE3_ifmap(ifmap_buff[80]),
        .PE3_weight(weight_buff[80]),
        .psum(psum_array[26])
    );
    PE_vec pe_vec27 (
        .clk(clk),
        .rst(rst),
        .ifmap_wen(ifmap_pe_wen),
        .weight_wen(weight_pe_wen),
        .reg_clear(reg_pe_clear),
        .PE1_ifmap(ifmap_buff[81]),
        .PE1_weight(weight_buff[81]),
        .PE2_ifmap(ifmap_buff[82]),
        .PE2_weight(weight_buff[82]),
        .PE3_ifmap(ifmap_buff[83]),
        .PE3_weight(weight_buff[83]),
        .psum(psum_array[27])
    );

endmodule
