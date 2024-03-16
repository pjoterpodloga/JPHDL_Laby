module debounce #(WAIT_TIME = 50)
    (
    input       sw_i,
    input       clk_i,
    output reg  sw_o
    );

    wire debounce_clk;
    
    reg buf1 = 0, buf2 = 0;
    
    integer counter = 0;
    
    div #(100_000) divider (clk_i, 1'b0, debounce_clk);
    
    initial
    begin
        sw_o = 0;
    end
    
    always @ (posedge debounce_clk)
    begin
    
        if (debounce_clk && buf2)
        begin
            counter <= counter + 1;
            
            if (counter == WAIT_TIME)
            begin
                sw_o <= 1;
            end
        end
        else
        begin
            counter <= 0;
            sw_o <= 0;
        end
    
    end
    
    always @ (posedge clk_i)
    begin
        buf1 <= sw_i;
        buf2 <= buf1;
    end
    
endmodule