module parity_gen (x, clock, z);
    input x, clock;
    output reg z;
    reg even_odd;
    parameter EVEN=0, ODD=1;

    always @(posedge clock)
        case (even_odd)
            EVEN: even_odd <= x ? ODD:EVEN;
            ODD : even_odd <= x ? EVEN:ODD; //if x=1 then z=0
            default: even_odd <= EVEN;
        endcase

    always @(even_odd)
        case (even_odd)
            EVEN: z = 0; 
            ODD : z = 1
        endcase
endmodule