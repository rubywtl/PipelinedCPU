// Test bench for ALU
`timescale 1ns/10ps
 
// Meaning of signals in and out of the ALU:
 
// Flags:
// negative: whether the result output is negative if interpreted as 2's comp.
// zero: whether the result output was a 64-bit zero.
// overflow: on an add or subtract, whether the computation overflowed if the inputs are interpreted as 2's comp.
// carry_out: on an add or subtract, whether the computation produced a carry-out.
 
// cntrl            Operation                       Notes:
// 000:         result = B                      value of overflow and carry_out unimportant
// 010:         result = A + B
// 011:         result = A - B
// 100:         result = bitwise A & B      value of overflow and carry_out unimportant
// 101:         result = bitwise A | B      value of overflow and carry_out unimportant
// 110:         result = bitwise A XOR B    value of overflow and carry_out unimportant
 
module alustim();
 
    parameter delay = 100000;
 
    logic       [63:0]  A, B;
    logic       [2:0]       cntrl;
    logic       [63:0]  result;
    logic                   negative, zero, overflow, carry_out ;

	// our own test variables
	logic       [63:0]  ans;
	logic       [64:0]  ans_longer;
	logic       expected_carry, expected_overflow;
 
    parameter ALU_PASS_B=3'b000, ALU_ADD=3'b010, ALU_SUBTRACT=3'b011, ALU_AND=3'b100, ALU_OR=3'b101, ALU_XOR=3'b110;
   
 
    alu dut (.A, .B, .cntrl, .result, .negative, .zero, .overflow, .carry_out);
 
    // Force %t's to print in a nice format.
    initial $timeformat(-9, 2, " ns", 10);
 
    integer i;
    logic [63:0] test_val;
    initial begin
   
        $display("%t testing PASS_B operations", $time);
        cntrl = ALU_PASS_B;
        for (i=0; i<30; i++) begin
            A = $random(); B = $random();
            #(delay);
            assert(result == B && negative == B[63] && zero == (B == '0))
			else begin
				$error("FAIL: time=%t A=%h B=%h result=%h negative=%b zero=%b", 
					$time, A, B, result, negative, zero);
			end
        end
       
       
        $display("%t testing addition operations", $time);
		cntrl = ALU_ADD;
		for (i = 0; i < 30; i++) begin
			A = $random(); B = $random();
			#(delay);
			ans = A + B;
			ans_longer = {A[63], A} + {B[63], B}; // sign extension

			check_result(A, B, ans, result);
			check_negative(ans, negative);
			check_zero(ans, zero);
			check_overflow_add(A, B, ans, overflow);
			check_carry_add(ans_longer, carry_out);
		end

 
        $display("%t testing subtract operations", $time);
		cntrl = ALU_SUBTRACT;
		for (i = 0; i < 30; i++) begin
			A = $random(); B = $random();
			#(delay);
			ans = A - B;
			ans_longer = {A[63], A} - {B[63], B};

			check_result(A, B, ans, result);
			check_negative(ans, negative);
			check_zero(ans, zero);
			check_overflow_sub(A, B, ans, overflow);
			check_carry_sub(ans_longer, carry_out);
		end

 
        $display("%t testing bitwise_and operations", $time);
        cntrl = ALU_AND;
        for (i=0; i<30; i++) begin
            A = $random(); B = $random();
            #(delay);
			ans = A & B;
			assert(result == ans)
			else begin
				$error("FAIL: time=%t A=%h B=%h result=%h negative=%b zero=%b", 
					$time, A, B, result, negative, zero);
			end
        end
 
        $display("%t testing or operations", $time);
        cntrl = ALU_OR;
        for (i=0; i<30; i++) begin
            A = $random(); B = $random();
            #(delay);
			ans = A | B;
			assert(result == ans)
			else begin
				$error("FAIL: time=%t A=%h B=%h result=%h negative=%b zero=%b", 
					$time, A, B, result, negative, zero);
			end
        end
 
        $display("%t testing xor operations", $time);
        cntrl = ALU_XOR;
        for (i=0; i<30; i++) begin
            A = $random(); B = $random();
            #(delay);
			ans = A ^ B;
			assert(result == ans)
			else begin
				$error("FAIL: time=%t A=%h B=%h result=%h negative=%b zero=%b", 
					$time, A, B, result, negative, zero);
			end
        end
    end

	task check_result(input [63:0] A, B, ans, result);
		if (result != ans)
			$error("X Result mismatch: A=%h B=%h → Expected result=%h, Got result=%h", A, B, ans, result);
		endtask

	task check_negative(input [63:0] ans, input negative);
		if (negative != ans[63])
			$error("X Negative flag incorrect: ans[63]=%b, Expected negative=%b", ans[63], ans[63]);
	endtask

	task check_zero(input [63:0] ans, input zero);
		if (zero != (ans == 64'd0))
			$error("X Zero flag incorrect: ans=%h → Expected zero=%b", ans, (ans == 64'd0));
	endtask

	task check_overflow_add(input [63:0] A, B, ans, input overflow);
		logic expected;
		// A[63] = 1, B[63] = 1, ans[63] = 0, means the 2nd to last carry-out is 0 and the last carry-out is 1
		// A[63] = 0, B[63] = 0, ans[63] = 1, means the 2nd to last carry-out is 1 and the last carry-out is 0
		// --> overflow = Cn xor Cn-1
		expected = (~A[63] & ~B[63] & ans[63]) | (A[63] & B[63] & ~ans[63]);
		if (overflow != expected)
			$error("X Overflow (ADD) incorrect: A[63]=%b B[63]=%b ans[63]=%b Expected overflow=%b", A[63], B[63], ans[63], expected);
	endtask

	task check_overflow_sub(input [63:0] A, B, ans, input overflow);
		logic expected;
		expected = ( A[63] & ~B[63] & ~ans[63]) | (~A[63] &  B[63] &  ans[63]);
		if (overflow != expected)
			$error("X Overflow (SUB) incorrect: A[63]=%b B[63]=%b ans[63]=%b Expected overflow=%b", A[63], B[63], ans[63], expected);
	endtask

	task check_carry_add(input [64:0] ans_longer, input carry_out);
		if (carry_out != ans_longer[64])
			$error("X Carry-out (ADD) incorrect: carry_out=%b Expected carry_out=%b", carry_out, ans_longer[64]);
	endtask

	task check_carry_sub(input [64:0] ans_longer, input carry_out);
		if (carry_out != ~ans_longer[64])
			$error("X Carry-out (SUB) incorrect: carry_out=%b Expected carry_out=%b", carry_out, ~ans_longer[64]);
	endtask	

endmodule

