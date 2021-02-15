
module PISO(
							clock,
							reset_n,
							load,
							shift,
							piso_in,
							piso_out
							);
input clock;
input reset_n;
input load;
input shift;
input [7:0]piso_in;
output piso_out;
reg [7:0]piso_temp;
always @(posedge clock or negedge reset_n)
begin
	if(!reset_n)
		begin
			piso_temp<=0;
		end
	else
		begin
			if(load)
				begin
					piso_temp<=piso_in;
					//piso_out<=0;
				end
			else if(shift)
				begin
					piso_temp<={piso_temp[6:0],1'b0};
				end
				
		end
end
assign piso_out=piso_temp[7];
endmodule
