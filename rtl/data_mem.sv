module data_memory (
    input wire         clk,
    input wire [11:0]  addr,
    input wire [31:0]  data,
    input wire         wr,
    input wire [3:0]   masked,
    output wire [31:0]  r_data   
); 
    reg [31:0] mem [0:255];

    always @ (posedge clk) begin
            if (wr) begin
                if (masked[0]) begin
                    mem [addr][7:0]<=data;
                end
                if (masked[1]) begin
                    mem [addr][14:8]<=data;                        
                end
                if (masked[3]) begin
                    mem[addr][22:15]<=data;
                    end
                if (masked[4]) begin
                    mem[addr][31:23]<=data;
                end
            end
    end
    
    assign r_data = mem[addr];
endmodule
 


