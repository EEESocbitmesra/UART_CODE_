module bin_to_bcd(
										data_in,
										data_out
   );
   input [7:0]data_in;
	output reg [11:0]data_out;
	
	always @(data_in)
		bcd(data_out,data_in);
		
task bcd;
	output [11:0]data_out;
	input [7:0]data_in;
	reg [19:0]shift;
	integer i;
	begin
		shift={12'd0,data_in};
		for(i=0;i<8;i=i+1)
			begin
				if (shift[11:8] >= 5)
					shift[11:8] = shift[11:8] + 3;
            
				if (shift[15:12] >= 5)
					shift[15:12] = shift[15:12] + 3;
            
				if (shift[19:16] >= 5)
					shift[19:16] = shift[19:16] + 3;
         
         // Shift entire register left once
         shift = shift << 1;
			end
			data_out=shift[19:8];
	end
	
endtask
endmodule // Binary_to_BCD