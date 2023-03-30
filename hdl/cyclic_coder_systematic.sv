module cyclic_coder_systematic(
    input logic clk,
    input logic enable,
    input logic in,
    output logic out
);

    logic [3:0] divider = 4'b0000;
    logic [3:0] buffer = 4'b0000;
    logic [3:0] bit_counter = 4'b0000;
    
    wire divider_datapath = divider[0];
    wire buffer_datapath = buffer[0];
    wire feedback = (bit_counter >= 11) ? divider_datapath : 0;
    
    always @(posedge clk)
        if (enable) begin
            bit_counter <= bit_counter + 1'd1;
            if (bit_counter == 4'b1111)
                bit_counter <= 4'd0;
        end
    
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
         end else begin
            divider <= 4'b0000;
            buffer  <= 4'b0000;
        end
    end
    
    assign out = (bit_counter >= 11) ? buffer_datapath : divider_datapath;
        
endmodule