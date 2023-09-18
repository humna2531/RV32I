// TESTING THE REGISTER FILE 
`timescale 1ps/1ps

module reg_tb();
  reg [4:0]rs1;
  reg  [4:0]rs2;
  reg [4:0]rd;
  reg wen;
  reg [31:0] wdata;
  reg clk;
  wire [31:0]rdata1;
  wire [31:0]rdata2;
  
  reg_file file1(
    .rs1(rs1),
    .rs2(rs2),
    .rd(rd),
    .wen(wen),
    .wdata(wdata),
    .clk(clk),
    .rdata1(rdata1),
    .rdata2(rdata2)
  );

  
  initial begin 
    clk=1;
    rs1=5'b00001;
    rs2=5'b00010;
    rd =5'b00101;
    #1;
    wen=1;
    wdata=32'b0000000000000000000000000000011;
    #1;
    rs1=5'b00101;
    rs2=5'b00010;
    rd =5'b01101;
    #1;
    wen=0;
    wdata=32'b00000000000000000000111000001111;
    #1;
    $stop;
    $finish;
  end
  
always 
  begin 
    forever #1 clk = ~clk;
  end

  initial begin
    $dumpfile("reg_file");
    $dumpvars(0,reg_tb);
  end
endmodule