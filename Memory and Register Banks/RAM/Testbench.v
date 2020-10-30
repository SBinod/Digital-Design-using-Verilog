module RAM_test;
    reg [9:0] address;
    wire [7:0] data_out;
    reg [7:0] data_in;
    reg write, select;
    integer k, myseed;

    RAM RAM (data_out, data_in, write, select);

    initial
        begin
            for(k=0; k<1023; k=k+1) //Initializing memory
                begin
                    data_in = (k+k) % 256; read = 0; write = 1; select = 1;
                    #2 address = k; write = 0; select = 0;
                end
            repeat (20) //reading data from randomly selected 20 addresses
                begin
                    #2 address = $random(myseed) % 1024;
                    write = 0; select =1;
                    $display ("Address: %5d, Data: %4d", address, data);
                end
        end
    initial myseed = 35;
endmodule