module  alu_tb();
    reg [31:0] A ;
    reg [31:0] B ;
    reg [3:0] Data_sel ;
    wire [31:0] res ;

    alu_design alu(
        .A(A),
        .B(B),
        .Data_sel(Data_sel),
        .res(res)
    );

    initial begin
        A=32'b00000000000000000000000000000010;
        B=32'b11111111111111111111111111111111;
        Data_sel=4'b0011;
        #2;
        #2;
        A=32'b00000000000000000000000000000010;
        B=32'b11111111111111111111111111111111;
        Data_sel=4'b0001;
        #2;
        #2;
        $finish();
    end
    initial begin
      
        $dumpfile("alu_design.vcd");
        $dumpvars(0,alu_tb);
    end

endmodule