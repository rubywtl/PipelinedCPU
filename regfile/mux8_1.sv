`timescale 1ns/10ps

module mux8_1(
	output logic out, 
	input logic [7:0] in,
	input logic [2:0] sel
);
	
	logic v0, v1;
 
	mux4_1 m0(.out(v0), .i00(in[0]), .i01(in[1]), .i10(in[2]), .i11(in[3]), .sel0(sel[0]), .sel1(sel[1]));
	mux4_1 m1(.out(v1), .i00(in[4]), .i01(in[5]), .i10(in[6]), .i11(in[7]), .sel0(sel[0]), .sel1(sel[1]));
	mux2_1 m (.out(out), .i0(v0), .i1(v1), .sel(sel[2]));
endmodule
 
module mux8_1_testbench();
	logic [7:0] in;
	logic [2:0] sel;
	logic out;
	
	mux8_1 dut (.out, .in, .sel);
	
//	integer i;
//	initial begin
//		for(i=0; i<8; i++) begin // assign all 8 inputs (0-7)
//			in[i] = i;
//		end
//	end
 
	assign in = 8'b01101110;
	
	integer j;
	initial begin
		for(j=0; j<8; j++) begin // loop through all 8 possible patterns
			{sel[2], sel[1], sel[0]} = j; #100;
		end
	end
endmodule