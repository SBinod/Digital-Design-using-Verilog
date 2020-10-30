module Pipe_Test;

    wire [15:0] F;
    reg [3:0] rs1, rs2, rd, func;
    reg [7:0] addr;
    reg clk1, clk2;
    integer k;

    pipe MYPIPE (z, rs1, rs2, rd, func, addr, clk1, clk2);

    /*Generating two phase clock*/
    initial 
        begin
            clk = 0; clk2 = 0;
            repeat (20)
                begin
                    #5 clk1 = 1; #5 clk1 = 0;
                    #5 clk2 = 1; #5 clk2 = 0;
                end
        end

    /*Initialize registers*/
    initial
        for (k=0; k<16; k=k+1)
            MYPIPE.regbank[k] = k; /*as regbank is not accessible directly as a parameter*/

    initial
        begin
            #5  rs1 = 03; rs2 = 5; rd = 10; func = 00; addr = 125;
            #20 rs1 = 03; rs2 = 8; rd = 12; func = 02; addr = 126;
            #20 rs1 = 10; rs2 = 5; rd = 14; func = 01; addr = 128; 
            /*since we have already modified register 10 (rd=10) earlier in 1st step hence in 3rd step we get modified vaue of register number 10*/
            #20 rs1 = 07; rs2 = 3; rd = 13; func = 11; addr = 127;
            
            /*Displaying Memory contents*/
            #60 for(k=125; k<129; k=k+1)
                    $display("Mem[%3d] = %3d", k, MYPIPE.mem[k]);
        end

    initial
        begin
            $dumpfile("Pipeline.vcd");
            $dumpbvars(0,Pipe_Test);
            $monitor("Time: %3d, F: %3d", $time, Z);
            #300 $finish;
        end

endmodule