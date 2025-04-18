`timescale 10ps/1fs

module enabled_dff(output logic q, input logic d, reset, clk, en);

  logic not_en, d_keep, d_load, result;

  not #5 n1(not_en, en);
  and #5 a1(d_keep, q, not_en);  // hold old value
  and #5 a2(d_load, d, en);      // allow new value
  or  #5 o1(result, d_keep, d_load);

  D_FF dff_inst (.q(q), .d(result), .reset(reset), .clk(clk));

endmodule


module enabled_dff_tb();
	logic q;
	logic d, reset, clk, en;
	
	enabled_dff dut(
    .q(q),
    .d(d),
    .reset(reset),
    .clk(clk),
    .en(en)
	);
	
	parameter clock_period = 1000;
    initial begin
        clk = 0;
        forever #(clock_period / 2) clk = ~clk;
    end
	 
	 initial begin
		// initialization
		reset = 1; @(posedge clk);
		d = 1; en = 0; @(posedge clk);
		reset = 0; @(posedge clk);
		
		// should not write while enable is 0
		en = 0; @(posedge clk);
		
		// write when enable is 1
		// --> q should change from 0 to 1
		en = 1; @(posedge clk);
		@(posedge clk);
		@(posedge clk);
		@(posedge clk);
		
		$stop;
		
	 end
	

endmodule
