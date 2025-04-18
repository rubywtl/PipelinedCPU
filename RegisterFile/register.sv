// the register module contains 64 d-flipflops 
// and can only be written to when enabled
// but can be read anytime
`timescale 1ns/1ps
module register (
    input  logic [63:0] write_data,  // data in
    input  logic clk, reset,
    input  logic write_enable,
    output logic [63:0] read_data    // data out
);

    genvar i;
    generate
        for (i = 0; i < 64; i = i + 1) begin : dff
            logic not_en, left, right, result;
				
				// assign result 
				//   = write_enable & write_data[i] | ~write_enable & read_data[i]
				
            not #50 n1(not_en, write_enable);
            and #50 a1(left, read_data[i], not_en);
            and #50 a2(right, write_data[i], write_enable);
            or  #50 o1(result, left, right);

            D_FF dff_inst (.clk(clk), .reset(reset), .d(result), .q(read_data[i]));
        end
    endgenerate

endmodule

`timescale 1ns/1ps
module register_testbench();
	logic [63:0] write_data;
	logic [63:0] read_data;
	logic clk, write_enable, reset;
	
	register register(.*);
	
	parameter clock_period = 100;
    initial begin
        clk = 0;
        forever #(clock_period / 2) clk = ~clk;
    end
	 
	 
    initial begin
			
			// initialization
			read_data = 64'b0;
			write_data = 64'b0;
			reset = 1; @(posedge clk);
			reset = 0;repeat(5) @(posedge clk);
			
			// test 1: no write when write is not enabled
			write_enable = 0; @(posedge clk);
			write_data = 64'b1; @(posedge clk);
			
			// test 2: write when enabled
		   write_enable = 1; @(posedge clk);

			
			// test 2-2: when write is not enabled, it should still
			//           maintain the data we just wrote
			repeat(5) @(posedge clk); // repeat clk to see if results
			
			// test 3: reset
			write_enable = 0; @(posedge clk);
			reset = 1; @(posedge clk);
			reset  = 0; @(posedge clk);
			
			// test 4: check read data after write
			write_enable = 1; @(posedge clk);
			write_data = 64'b1;
			
			repeat(5) @(posedge clk);

        $stop;
    end

endmodule
