// ALU
module alu_design (
  input wire [31:0]A, 
  input wire [31:0]B,
  input wire [3:0]Data_sel,
  output reg [31:0]res
);
  always @(*) begin
    if (Data_sel== 4'b0000) begin
      res=A+B; 
    end
    else if (Data_sel== 4'b0001) begin
        res=A-B; 
    end
    else if (Data_sel== 4'b0010) begin
        res=A & B;
    end
    else if (Data_sel== 4'b0011) begin
        res=A|B; 
    end
    else if (Data_sel== 4'b0100) begin
        res=A^B; 
    end
    else if (Data_sel== 4'b0101) begin
      res=A<<B[4:0];       
    end
    else if (Data_sel== 4'b0110) begin
      res=A>>B[4:0];       
    end
    else if (Data_sel== 4'b0111) begin
       res=(A<B)?1:0;   
    end
    else if (Data_sel== 4'b1000) begin
      res=$unsigned(A<B)?1:0; 
    end
    else if (Data_sel== 4'b1001) begin
      res=A>>B[4:0];   
    end
     else if (Data_sel== 4'b1111) begin
      res=A; 
    end
  end
endmodule