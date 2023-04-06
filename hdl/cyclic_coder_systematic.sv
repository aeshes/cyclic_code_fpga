module cyclic_coder_systematic(
    input logic clk,
    input logic enable,
    input logic reset,
    input logic in,
    output logic out
);

    logic [3:0] divider;
    logic [3:0] buffer;
    logic [3:0] bit_counter;
    
    wire divider_datapath = divider[0];
    wire buffer_datapath = buffer[0];
    wire feedback = (bit_counter >= 11) ? divider_datapath : 0;
    
    always @(posedge clk)
        if (reset) begin
            divider <= '0;
            buffer  <= '0;
            bit_counter <= '0;
        end
        else if (enable && (bit_counter + 1) == 4'b1111)
            bit_counter <= '0;
        else
            bit_counter <= bit_counter + 1;
    
    always @(posedge clk) begin
        if (enable) begin
             divider <= { in ^ feedback, divider[3] ^ feedback, divider[2:1] };
             buffer  <= { in, buffer[3:1] };
        end
    end
    
    assign out = (bit_counter >= 11) ? buffer_datapath : divider_datapath;
        
endmodule