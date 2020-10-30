module test_mips32;
    reg clk1, clk2;
    integer k;

    pipe_MIPS32 MYPIPE (clock1, clock2);

    inital
        begin
            clock1 = 0; clock2 = 0;
            repeat (20)
                begin
                    #5 clock1 = 1; #5 clock1 = 0;
                    #5 clock2 = 1; #5 clock2 = 0;
                end
        end

    initial
        begin
            for (k=0; k<31; k=k+1)
                MYPIPE.Reg[k] = k;

            MYPIPE.Mem[0] = 32'h28010078; //ADDI R1,R0,120
            MYPIPE.Mem[1] = 32'h0c631800; //  OR R3,R3,R3 (Dummy Instruction)
            MYPIPE.Mem[2] = 32'h20220000; //  LW R2,0 (R1)
            MYPIPE.Mem[3] = 32'h0c631800; //  OR R3,R3,R3 (Dummy Instruction)
            MYPIPE.Mem[4] = 32'h2842002d; //ADDI R2,R2,45
            MYPIPE.Mem[5] = 32'h0c631800; //  OR R3,R3,R3 (Dummy Instruction)
            MYPIPE.Mem[6] = 32'h24220001; //  SW R2,1 (R1) 
            MYPIPE.Mem[7] = 32'hfc000000; // HLT

            MYPIPE.Mem[120] = 85;

            MYPIPE.HALTED = 0;
            MYPIPE.PC = 0;
            MYPIPE.TAKEN_BRANCH = 0;

            #500
            /*Displaying contents of memory after sufficient delay*/
            $display ("Mem[120]: %4d \nMem[121]: %4d", MYPIPE.Mem[120], MYPIPE.Mem[121]);
        end

    initial
        begin
            $dumpfile ("Processor_II.vcd");
            $dumpvars (0, test_mips32_II);
            #600 $finish;
        end

endmodule