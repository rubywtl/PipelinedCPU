// top level moduel
module regfile(
	output logic [63:0] ReadData1, ReadData2,
	input logic [4:0] ReadRegister1, ReadRegister2, WriteRegister, 
	input logic [63:0] WriteData,
	input logic RegWrite, clk
);
	// initialize variables
	logic [63:0][31:0] mux_in; // this comes OUT of the registers and goes IN to the mux
	logic [31:0] decoder_output; // this comes OUT of the decoder and goes IN to the 31 registers (because 32nd one is hard coded to 0)
 
 
	// decoder - transform write
	dec_5to32 decoder(.write_enable(RegWrite), .out(decoder_output), .in(WriteRegister));
 
 
	// 32 64-bit-registers
	// 0~30th reg: read + write
	generate
   genvar i, j;
		for (i=0; i<31; i=i+1) begin : reg_group
		  for (j=0; j<64; j=j+1) begin : register
		  
			 // write individual bits of data into dff
			 // for the output (data read, data stored in the flip flop
			 //   we will first be accessing the column (offset) and then the row (which register we're accessing)
			 
			 enabled_dff endf(.q(mux_in[j][i]), .d(WriteData[j]), .reset(1'b0), .clk(clk), .en(decoder_output[i]));
			 
			 // register reg0(.write_data(WriteData), .clk, .reset(1'b0), .write_enable(decoder_output[i]), .read_data(mux_in[i]));
		  end
		end
	endgenerate
 
	// (31st reg: contains 0)
	// instead of using a register, we can just hardcode it to 0)
	integer m;
	always_comb begin
		for(m=0; m<64; m++) 
			mux_in[m][31] = 0;
	end

 
	// mux for reading data (create TWO 64 bit muxs)
	generate
   genvar p;
		for (p=0; p<64; p=p+1) begin : mux_bits
		  mux32_1 mux1_p(.out(ReadData1[p]), .in(mux_in[p][31:0]), .sel(ReadRegister1[4:0]));
		  //mux32_1 mux2_p(.out(ReadData2[p]), .in(mux_in[p][31:0]), .sel(ReadRegister2[4:0]));
		end
	endgenerate
	
	generate
   genvar h;
		for (h=0; h<64; h=h+1) begin : mux_bits2
		  mux32_1 mux2_h(.out(ReadData2[h]), .in(mux_in[h][31:0]), .sel(ReadRegister2[4:0]));
		end
	endgenerate
	
endmodule
