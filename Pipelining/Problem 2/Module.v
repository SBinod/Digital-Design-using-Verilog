module pipe (Zout, rs1, rs2, rd, func, addr, clk1, clk2);

    input [3:0] rs1, rs2, rd, func;
    input [7:0] addr;
    input clk1, clk2; /*Two phase clock*/
    output [15:0] Zout;

    reg [15:0] L12_A, L12_B, L23_Z, L34_Z;
    reg [3:0]  L12_rd, L12_func, L23_rd;
    reg [7:0]  L12_addr, L23_addr, L34_addr;

    reg [15:0] regbank [0:15]; /*Register Bank*/
    reg [15:0] mem [0:255]; /*256*16 Memory*/

    assign Zout = L34_Z;
    
    /*Stage 1*/
    always @(posedge clk1)
        begin
            L12_A     <= #2 regbank[rs1];
            L12_B     <= #2 regbank[rs2];
            L12_rd    <= #2 rd;
            L12_func  <= func;
            L12_addr  <= addr;
        end

    /*Stage 2*/
    always @(negedge clk2)
        begin
            case (func)
                00: L23_Z <= #2 L12_A + L12_B;
                01: L23_Z <= #2 L12_A - L12_B;
                03: L23_Z <= #2 L12_A * L12_B;
                04: L23_Z <= #2 L12_A;
                05: L23_Z <= #2 L12_B;
                06: L23_Z <= #2 L12_A & L12_B;
                07: L23_Z <= #2 L12_A | L12_B;
                08: L23_Z <= #2 L12_A ^ L12_B;
                09: L23_Z <= #2 -L12_A;
                10: L23_Z <= #2 -L12_B;
                11: L23_Z <= #2 L12_A >> 1;
                12: L23_Z <= #2 L12_A << 1;
                default: L23_Z <= #2 16'hxxxx;
            endcase
            L23_rd   <= #2 L12_rd;
            L23_addr <= #2 L12_addr;
        end

    /*Stage 3*/
    always @(posedge clk1)
        begin
            regbank[L23_rd] <= #2 L23_Z;
            L34_Z    <= #2 L23_Z;
            L34_addr <= #2 L23_addr;
        end

    /*Stage 4*/
    always @(negedge clk2)
        begin
            mem[L34_addr] <= #2 L34_Z;
        end

endmodule