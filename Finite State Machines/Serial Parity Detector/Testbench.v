module test_parity;
    reg clk, x;
    wire z;
    
    parity_gen PAR (X, clk, Z);

    initial
        begin
            $dumpfile("Parity.vcd");
            $dumpbvars(0,test_parity);
            clk = 1'b0;
        end

    always #5 clk = ~clk;

    initial
        begin
            #02 x=0; #10 x=1; #10 x=1; #10 x=1;
            #10 x=0; #10 x=1; #10 x=1; #10 x=0;
            #10 x=0; #10 x=1; #10 x=1; #10 x=0;
            #10 $finish;
        end
endmodule