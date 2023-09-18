module controlunit_tb ();
   reg [6:0]  opcode;
   reg [2:0]  func3;
   reg        func7;
   wire       reg_write,branch,store,load,mem_reg,opB;
   wire [0:1] imm_sel,next_sel,opA;
   wire [3:0] ALU_C;

   control_unit test (
       .opcode(opcode),
       .func3(func3),
       .func7(func7),
       .reg_write(reg_write),
       .branch(branch),
       .store(store),
       .load(load),
       .mem_reg(mem_reg),
       .opB(opB),
       .imm_sel(imm_sel),
       .next_sel(next_sel),
       .opA(opA),
       .ALU_C(ALU_C)
   );

   initial begin
    opcode<=7'b0100001;
    func3<=3'b001;
    func7<=1'b0;
    #2;
    #2;
    #2;
    opcode<=  7'b0010111 ;
    #2;
    #2;
    #2;
    opcode<=  7'b0000011 ;
    #2;
    #2;
    #2;
    $finish();
   end

   initial begin
     $dumpfile("control_unit.vcd");
     $dumpvars(0,controlunit_tb);
   end

endmodule