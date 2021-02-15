
module SEVEN_SEGMENT_DRIVER(
									clock,
									reset,
									a,b,c,
									AN,
									segment_data
									);
									
input clock,reset;
input [3:0]a;
input [3:0]b;
input [3:0]c;
output reg [3:0]AN;
output reg [6:0]segment_data;


localparam n=16;
reg [n-1:0]count;
reg [3:0]segment_data_temp;
always @(posedge clock or negedge reset)
	begin
		if (!reset)
			begin
				count<=0;
				segment_data_temp<=0;
				AN<=4'b0000;
			end
		else
		begin
			count<=count+1;
		case (count[n-1:n-2])
			2'b00: 
					begin
						segment_data_temp<=0;
						AN<=4'b1110;
					end
			2'b01: 
					begin
						segment_data_temp<=a;
						AN<=4'b1101;
					end
			2'b10: 
					begin
						segment_data_temp<=b;
						AN<=4'b1011;
					end
			2'b11: 
					begin
						segment_data_temp<=c;
						AN<=4'b0111;
					end
			default:AN<=4'b0000;
		endcase
	end
	end
	
always @(segment_data_temp)
	begin
		case (segment_data_temp)
			0: segment_data=7'b0000001;
			1: segment_data=7'b1001111;
			2: segment_data=7'b0010010;
			3: segment_data=7'b0000110;
			4: segment_data=7'b1001100;
			5: segment_data=7'b0100100;
			6: segment_data=7'b1100000;
			7: segment_data=7'b0001111;
			8: segment_data=7'b0000000;
			9: segment_data=7'b0000100;
			default: segment_data=7'b0110000;
	endcase
	end
endmodule



