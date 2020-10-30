module test_sequence;
    reg clk, x, reset;
    wire z;
    
    seq_detector SEQ (X, clock, reset, Z);

    initial
        begin
            $dumpfile("Sequence.vcd");
            $dumpbvars(0,test_sequence);
            clk = 1'b0; reset = 1'b1;
            #15 reset = 1'b0; //actual operation starts from time 15
        end

    always #5 clk = ~clk;

    initial
        begin
            #12 x=0; #10 x=0; #10 x=1; #10 x=1;
            #10 x=0; #10 x=1; #10 x=1; #10 x=0;
            #10 x=0; #10 x=1; #10 x=1; #10 x=0;
            #10 $finish;
        end
endmodule