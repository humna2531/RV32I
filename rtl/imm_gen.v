module imm_gen (
    input wire [31:7] ins,
    input wire [31:0] pc,
    output reg [31:0] I_type,
    output reg [31:0] S_type,
    output reg [31:0] SB_type,
    output reg [31:0] Uj_type,
    output reg [31:0] U_type
);
  always@ (*) begin
    //I_TYPE
    I_type[11:0]=ins[31:20];
    if(ins[31]==1'b1)
      I_type[31:12]=20'b11111111111111111111;
    else
      I_type[31:12]=20'b0; 
    //S_TYPE
    S_type[4:0]=ins[11:7];
    S_type[11:5]=ins[31:25];
    if (ins[31]==1'b1) 
      S_type[31:12]=20'b11111111111111111111;
    else
      S_type[31:12]=20'b0;
    //SB_TYPE
    SB_type[0]=1'b0;
    SB_type[4:1]=ins[11:8];
    SB_type[10:5]=ins[30:25];
    SB_type[11]=ins[7];
    SB_type[12]=ins[31];
    if(ins[31]==1'b1)
      SB_type[31:13]=19'b1111111111111111111;
    else
      SB_type[31:13]=19'b0;
    SB_type =SB_type+pc;

    //UJ_TYPE
    Uj_type[19:12]=ins[19:12];
    Uj_type[11]=ins[20];
    Uj_type[10:1]=ins[30:21];
    Uj_type[20]=ins[31];
    Uj_type[0]=1'b0;
    if(ins[31]==1'b1)
      Uj_type[31:21]=11'b11111111111;
    else
      Uj_type[31:21]=11'b00000000000;
    Uj_type=Uj_type+pc;
    
    //U_TYPE
    U_type[19:0]=ins[31:12];
    if(ins[31]==1'b1)
      U_type[31:20]=12'b111111111111;
    else
      U_type[31:20]=12'b000000000000;
    
    U_type[31:0]=U_type[31:0]<<12;
end

endmodule