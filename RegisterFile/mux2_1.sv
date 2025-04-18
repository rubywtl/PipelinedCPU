`timescale 10ps/1fs
module mux2_1(out, i0, i1, sel);
	output logic out;
	input logic i0, i1, sel;
	wire v0, v1, n0;
	
	// assign out = (i1 & sel) | (i0 & ~sel); CORRECT CODE, down below is split up code
	
	and #5 a0 (v0, i1, sel);
	not #5 n1 (n0, sel); 
	and #5 a1 (v1, i0, n0);
   or #5 o0 (out, v0, v1);	
	
endmodule

`timescale 10ps/1fs
module mux2_1_testbench();
	logic i0, i1, sel;
	logic out;
 
	mux2_1 dut (.out, .i0, .i1, .sel);
 
	initial begin
		sel=0; i0=0; i1=0; #1000;
		sel=0; i0=0; i1=1; #1000;
		sel=0; i0=1; i1=0; #1000;
		sel=0; i0=1; i1=1; #1000;
		sel=1; i0=0; i1=0; #1000;
		sel=1; i0=0; i1=1; #1000;
		sel=1; i0=1; i1=0; #1000;
		sel=1; i0=1; i1=1; #1000; 
	end
endmodule