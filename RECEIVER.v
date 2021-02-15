
module RECEIVER(
											clock,
											reset_n,
											RX_DATA_IN,
											RX_DATA_OUT,
											parity_error,
											stop_bit_error
											);
input clock;
input reset_n;
input RX_DATA_IN;
output [7:0]RX_DATA_OUT;
output parity_error;
output stop_bit_error;

wire [7:0]SIPO_OUT,PARITY_OUT;

reg [3:0]bcount;
wire next_bit;
always @(posedge clock or negedge reset_n)
begin
	if(!reset_n)
		bcount<=0;
	else
		bcount<=bcount+1;
end
assign next_bit=(bcount==4'd15);

RXFSM controller(
										.clock(next_bit),
										.reset_n(reset_n),
										.start_bit_detected(start_bit_detected),
										.parity_error(parity_error),
										.run_shift(run_shift),
										.parity_load(parity_load),
										.chk_stop(chk_stop)
										);
detect_start	START(
												//.clock(clock),
												//.reset_n(reset_n),
												.rx_in(RX_DATA_IN),
												.start_bit_detected(start_bit_detected)
												);
SIPO	TSR(
										.clock(next_bit),
										.reset_n(reset_n),
										.rx_in(RX_DATA_IN),
										.run_shift(run_shift),
										.data_out(SIPO_OUT)
										);

parity_checker	PARITY(
												.clock(next_bit),
												.reset_n(reset_n),
												.parity_in(RX_DATA_IN),
												.data_in(SIPO_OUT),
												.parity_load(parity_load),
												.parity_error(parity_error),
												.data_out(PARITY_OUT)
												);
 stop_bit_chker	STOP(
												.clock(next_bit),
												.reset_n(reset_n),
												.stop_bit_in(RX_DATA_IN),
												.data_in(PARITY_OUT),
												.chk_stop(chk_stop),
												.stop_bit_error(stop_bit_error),
												.data_out(RX_DATA_OUT)
												);

endmodule

