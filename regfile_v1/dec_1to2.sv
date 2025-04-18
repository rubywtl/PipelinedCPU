// 1 to 2 decoder

`timescale 1ps/1ps
 
module dec_1to2(out, in);
	output  logic [1:0]   out;
	input   logic         in;
	
	// out[1] = in;
	// out[0] = ~in;
	
	// buffer to make sure the output signals happen at the same time 
	and #50 a0(out[1], in, 1'b1);
	not #50 n0(out[0], in);
	
endmodule
 
 
module dec_1to2_testbench();
	logic [1:0]out;
	logic in;
	dec_1to2 dut(.*);
	initial begin
        in = 0; #1000; // decoder output should be 01
        in = 1; #1000; // decoder output should be 10
 
        $finish;
    end
endmodule