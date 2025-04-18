`timescale 1ps/1ps
module zero_checker(input logic[63:0] result, output logic zero);

    // - layer 1 (64->16)
    logic [15:0] layer1;
    logic zero_sub;
	generate
		genvar j;
		for (j=0; j<16; j=j+1) begin : layer1_gen
			or #50 (layer1[j], result[4*j], result[4*j+1], result[4*j+2], result[4*j+3]);
		end
	endgenerate

	// - layer 2 (16->4)
    logic [3:0] layer2;
	generate
		genvar k;
		for (k=0; k<4; k=k+1) begin : layer2_gen
			or #50 (layer2[k], layer1[4*k], layer1[4*k+1], layer1[4*k+2], layer1[4*k+3]);
		end
	endgenerate

    // - layer 3 (4->1)
    or #50 (zero_sub, layer2[0], layer2[1], layer2[2], layer2[3]);
    not #50 (zero, zero_sub);
endmodule

module zero_checker_tb();
    logic [63:0] result;
    logic zero;

    zero_checker dut(.*);

    initial begin
        // check if it is true, when result is 0
        result = 64'b0; #1000;

        // check if it is false, when result is not 0
        result = 64'b1; #1000;
        result = 64'h8000000000000000; #1000;
        result = 64'h8000000000000000; #1000;
        result = 64'hFFFFFFFFFFFFFFFF; #1000;
        result = 64'hAAAAAAAAAAAAAAAA; #1000;
    end
endmodule;