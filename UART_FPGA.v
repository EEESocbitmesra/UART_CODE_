
module UART_FPGA(
												input clock,
												input reset,
												input baud_sel,
												input TXstart,
												input [7:0] TX_data_in,
												output TXbusy,
												output parity_error,
												output stop_bit_error,
												output [1:0]BAUD_RATE,
												output  [6:0]segment_data,
												output [3:0]AN
												);

assign reset_n=~reset;
wire [7:0]RX_DATA_OUT;
UART		m1(					.clock(clock),
												.reset_n(reset_n),
												.baud_sel(baud_sel),
												.TXstart(TXstart),
												.TX_data_in(TX_data_in),
												.TXbusy(TXbusy),
												.RX_DATA_OUT(RX_DATA_OUT),
												.parity_error(parity_error),
												.stop_bit_error(stop_bit_error),
												.BAUD_RATE(BAUD_RATE)
												);
												
BIN_2_BCD_top	FPGA(
													.clock(clock),
													.reset(reset_n),
													.data_in(RX_DATA_OUT),
													.segment_data(segment_data),
													.AN(AN)
													);
endmodule
