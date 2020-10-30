module GCD_ControlPath (ldA, ldB, sel1, sel2, sel_in, done, clock, lt, gt, eq, start);
    input clock, lt, gt, eq, start;
    output ldA, ldB, sel1, sel2, sel_in, done;
    reg [2:0] state, next_state;
    parameter S0=3'b000, S1=3'b001, S2=3'b010, S3=3'b011, S4=3'b100;

    always @(posedge clock)
        begin
            state <= next_state;
        end

    always @(state)
        begin
            case (state)
                S0: begin sel_in=1; ldA=1; ldB=0; done =0; end
                S1: begin sel_in=1; ldA=0; ldB=1; end
                S2: if (eq) begin done=1; next_state=S5; end
                    else if (lt) begin
                                     sel1=1; sel2=0; sel_in=0; next_state=S3;
                                     #1 ldA=0; ldB=1;
                                 end
                    else if (gt) begin
                                     sel1=0; sel2=1; sel_in=0; next_state=S4;
                                     #1 ldA=1; ldB=0;
                                 end
                S3: if (eq) begin done=1; next_state=S5; end
                    else if (lt) begin
                                     sel1=1; sel2=0; sel_in=0; next_state=S3;
                                     #1 ldA=0; ldB=1;
                                 end
                    else if (gt) begin
                                     sel1=0; sel2=1; sel_in=0; next_state=S4;
                                     #1 ldA=1; ldB=0;
                                 end
                S4: if (eq) begin done=1; next_state=S5; end
                    else if (lt) begin
                                     sel1=1; sel2=0; sel_in=0; next_state=S3;
                                     #1 ldA=0; ldB=1;
                                 end
                    else if (gt) begin
                                     sel1=0; sel2=1; sel_in=0; next_state=S4;
                                     #1 ldA=1; ldB=0;
                                 end
                S5: begin
                        done=1; sel1=0; sel2=0; ldA=0;
                        ldB=0; next_state=S5;
                    end
                default: begin ldA=0; ldB=0; next_state=S0; end
            endcase
        end
endmodule