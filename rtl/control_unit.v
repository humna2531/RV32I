module control_unit (
    input wire [6:0] opcode,
    input wire [2:0] func3,
    input wire  func7,
    output reg  reg_write,branch,store,load,mem_reg,opB,
    output reg [0:1] imm_sel,next_sel,opA,
    output reg [3:0] ALU_C
);
  
  
    localparam R_type =  7'b0100001 ;
    localparam I_type =  7'b0001101 ;
    localparam S_type =  7'b0010111 ;
    localparam lw = 7'b0000011 ;
    localparam jalr = 7'b1000011 ;
    localparam bran = 7'b0111110;
    localparam aui_pc = 7'b0010001;
    localparam lui = 7'b0100101;
    localparam jal = 7'b1101111 ;

    always @(*) begin
      case (opcode) 
        R_type: 
        begin
            reg_write=1'b1;
            branch=1'b0;
            store=1'b0;
            load=1'b0;
            mem_reg=1'b0;
            opA=2'b00;
            opB=1'b0;
            imm_sel=2'b00;
            next_sel= 2'b00;
        if (func3==3'b000)begin 
              if (!func7)
                 ALU_C=4'b0000;
              else 
                 ALU_C=4'b0001;
        end
        else if (func3==3'b001) begin
              if (!func7)
                ALU_C=4'b0101;
             else 
                ALU_C=4'b1110;
        end
        else if (func3==3'b010)begin 
          if (!func7)
             ALU_C=4'b0111;
          else 
             ALU_C=4'b0111;
        end
        else if (func3==3'b011) begin
          if (!func7)
             ALU_C=4'b1000;
          else 
             ALU_C=4'b1000;
        end
        else if (func3==3'b100)begin 
          if (!func7)
             ALU_C=4'b0100;
          else 
             ALU_C=4'b1110;
        end
        else if (func3==3'b101)begin
          if (!func7)
             ALU_C=4'b0110;
          else 
            ALU_C=4'b1001;
        end
        else if (func3==3'b110)begin 
          if (!func7)
            ALU_C=4'b0011;
          else 
             ALU_C=4'b1110;
        end
        else if (func3==3'b111) begin
          if (!func7)
            ALU_C=4'b0010;
          else 
            ALU_C=4'b1110;
        end
        end
        I_type:begin
            reg_write=1'b1;
            branch=1'b0;
            store=1'b0;
            load=1'b0;
            mem_reg=1'b0;
            opA=2'b00;
            opB=1'b1;
            imm_sel=2'b00;
            next_sel=2'b00;
        if (func3==3'b000)begin
            if (!func7) 
             assign ALU_C=4'b0000;
        end
        else if (func3==3'b001)begin
             ALU_C=4'b0101;
        end
        else if (func3==3'b010)begin
             ALU_C=4'b0111;
        end
        else if (func3==3'b011)begin
             ALU_C=4'b1000;
        end
        else if (func3==3'b100) begin
            ALU_C=4'b0100;
        end 
        else if (func3==3'b101) begin
          if (!func7)
             ALU_C=4'b0110;
          else 
            ALU_C=4'b1001;
        end
          else if (func3==3'b110) begin
            ALU_C=4'b0011;
        end
          else if (func3==3'b111) begin
            ALU_C=4'b0010;
        end
    end
        S_type:begin
            reg_write=1'b0;
            branch=1'b0;
            store=1'b1;
            load=1'b0;
            mem_reg=1'b0;
            opA=2'b00;
            opB=1'b1;
            imm_sel=2'b00;
            next_sel=2'b00;
            ALU_C=4'b0000;
        end
        lw:begin
            reg_write=1'b1;
            branch=1'b0;
            store=1'b0;
            load=1'b1;
            mem_reg=1'b1;
            opA=2'b00;
            opB=1'b1;
            imm_sel=2'b10;
            next_sel=2'b00;
            ALU_C=4'b0000;     
        end
        jalr:begin
            reg_write=1'b1;
            branch=1'b0;
            store=1'b0;
            load=1'b0;
            mem_reg=1'b0;
            opA=2'b01;
            opB=1'b0;
            imm_sel=2'b10;
            next_sel=2'b01;
            
        end
        bran:begin
            reg_write=1'b0;
            branch=1'b1;
            store=1'b0;
            load=1'b0;
            mem_reg=1'b0;
            opA=2'b00;
            opB=1'b0;
            imm_sel=2'b01;
            next_sel=2'b11;  
        end
        aui_pc:begin
            reg_write=1'b1;
            branch=1'b0;
            store=1'b0;
            load=1'b0;
            mem_reg=1'b0;
            opA=2'b10;
            opB=1'b1;
            imm_sel=2'b01;
            next_sel=2'b00;
        end
        lui:begin
            reg_write=1'b1;
            branch=1'b0;
            store=1'b0;
            load=1'b0;
            mem_reg=1'b0;
            opA=2'b10;
            opB=1'b0;
            imm_sel=2'b00;
            next_sel=2'b00;
        end
        jal:begin
            reg_write=1'b1;
            branch=1'b0;
            store=1'b0;
            load=1'b0;
            mem_reg=1'b0;
            opA=2'b10;
            opB=1'b0;
            imm_sel=2'b00;
            next_sel=2'b10;
        end
        default:begin
            reg_write=1'b0;
            branch=1'b0;
            store=1'b0;
            load=1'b0;
            mem_reg=1'b0;
            opA=2'b00;
            opB=1'b0;
            imm_sel=2'b00;
            next_sel=2'b00;
            ALU_C=4'b0000;   
        end
      endcase
    end
endmodule
   
