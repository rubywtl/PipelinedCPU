// top level moduel
module regfile(
	output logic [63:0] ReadData1, ReadData2,
	input logic [4:0] ReadRegister1, ReadRegister2, WriteRegister, 
	input logic [63:0] WriteData,
	input logic RegWrite, clk
);
	// initialize variables
	logic [63:0] mux_in [31:0]; // this comes OUT of the registers and goes IN to the mux
	logic [31:0] decoder_output; // this comes OUT of the decoder and goes IN to the 31 registers (because 32nd one is hard coded to 0)
	logic reset;

	// decoder - transform write
	dec_5to32 decoder(.write_enable(RegWrite), .out(decoder_output), .in(WriteRegister));

	//create registers
	register32 huge_reg(.out(mux_in), .in(decoder_output), .WriteData, .clk, .reset(reset));

	// create 2 big 64 by 32 by 1 muxs
	mux64x32_1 mux1(.out(ReadData1), .in(mux_in), .sel(ReadRegister1));
	mux64x32_1 mux2(.out(ReadData2), .in(mux_in), .sel(ReadRegister2));		

endmodule