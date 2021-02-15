
module TRANSMITTER(
												clock,
												reset_n,
												TXstart,
												TX_data_in,
												TX_out,
												TXbusy
												);
input clock;
input reset_n;
input TXstart;
input [7:0]TX_data_in;
output TX_out;
output TXbusy;
wire [1:0]select;

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
PISO			THR(
							.clock(next_bit),
							.reset_n(reset_n),
							.load(load),
							.shift(shift),
							.piso_in(TX_data_in),
							.piso_out(data_bit)
							);
parity_gen parity_block(
										.clock(next_bit),
										.reset_n(reset_n),
										.parity_data_in(TX_data_in),
										.parity_load(parity_load),
										.parity_out(parity_bit)
										);
TXFSM		controller(
							.clock(next_bit),
							.reset_n(reset_n),
								.TXstart(TXstart),
								.select(select),
								.load(load),
								.shift(shift),
								.parity_load(parity_load),
								.TXbusy(TXbusy)
								);
TXMUX	mux(
								.select(select),
								.data_bit(data_bit),
								.parity_bit(parity_bit),
								.tx_out(TX_out)
								);
endmodule
