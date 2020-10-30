module Pipe_Test;
    parameter N = 10;
    wire [N-1:0] F;
    reg [N-1:0] A, B, C, D;
    reg clk;

    pipe MYPIPE (A, B, C, D, clk);

    initial clk = 1'b0;

    always #10 clk = ~clk;

    initial
        begin
            #5 A = 10 ; B = 12 ; C = 6 ; D = 3; // F = 75
           #20 A = 10 ; B = 10 ; C = 5 ; D = 3;
           #20 A = 10 ; B = 11 ; C = 1 ; D = 4;
           #20 A = 20 ; B = 10 ; C = 8 ; D = 2;
           #20 A = 08 ; B = 15 ; C = 5 ; D = 0;
        end

    initial
        begin
            $dumpfile("Pipeline.vcd");
            $dumpbvars(0,Pipe_Test);
            $monitor("Time: %d, F: %d", $time, F);
        end
endmodule