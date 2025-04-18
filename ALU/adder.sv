`timescale 1ps/1ps
module adder (
    input  logic A, B,
    input logic cin,
    output logic sum,
    output logic cout
);
    logic a_and_b, b_and_c, a_and_c, a_xor_b;

    // full adder logic
    // --> assign sum = A xor B xor cin
    // --> assign cout = A*B + B*Cin + A * cin
    and #50 a1(a_and_b, A, B);
    and #50 a2(b_and_c, B, cin);
    and #50 a3(a_and_c, A, cin);
    or #50 o1(cout, a_and_b, b_and_c, a_and_c);

    xor #50 x1(a_xor_b, A, B);
    xor #50 x2(sum, a_xor_b, cin);

endmodule
 
 
module adder_testbench();
    logic A, B, cin, sum, cout;
    adder dut(.*);

    initial begin
        A = 0;
        B = 0;
        cin = 0; #1000;

        A = 1;
        B = 0;
        cin = 0; #1000;

        A = 0;
        B = 1;
        cin = 0; #1000;

        A = 1;
        B = 1;
        cin = 0; #1000;

        A = 0;
        B = 0;
        cin = 1; #1000;

        A = 1;
        B = 0;
        cin = 1; #1000;

        A = 0;
        B = 1;
        cin = 1; #1000;

        A = 1;
        B = 1;
        cin = 1; #1000;

    end
 
endmodule