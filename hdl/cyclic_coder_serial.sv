module cyclic_coder_serial(
    input logic clk,
    input logic reset,
    input logic start,
    input logic in,
    output logic out,
    output logic done
);

    reg [3:0] lfsr;
    
    always @(posedge clk)
        if (reset)
            lfsr <= 4'b0;
        else if (start) begin
            lfsr[3] <= in;
            lfsr[2] <= lfsr[3];
            lfsr[1] <= lfsr[2] ^ in;
            lfsr[0] <= lfsr[1] ^ in;
        end
        
    assign out = lfsr[0] ^ in;
    assign done = lfsr == 0;
    
endmodule