

module test_UART;

	// Inputs
	reg clock;
	reg reset_n;
	reg [1:0] baud_sel;
	reg TXstart;
	reg [7:0] TX_data_in;

	// Outputs
	//wire TX_out;
	wire TXbusy;
	wire [7:0] RX_DATA_OUT;
	wire parity_error;
	wire stop_bit_error;
	wire [1:0]BAUD_RATE;

	// Instantiate the Unit Under Test (UUT)
	UART uut (
		.clock(clock), 
		.reset_n(reset_n), 
		.baud_sel(baud_sel), 
		.TXstart(TXstart), 
		.TX_data_in(TX_data_in), 
		//.TX_out(TX_out), 
		.TXbusy(TXbusy), 
		.RX_DATA_OUT(RX_DATA_OUT), 
		.parity_error(parity_error), 
		.stop_bit_error(stop_bit_error),
		.BAUD_RATE(BAUD_RATE)
	);

	initial begin
		// Initialize Inputs
		clock = 0;
		reset_n = 0;
		baud_sel = 2'd1;
		TXstart = 0;
		TX_data_in = 0;
		TX_data_in=8'b10110011;
		#1 reset_n=1;
		#1 TXstart=1;
		//#5 TXstart=0;
		
	end
			
	initial
		begin
			forever #2 clock=~clock;
		end
endmodule

