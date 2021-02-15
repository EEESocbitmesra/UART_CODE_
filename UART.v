
module UART(					clock,
												reset_n,
												baud_sel,
												TXstart,
												TX_data_in,
												//TX_out,
												TXbusy,
												RX_DATA_OUT,
												parity_error,
												stop_bit_error,
												BAUD_RATE
												);
input clock;
input reset_n;
input TXstart;
input baud_sel;
input [7:0]TX_data_in;
//output TX_out;
output TXbusy;
output [7:0]RX_DATA_OUT;
output parity_error;
output stop_bit_error;
output [1:0]BAUD_RATE;

switch_debouncer baud_debouncer(
																			.switch(baud_sel),
																			.clock(clock),
																			.reset(reset_n),
																			.switch_debounced(baud_sel_debounce)
																		 );

BAUD_RATE_GEN baud(
												.reset_n(reset_n),
												.clock(clock),
												.next_bit(bclock),
												.baud_sel(baud_sel_debounce),
												.sel(BAUD_RATE)
												);
TRANSMITTER	TX(
												.clock(bclock),
												.reset_n(reset_n),
												.TXstart(TXstart),
												.TX_data_in(TX_data_in),
												.TX_out(TX_out),
												.TXbusy(TXbusy)
												);
												
RECEIVER	RX(
											.clock(bclock),
											.reset_n(reset_n),
											.RX_DATA_IN(TX_out),
											.RX_DATA_OUT(RX_DATA_OUT),
											.parity_error(parity_error),
											.stop_bit_error(stop_bit_error)
											);
endmodule
