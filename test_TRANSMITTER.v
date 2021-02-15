

module test_TRANSMITTER;

	// Inputs
	reg clock;
	reg reset_n;
	reg TXstart;
	reg [7:0] TX_data_in;

	// Outputs
	wire TX_out;
	wire TXbusy;
	// Instantiate the Unit Under Test (UUT)
	TRANSMITTER uut (
		.clock(clock), 
		.reset_n(reset_n), 
		.TXstart(TXstart), 
		.TX_data_in(TX_data_in), 
		.TXbusy(TXbusy),
		.TX_out(TX_out)
	);

	initial begin
		// Initialize Inputs
		clock = 0;
		reset_n = 0;
		TXstart = 0;
		TX_data_in=8'b10110011;
		#1 reset_n=1;
		#1 TXstart=1;
		#5 TXstart=0;
		
	end
			
	initial
		begin
			forever #2 clock=~clock;
		end
endmodule

