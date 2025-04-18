
module mux16_1 (in, sel, out);
	input logic [15:0] in;
	input logic [3:0] sel;
	output logic out;
	
	wire [3:0] w;
	
	mux4_1 m0 (.i00(in[0]), .i01(in[1]), .i10(in[2]), .i11(in[3]), .sel(sel[1:0]), .out(w[0]));
	mux4_1 m1 (.i00(in[4]), .i01(in[5]), .i10(in[6]), .i11(in[7]), .sel(sel[1:0]), .out(w[1]));
	mux4_1 m2 (.i00(in[8]), .i01(in[9]), .i10(in[10]), .i11(in[11]), .sel(sel[1:0]), .out(w[2]));
	mux4_1 m3 (.i00(in[12]), .i01(in[13]), .i10(in[14]), .i11(in[15]), .sel(sel[1:0]), .out(w[3]));
	mux4_1 m4 (.i00(w[0]), .i01(w[1]), .i10(w[2]), .i11(w[3]), .sel(sel[3:2]), .out(out));
	
endmodule

module mux16_1_testbench();
	logic [15:0] in;
	logic [3:0] sel;
	logic out;
	
	mux16_1 dut (.in, .sel, .out);
	
	assign in = 8'b01101110;
	integer j;
	initial begin
		for(j=0; j<16; j++) begin // loop through all 8 possible patterns
			{sel[3], sel[2], sel[1], sel[0]} = j; #1000;
		end
	end
endmodule