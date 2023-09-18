// REGISTER FILE   
module reg_file
(
  input wire  clk,
  input wire rst,
  input wire [4:0]rs1,
  input wire [4:0]rs2,
  input wire [4:0]rd,
  input wire wen,
  input wire [31:0]wdata,
  output wire [31:0]rdata1,
  output wire [31:0]rdata2
);
  reg [31:0]registers [0:31];

  integer i;
  initial begin
  for (i=0;i<=33;i=i+1)begin
    registers[i]=0;
  end
  registers[2]=32'h00000200;
  end

  always @(posedge clk)begin
    if (rst) begin
        for (i=0;i<=32;i=i+1)
            registers[i]<=0;
        end
    else if (!rst && wen)begin
            if (rd==5'd0)
                registers[0]<=32'h00000000;
            else
                registers[rd]<=wdata;       
        end
  end
  assign rdata1=registers[rs1];
  assign rdata2=registers[rs2];

endmodule