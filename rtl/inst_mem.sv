module inst_mem (
    input wire         clk,
    input wire [11:0]  addr,
    input wire [31:0]  data,
    input wire         wr,
    input wire [1:0]   masked,
    output wire [31:0]  r_data   
); 
    reg [31:0] mem [0:255];
    
    initial begin
        $readmemh("C:\Users\ncw\Documents\RISC-V Microprocessor\assembly codes\test.mem",mem);
    end

    always @(posedge clk) begin
        if (wr) begin
            if (masked[0]) begin
                mem [0][7:0]<=data;
            end
            if (masked[1]) begin
                mem [0][14:8]<=data;                        
            end
            if (masked[3]) begin
                mem[0][22:15]<=data;
            end
            if (masked[4]) begin
                mem[0][31:23]<=data;
            end
        end
    end

    assign  r_data = mem[addr];
endmodule
 


