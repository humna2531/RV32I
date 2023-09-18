module immgem_tb ();
    reg [31:7] ins;
    reg [31:0] pc;
    wire [31:0] I_type;
    wire [31:0] S_type;
    wire [31:0] SB_type;
    wire [31:0] Uj_type;
    wire [31:0] U_type;

    imm_gen  test (
        .ins(ins),
        .pc(pc),
        .I_type(I_type),
        .S_type(S_type),
        .SB_type(SB_type),
        .Uj_type(Uj_type),
        .U_type(U_type)
    );

    initial begin
          ins=32'b00000000000100101000001010010011;
          pc=32'b00000000000000000000000000001100;
          #2;
          #2;
          #2;
          ins=32'b00000000000111101000111010010011;
          pc=32'b00000000000000000000000001111100;
          #2;
          #2;
          $finish();
    end

    initial begin
        $dumpfile("imm_gen.vcd");
        $dumpvars(0,immgem_tb); 
    end


endmodule