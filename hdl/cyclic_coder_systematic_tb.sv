module cyclic_coder_systematic_tb();

    logic clk;
    logic enable;
    logic reset;
    logic in;
    logic out;
    
    initial begin
        clk = 0;
        in = 0;
        forever #5 clk = ~clk;
    end
    
    cyclic_coder_systematic uut(clk, enable, reset, in, out);
    
    initial begin
        #1 reset = 1; #10
        reset = 0; #10
        enable = 1; #10
        
        // Тест 11111000001
        // Должно кодироваться в x^14+x^13+x^12+x^10+x^6+x^4+x+1 = 11101001010011
        
        /*in = 1; #10
        in = 1; #10
        in = 1; #10
        in = 1; #10
        in = 1; #10
        in = 0; #10
        in = 0; #10
        in = 0; #10
        in = 0; #10
        in = 0; #10
        in = 1; #10
        in = 0; #10
        in = 0; #10
        in = 0; #10
        in = 0; #10
        in = 0; #10
        in = 0; #10
        in = 0; #10
        in = 0;
        $stop;*/
        
        in = 0; #10
        in = 0; #10
        in = 0; #10
        in = 0; #10
        in = 0; #10
        in = 0; #10
        in = 0; #10
        in = 1; #10
        in = 0; #10
        in = 1; #10
        in = 0; #10
        in = 0; #10
        in = 0; #10
        in = 0; #10
        in = 0; #10
        in = 0; #10
        in = 0; #10
        in = 0; #10
        in = 0;
        $stop;
    end
    
    always @(posedge clk)
        #2 $write(out);
endmodule