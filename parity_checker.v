
module parity_checker(
												clock,
												reset_n,
												parity_in,
												data_in,
												parity_load,
												parity_error,
												data_out
												);

input clock;
input reset_n;
input parity_in;
input [7:0]data_in;
input parity_load;
output reg parity_error;
output reg [7:0]data_out;


always @(posedge clock or negedge reset_n)
begin
	if(!reset_n)
		begin
			data_out<=0;
			parity_error<=0;
		end
	else
		begin
			if(parity_load)
				begin
					if(((^data_in)^parity_in)==1)
						begin
							parity_error<=1;
							data_out<=0;
						end
					else
						begin
							parity_error<=0;
							data_out<=data_in;
						end
				end
			/*else
				begin
					data_out<=0;
					parity_error<=0;
				end*/
		end
end

endmodule
