`timescale 1ps/1ps

module mux32_1(
	output logic out,
	input logic [31:0] in,
	input logic [4:0] sel
);
	logic v0, v1, v2, v3;
	mux8_1 m0(.out(v0), .in(in[7:0]), .sel(sel[2:0]));
	mux8_1 m1(.out(v1), .in(in[15:8]), .sel(sel[2:0]));
	mux8_1 m2(.out(v2), .in(in[23:16]), .sel(sel[2:0]));
	mux8_1 m3(.out(v3), .in(in[31:24]), .sel(sel[2:0]));
	mux4_1 m4(.out(out), .i00(v0), .i01(v1), .i10(v2), .i11(v3), .sel0(sel[3]), .sel1(sel[4]));
endmodule
 
module mux32_1_testbench();
	logic [31:0] in;
	logic	[4:0] sel;
	logic out;
	mux32_1 dut (.out, .in, .sel);
//	integer i;
//	initial begin
//		for(i=0; i<32; i++) begin // assign all 32 inputs (0-31)
//			assign in[i] = i;
//		end
//	end
 
	assign in = 32'b01101101001101011001100011101010;
	integer j;
	initial begin
		for(j=0; j<32; j++) begin // loop through all 32 possible patterns
			{sel[4], sel[3], sel[2], sel[1], sel[0]} = j; #100000;
		end
	end
endmodule