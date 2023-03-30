module cyclic_coder_systematic(
    input logic clk,
    input logic enable,
    input logic in,
    output logic out
);

    logic [3:0] higher_lfsr = 4'b0000;
    logic [3:0] lower_lfsr = 4'b0000;
    logic [3:0] bit_counter = 4'b0000;
    
    wire higher_datapath = higher_lfsr[0];
    wire lower_datapath = lower_lfsr[0];
    wire feedback = (bit_counter > 11) ? higher_datapath : 0;
    
    always @(posedge clk)
        if (enable)
            bit_counter <= bit_counter + 1'h1;
    
    always @(posedge clk) begin
        if (enable) begin
             higher_lfsr[3] <= in ^ feedback;
             higher_lfsr[2] <= higher_lfsr[3] ^ feedback;
             higher_lfsr[1] <= higher_lfsr[2];
             higher_lfsr[0] <= higher_lfsr[1];
             
             lower_lfsr[3] <= in;
             lower_lfsr[2] <= lower_lfsr[3];
             lower_lfsr[1] <= lower_lfsr[2];
             lower_lfsr[0] <= lower_lfsr[1];
         end else begin
            higher_lfsr <= 4'b0000;
            lower_lfsr  <= 4'b0000;
        end
        
        /*if (bit_counter == 4'h0) begin
            higher_lfsr <= 4'b0000;
            lower_lfsr <= 4'b0000;
        end*/
    end
    
    assign out = (bit_counter > 11) ? lower_datapath : higher_datapath;
        
endmodule