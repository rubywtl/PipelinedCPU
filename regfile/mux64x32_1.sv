`timescale 1ps/1ps

module mux64x32_1(
	output logic [63:0] out,
	input logic [63:0] in [31:0], // 32 inputs with 64 bits each
	input logic [4:0] sel
);

	generate
   genvar i;
		for (i=0; i<64; i=i+1) begin : registers
			 mux32_1 mux_u(.out(out[i]), .in({in[31][i], in[30][i], in[29][i], in[28][i], in[27][i], in[26][i], in[25][i], in[24][i], in[23][i], 
			 in[22][i], in[21][i], in[20][i], in[19][i], in[18][i], in[17][i], in[16][i], in[15][i], in[14][i], in[13][i], in[12][i], in[11][i], 
			in[10][i], in[9][i], in[8][i], in[7][i], in[6][i], in[5][i], in[4][i], in[3][i], in[2][i], in[1][i], in[0][i]}), .sel);
		end
	endgenerate
	
endmodule