
module top_tb();
  reg clk;
  reg reset;


  topmodule top_inst (
    .clk(clk),
    .reset(reset)
  );

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    reset = 1; 
    #10 reset = 0; 
  end

  initial begin
    $dumpfile("topmodule.vcd");
    $dumpvars(0,top_tb);
  end
endmodule
