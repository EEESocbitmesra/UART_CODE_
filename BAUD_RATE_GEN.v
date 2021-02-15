
module BAUD_RATE_GEN(
													reset_n,
													clock,
													next_bit,
													baud_sel,
													sel
													);

input reset_n,clock;
input baud_sel;
output next_bit;

output reg [1:0]sel;

reg [11:0]count;
reg [11:0]modulus;

always @(posedge baud_sel or negedge reset_n)
begin
	if(!reset_n)
		sel<=0;
	else
		sel<=sel+1;
end

always @(sel)
begin
	case(sel)
		0: modulus<=12'b0001_0010_1100;     //4800    --  300
		1: modulus<=12'b0010_0101_1000;  	 //9600    --  600
		2: modulus<=12'b0100_1011_0000;     //19200  --  1200
		3: modulus<=12'b1001_0110_0000;     //38400  --  2400
	endcase
end

always @(posedge clock or negedge reset_n)
begin
	if(!reset_n)
		begin
			count<=0;
			//next_bit<=0;
			
		end
	
	else 
	begin
		if(count==modulus)
			begin
				count<=0;
				//next_bit<=1;
				
			end
		else
			begin
				count<=count+1;
				//next_bit<=0;
				
			end
		end
end

assign next_bit=(count==modulus);
				
endmodule
