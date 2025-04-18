`timescale 1ps/1ps
 
module bitwise_alu(A, B, cin, cntrl, result, cout);
    input logic A, B, cin;
    input logic [2:0] cntrl;
    output logic result, cout;
 
    logic adder_r, bw_or_r, bw_and_r, bw_xor_r, realB, inv_b;
 
    not #50 not_b(inv_b, B);
 
    mux2_1 inv_mux(.out(realB), .i0(B), .i1(inv_b), .sel(cntrl[0]));
 
    adder a(.A, .B(realB), .cin(cin), .sum(adder_r), .cout(cout));
   
    and #50 ba(bw_and_r, A, B);
    or #50 bo(bw_or_r, A, B);
    xor #50 bx(bw_xor_r, A, B);
 
    // set patterns 111 and 001 to 0 because you don't care about the outputs
    mux8_1 sel_mux(.out(result), .in({1'b0, bw_xor_r, bw_or_r, bw_and_r,
                                                    adder_r, adder_r, 1'b0, B}), .sel(cntrl));
 
    //mux8_1 sel_mux(.out(result), .in({1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 1'b0}), .sel(cntrl)); // never choses 1, even though that's 100
 
 
endmodule
 
module bitslice_alu_testbench();
    logic A, B, cin;
    logic [2:0] cntrl;
    logic result, cout;
 
    bitslice_alu dut (.*);
    initial begin
        // test 1 (000): B outputs directly
        A = 1'b1;
        B = 1'b1;
        cntrl = 3'b000;
        #10000;
        // test 2 (010): A + B with cout = 1, result = 0
        cin = 1'b0;
        cntrl = 3'b010;
        #10000;
        // test 3 (010): A + B with cout = 0, result = 1
        B = 1'b0;
        #10000;
        // test 4 (011): A - B with cout = 0, result = 1 // I THINK
        cin = 1'b1;
        cntrl = 3'b011;
        #10000;
        // test 5 (100): A & B with result = 0, then result = 1
        cntrl = 3'b100;
        #10000;
        B = 1'b1;
        #10000;
        // test 6 (101): A | B with result = 1, then result = 0
        cntrl = 3'b101;
        #10000;
        A = 1'b0;
        B = 1'b0;
        #10000;
        // test 7 (110): A ^ B with result = 0, then result = 1
        cntrl = 3'b110;
        #10000;
        B = 1'b1;
        #10000;
    end
 
 
endmodule