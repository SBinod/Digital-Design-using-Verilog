module GCD_test;
    reg [15:0] data_in;
    reg clock, start;
    wire done;

    reg [15:0] A,B;

    GCD_DataPath DP (gt, lt, eqm ldA, ldB, sel1, sel2, sel_in, data_in, clock);
    GCD_ControlPath CON (ldA, ldB, sel1, sel2, sel_in, done, clock, lt, get, eq, start);
    
    initial
        begin
            clock = 1'b0;
            #3 start = 1'b1;
            #1000 $finish;
        end

    always #5 clock = ~clock;

    initial
        begin
            #12 data_in = 143;
            #10 data_in = 78;
        end

    initial
        begin
            $monitor ($time, "%d %b", DP.Aout, done);
            $dumpfile ("GCD.vcd");
            $dumpbvars (0,GCD_test);
        end
endmodule