module regfile_test;
    reg [4:0] sr1, sr2, dr;
    reg [31:0] wrData;
    reg write, reset, clk;
    wire [31:0] rdData1, rdData2;
    integer k;
    
    regbank REG (rdData1, rdData2, wrData, sr1, sr2, dr, write, reset, clk);
    
    initial clk=1'b0;

    always #5 clk = ~clk;

    initial
        begin
            $dumpfile("Regfile.vcd");
            $dumpvars(0,regfile_test);
            #1 reset = 1; write =0;
            #5 reset = 0;
        end
    
    initial
        #7
        begin
            for (k=0; k<32; k=k+1)
                dr = k; wrData = 10*k; write = 1;
                #10 write = 0;
        end

        #20
        for (k=0; k<32; k=k+2) //Reading and Displaying some of the registers and checking if they are correct
            begin
                sr1 = k; sr2 = k+1;
                #5;
                $display ("reg[%2d] = %d, reg[%2d] = %d", sr1, rdData1, sr2, rdData2);
            end
            #2000 $finish
            end
endmodule