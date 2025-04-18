`timescale 1ps/1ps

module dec_5to32(write_enable, out, in);

    output logic [31:0] out;
    input logic [4:0] in;
	 input logic write_enable;
	
    // internal logic
    logic [3:0] en4; // enable signal to control the four larger decoders        
    logic [7:0] temp [3:0];  // wires for connecting the decoders
    logic [31:0] dec_out;

    
    dec_2to4 d_enable(.out(en4), .in(in[4:3]));

    // generate 4 x dec_3to8
    genvar i;
    generate
        for (i = 0; i < 4; i++) begin : generate_decoders
            dec_3to8 d(.out(temp[i]), .in(in[2:0]));
        end
    endgenerate

    // use AND gates to gate each temp by en4
    generate
        for (i = 0; i < 4; i++) begin : generate_outputs
            and #50 a0(dec_out[i*8+0], en4[i], temp[i][0]);
            and #50 a1(dec_out[i*8+1], en4[i], temp[i][1]);
            and #50 a2(dec_out[i*8+2], en4[i], temp[i][2]);
            and #50 a3(dec_out[i*8+3], en4[i], temp[i][3]);
            and #50 a4(dec_out[i*8+4], en4[i], temp[i][4]);
            and #50 a5(dec_out[i*8+5], en4[i], temp[i][5]);
            and #50 a6(dec_out[i*8+6], en4[i], temp[i][6]);
            and #50 a7(dec_out[i*8+7], en4[i], temp[i][7]);
        end
    endgenerate
	 
	 generate
        for (i = 0; i < 32; i++) begin : gen_write_en
            and #50(out[i], dec_out[i], write_enable);
        end
    endgenerate
	 
endmodule
 
module dec_5to32_testbench();
	 logic [31:0] out;
    logic [4:0] in;
	 logic write_enable;
	 dec_5to32 dut(.*);
	 initial begin
		// initialize
		write_enable = 0;
		in = 5'b00000; #10000;
		// test 1: check when not enabled, the output signals should all be 0
		//          even when we change the input signal
		in = 5'b00001; #10000;
		write_enable = 1;
		// test 2: test all the possible combinations and check if the results
		// are accurate.
		for(int i = 0; i < 31; i++) begin
			in = i; #10000;
		end
		$finish;
	 end

 
endmodule