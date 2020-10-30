module test_counter;
    reg clk,clr;
    wire [7:0] out;
    
    counter CNT (clr,clk,out);

    initial clk=1'b0;

    always #5 clk=~clk;

    initial
        begin
            clr=1'b1;
            #15  clr = 1'b0;
            #200 clr = 1'b1;
            #10 $finish;
        end

    inital
        begin
            $dumpfile("Counter.vcd");
            $dumovars(0,test_counter);
            $monitor($time,"count:%d",out);
        end
endmodule