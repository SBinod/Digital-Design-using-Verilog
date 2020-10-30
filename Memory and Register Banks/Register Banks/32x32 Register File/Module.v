module regbank (rdData1, rdData2, wrData, sr1, sr2, write, clk);
    input clk, write, reset;
    input [4:0] sr1, sr2, dr; //Source and Destination Registers
    input [31:0] wrData;
    output [31:0] rdData1, rdData2;

    reg [31:0] regfile[0:31];

    assign rdData1 = regfile[sr1];
    assign rdData2 = regfile[sr2];

    always @(posedge clk)
        begin
            if (reset)
                begin
                    for (k=0; k<32; k=k+1)
                        regfile[k] = 32'h00000000;
                end
            else
                begin
                    if (write)
                        regfile[dr] <= wrData;
                end
        end

endmodule