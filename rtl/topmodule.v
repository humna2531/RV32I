`include "alu_design.v"
`include "control_unit.v"
`include "imm_gen.v"
`include "reg_file.v"
`include "branch.v"
`include "inst_mem.sv"
`include "data_mem.sv"
module topmodule(
    input wire clk,
    input wire reset,
    output  wire [31:0] data
);

  wire [31:0]inst;
  wire [31:0]A;
  wire [31:0]B;
  wire [31:0]res;
  reg  [31:0] PC=32'b0;
  wire [31:0]I_type;
  wire [31:0]S_type;
  wire [31:0]SB_type;
  wire [31:0]U_type;
  wire [31:0]Uj_type;
  wire [31:0]JALR;
  wire branch_result;
  wire load;
  wire mem_reg;
  wire [3:0]ALU_C;
  wire [31:0]branch_PC;
  wire reg_write;
  wire b_enb;
  wire [1:0]next_sel;
  wire [1:0]imm_sel;
  wire [1:0]A_sel;
  wire [31:0]a1;
  wire B_sel;
  wire [31:0]b1;
  wire [31:0]b2;
  wire [31:0] r_data;
  wire wr ;
  
    alu_design  alu_top (
        .A(A),
        .B(B),
        .Data_sel(ALU_C),
        .res(res)
    );

    branch branch_top (
        .A(A),
        .B(B),
        .enb( b_enb),
        .fun3(inst[14:12]),
        .res(branch_result)
    );

    control_unit control_top  (
       .opcode(inst[6:0]),
       .func3(inst[14:12]),
       .func7(inst[30]),
       .reg_write(reg_write),
       .branch(b_enb),
       .store(wr),
       .load(load),
       .mem_reg(mem_reg),
       .opB(B_sel),
       .imm_sel(imm_sel),
       .next_sel(next_sel),
       .opA(A_sel),
       .ALU_C(ALU_C)
    );

       imm_gen immgen_top (
        .ins(inst[31:7]),
        .pc(PC),
        .I_type(I_type),
        .S_type(S_type),
        .SB_type(SB_type),
        .Uj_type(Uj_type),
        .U_type(U_type)
    );

       reg_file reg_top (
        .rs1(inst[19:15]),
        .rs2(inst[24:20]),
        .rd(inst[11:7]),
        .wen(reg_write),
        .wdata(data),
        .clk(clk),
        .rdata1(a1),
        .rdata2(b1)
    );

       data_mem data_top (
        .clk(clk),
        .addr(res[13:2]),
        .data(b1),
        .wr(wr),
        .masked(res[31:30]),
        .r_data(r_data)
    );
      
      inst_mem insmem_top(
        .clk(clk),
        .wr(wr),
        .addr(PC[13:2]),
        .data(data),
        .masked(res[31:30]),
        .r_data(inst)
      );


          
  always @(posedge clk ) begin
    if (reset==0) begin
      PC <= (next_sel == 2'b00) ? PC+4 :
          ((next_sel == 2'b01) ? Uj_type :
          ((next_sel == 2'b10) ? branch_PC :
          ((next_sel == 2'b11) ? JALR : PC+4)));
    end
  end
// decode__________________________________________________
  assign b2 = (imm_sel==2'b00) ? I_type:
              (imm_sel==2'b01) ? S_type:
              (imm_sel==2'b10) ? U_type:I_type;
  assign B = (B_sel==1'b0) ? b1 : b2;
  assign A = (A_sel==2'b00)? a1 :
             (A_sel==2'b01)? PC :
             (A_sel==2'b10)? PC+4 : 32'b0;
    // execute________________________________________________
// JALR 
  assign JALR=a1+I_type;
  assign branch_PC = (branch_result==1'b0)?PC+4:SB_type;
    // write back_______________________________________________
  assign data = (mem_reg==1'b0)?r_data:res; 
endmodule
