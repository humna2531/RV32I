module branch_tb();
    reg [31:0] A ;
    reg [31:0] B ;
    reg       enb;
    reg [2:0] fun3;
    wire      res;


    branch test(
        .A(A),
        .B(B),
        .enb(enb),
        .fun3(fun3),
        .res(res)
    );

    initial begin
        enb=1;
        fun3=3'b0;
        A=32'b0;
        B=32'b0;
        #1;
        enb=1;
        fun3=3'b001;
        A=32'b00000000000100101000001010010011;
        B=32'b00000000000000000000000000001100;
        #1;
        #1;
        enb=1;
        fun3=3'b010;
        A=32'b00000000000100101000001010010011;
        B=32'b00000000000000000000000110001100;
        #1;
        $finish();
    end

    initial begin
      $dumpfile ("branch.vcd");
      $dumpvars (0,branch_tb);
    end

    
endmodule