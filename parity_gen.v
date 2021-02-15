
module parity_gen(
										clock,
										reset_n,
										parity_data_in,
										parity_load,
										parity_out
										);
input [7:0]parity_data_in;
input parity_load;
input clock;
input reset_n;
output reg parity_out;


always @(posedge clock or negedge reset_n)
begin
	if(!reset_n)
		parity_out<=0;
	else
		begin
			if(parity_load)
				parity_out<=^parity_data_in;
		end
	
end


endmodule
