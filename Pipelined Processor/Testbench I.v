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

            MYPIPE.Mem[0] = 32'h2801000a; //ADDI R1,R0,10
            MYPIPE.Mem[1] = 32'h28020014; //ADDI R1,R0,20
            MYPIPE.Mem[2] = 32'h28030019; //ADDI R1,R0,25
            MYPIPE.Mem[3] = 32'h0ce77800; //  OR R7,R7,R7 (Dummy Instruction)
            MYPIPE.Mem[4] = 32'h0ce77800; //  OR R7,R7,R7 (Dummy Instruction)
            MYPIPE.Mem[5] = 32'h00222000; // ADD R4,R1,R2
            MYPIPE.Mem[6] = 32'h0ce77800; //  OR R7,R7,R7 (Dummy Instruction)
            MYPIPE.Mem[7] = 32'h00832800; // ADD R5,R4,R3
            MYPIPE.Mem[8] = 32'hfc000000; // HLT

            MYPIPE.HALTED = 0;
            MYPIPE.PC = 0;
            MYPIPE.TAKEN_BRANCH = 0;

            #280
            /*Displaying R0-R5 after sufficient delay*/
            for (k=0; k<6; k=k+1)
                $display ("R%1d - %2d", k, MYPIPE.Reg[k]);
        end

    initial
        begin
            $dumpfile ("Processor_I.vcd");
            $dumpvars (0, test_mips32_I);
            #300 $finish;
        end

endmodule