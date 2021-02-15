
module stop_bit_chker(
												clock,
												reset_n,
												stop_bit_in,
												data_in,
												chk_stop,
												stop_bit_error,
												data_out
												);

input clock;
input reset_n;
input stop_bit_in;
input [7:0]data_in;
input chk_stop;
output reg stop_bit_error;
output reg [7:0]data_out;


always @(posedge clock or negedge reset_n)
begin
	if(!reset_n)
		begin
			data_out<=0;
			stop_bit_error<=0;
		end
	else
		begin
			if(chk_stop)
				begin
					if((stop_bit_in==1))
						begin
							data_out<=data_in;
							stop_bit_error<=0;
						end
					else
						begin
							data_out<=0;
							stop_bit_error<=1;
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
