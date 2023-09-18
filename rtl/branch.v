//Branch unit
module branch(

  input wire [31:0]A, 
  input wire  [31:0]B,
  input wire [2:0]fun3,
  input wire enb,
  output reg res
  
);
  
	always @(*) begin
    if (enb) begin
      case (fun3)
      //branch equal
  	    3'b000: begin
  	      if(A==B)
            res=1;
  	    end
      //branch not equal
  	    3'b001: begin
          if (A!=B)
             res=1;
  	    end
  	    3'b100:begin//blt
          if (A<B)
             res=1;
  	    end
  	    3'b101: begin//bge
          if (A>=B)
             res=1;
  	    end
  	    3'b110: begin//bltu
          if (($unsigned (A)) < ($unsigned (B)))
            res=1;
  	    end
  	    3'b111: begin //bgeu
          if (($unsigned (A)) >= ($unsigned (B)))
            res=1;
  	    end
  	    default: res=0;
  	  endcase
  	end
  end
endmodule   