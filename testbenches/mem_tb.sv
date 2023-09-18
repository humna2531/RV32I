module mem_tb;
    reg        clk;
    reg  [2:0] addr;
    reg  [31:0] data;
    reg        wr;
    reg  [3:0] masked;
    wire [31:0] r_data;

    // Instantiate the memory module
     data_mem mem (
        .clk(clk),
        .addr(addr),
        .data(data),
        .wr(wr),
        .masked(masked),
        .r_data(r_data)
    );

    // Clock generation
    always #5 clk = ~clk;

    // Test stimulus
    initial begin
        clk     = 0;
        addr    = 0;
        data    = 8'b00001110;
        wr      = 1;
        masked  = 4'b0011;
        
        // Write operation
        #10 wr     = 0;

        // Read operation
        #30 addr   = 0;
        #50 wr     = 0;

        // Finish simulation
        #60 $finish;
    end
      initial begin
        $dumpfiles("data_mem");
        $dumpvars (0,mem_tb);
      end
endmodule
