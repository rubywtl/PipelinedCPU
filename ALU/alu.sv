`timescale 1ps/1ps
module alu(A, B, cntrl, result, negative, zero, overflow, carry_out);
 
    input logic [63:0] A;
    input logic [63:0] B;
    input logic [2:0] cntrl;
   
    output logic [63:0] result;
    output logic negative, zero, overflow, carry_out;
 
    logic [63:0] cout_bus;
   
    bitwise_alu b1(.A(A[0]), .B(B[0]), .cin(cntrl[0]), .cntrl(cntrl), .result(result[0]), .cout(cout_bus[0]));
 
    generate
        genvar i;
        for (i=1; i<64; i=i+1) begin : generate_alus
            bitwise_alu b(.A(A[i]), .B(B[i]), .cin(cout_bus[i-1]), .cntrl(cntrl), .result(result[i]), .cout(cout_bus[i]));
        end
    endgenerate
 
    // overflow flag logic
    // --> overflow = cout_bus[63] xor cout_bus[62]
    xor #50 x1(overflow, cout_bus[63], cout_bus[62]);
 
    // carryout logic
    assign carry_out = cout_bus[63];
 
    // negative flag logic
    // --> negative = result[63]
    assign negative = result[63];
 
    // zero flag logic
    zero_checker zcheck(result[63:0], zero);
 
endmodule