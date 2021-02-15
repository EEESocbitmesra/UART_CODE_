
module SIPO(
										input clock,
										input reset_n,
										input rx_in,
										input run_shift,
										output [7:0]data_out
										);


reg [7:0]temp;

always @(posedge clock or negedge reset_n)
begin
	if(!reset_n)
		temp<=0;
	else if(run_shift)
		begin
			temp<={temp[6:0],rx_in};
			
		end
end
assign data_out=temp;

endmodule
