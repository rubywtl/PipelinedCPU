`timescale 10ps/1fs
module dec_3to8(out, in);
    output logic [7:0] out;
    input  logic [2:0] in;

    logic [1:0] top; 
    logic [3:0] low;

    // top bit selects which half
    dec_1to2 d1(.out(top), .in(in[2]));

    // bottom 2 bits go into 2-to-4 decoder
    dec_2to4 d2(.out(low), .in(in[1:0]));

    // combine w and gates
    and #5 a0(out[0], top[0], low[0]);
    and #5 a1(out[1], top[0], low[1]);
    and #5 a2(out[2], top[0], low[2]);
    and #5 a3(out[3], top[0], low[3]);

    and #5 a4(out[4], top[1], low[0]);
    and #5 a5(out[5], top[1], low[1]);
    and #5 a6(out[6], top[1], low[2]);
    and #5 a7(out[7], top[1], low[3]);
	 
endmodule


`timescale 1ns/1ps
module dec_3to8_tb();
	logic [7:0] out;
	logic [2:0] in;
	
	initial begin
		in = 3'b000; #1000
		in = 3'b001; #1000
		in = 3'b010; #1000
		in = 3'b011; #1000
		in = 3'b100; #1000
		in = 3'b101; #1000
		in = 3'b110; #1000
		in = 3'b111; #1000
		
		$finish;
	end

endmodule
