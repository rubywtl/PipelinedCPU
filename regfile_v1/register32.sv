`timescale 1ps/1ps

module register32(
	output logic [63:0] out [31:0],
	input logic [31:0] in, // 32 inputs enabled
	input logic [63:0] WriteData,
	input logic clk, reset
);

	generate
   genvar i;
		for (i=0; i<31; i=i+1) begin : registers
			 register reg_u(.write_data(WriteData), .clk, .reset, .write_enable(in[i]), .read_data(out[i][63:0]));
		end
	endgenerate
	
	assign out[31] = 64'b0;
endmodule

//module register32_testbench();
//	logic [63:0] out [31:0],
//	logic [31:0] in, // 32 inputs
//	logic [63:0] WriteData,
//	logic clk, reset
// 
//	muxregister32 dut(.*);
// 
//	initial begin
//		sel=0; i0=1'b0; i1=1'b1; #150;
//		sel=1; #150;
//		i0=1'b1; i1=1'b0; #150;
//		sel=0; #150; 
//	end
//	
//endmodule