
module BIN_2_BCD_top(
													input clock,
													input reset,
													input [7:0]data_in,
													output [6:0]segment_data,
													output [3:0]AN
													);
wire [11:0]BCD;
bin_to_bcd main(
									.data_in(data_in),
									.data_out(BCD)
   );
	
SEVEN_SEGMENT_DRIVER driver(
																	.clock(clock),
																	.reset(reset),
																	.a(BCD[11:8]),
																	.b(BCD[7:4]),
																	.c(BCD[3:0]),
																	.AN(AN),
																	.segment_data(segment_data)
																	);
endmodule
