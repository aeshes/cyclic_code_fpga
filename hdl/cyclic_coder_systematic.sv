module cyclic_coder_systematic(
    input logic clk,
    input logic enable,
    input logic reset,
    input logic in,
    output logic out
);

    reg [3:0] divider;
    reg [3:0] buffer;
    reg [3:0] bit_counter;
    
    wire divider_datapath = divider[0];
    wire buffer_datapath = buffer[0];
    wire feedback = (bit_counter >= 11) ? divider_datapath : 0;
    
    always @(posedge clk)
        if (reset) begin
            divider <= '0;
            buffer  <= '0;
            bit_counter <= '0;
            out <= 0;
        end
        else if (enable && bit_counter == 4'b1111)
            bit_counter <= '0;
        else
            bit_counter <= bit_counter + 1;
    
    always @(posedge clk) begin
        if (enable) begin
             divider[3] <= in ^ feedback;
             divider[2] <= divider[3] ^ feedback;
             divider[1] <= divider[2];
             divider[0] <= divider[1];
             
             buffer[3] <= in;
             buffer[2] <= buffer[3];
             buffer[1] <= buffer[2];
             buffer[0] <= buffer[1];
             
             out = (bit_counter >= 11) ? buffer_datapath : divider_datapath;
         end
    end
        
endmodule