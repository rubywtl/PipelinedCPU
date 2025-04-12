`timescale 1ps/1ps

module dec_2to4(out, in);
    output logic [3:0] out;
    input  logic [1:0] in;
 
    logic [1:0] dec0_in, dec1_in;
 
    dec_1to2 d0(.out(dec0_in), .in(in[0])); 
    dec_1to2 d1(.out(dec1_in), .in(in[1]));
 
 
    and #50 a0(out[0], dec1_in[0], dec0_in[0]);
    and #50 a1(out[1], dec1_in[0], dec0_in[1]);
    and #50 a2(out[2], dec1_in[1], dec0_in[0]);
    and #50 a3(out[3], dec1_in[1], dec0_in[1]);
endmodule

module dec_2to4_testbench();
	logic [3:0]out;
	logic [1:0]in;
	
	dec_1to2 dut(.*);
	
	initial begin
        in = 2'b00; #1000;
		  in = 2'b01; #1000;
		  in = 2'b10; #1000;
        in = 2'b11; #1000; 

        $stop;
    end
	
endmodule