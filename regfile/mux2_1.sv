`timescale 1ps/1ps

module mux2_1(out, i0, i1, sel);
	output logic out;
	input logic i0, i1, sel;
	
	logic out0, out1, inv_sel;
	
	// assign out = (i1 & sel) | (i0 & ~sel); CORRECT CODE, down below is split up code
	not #50 n1(inv_sel, sel); 
	and #50 a0(out0, i0, inv_sel);
	and #50 a1(out1, i1, sel);
   or #50 o0(out, out0, out1);	
endmodule
 
module mux2_1_testbench();
	logic i0, i1, sel;
	logic out;
 
	mux2_1 dut(.out, .i0, .i1, .sel);
 
	initial begin
		sel=0; i0=1'b0; i1=1'b1; #150;
		sel=1; #150;
		i0=1'b1; i1=1'b0; #150;
		sel=0; #150; 
	end
	
endmodule