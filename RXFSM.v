
module RXFSM(
								clock,
								reset_n,
								start_bit_detected,
								parity_error,
								run_shift,
								parity_load,
								chk_stop
								);

input clock;
input reset_n;
input start_bit_detected;
input parity_error;
output reg run_shift;
output reg parity_load;
output reg chk_stop;


wire data_done;
reg count_en;
reg [2:0]count;
always @(posedge clock or negedge reset_n)
begin
	if(!reset_n)
		count<=0;
	else
		begin
			if(count_en)
				begin
					if(count==7)
						begin
							count<=0;
							//data_done<=1;
						end
					else
						begin
							count<=count+1;
							//data_done<=0;
						end
				end
			else
				count<=0;
		end
end
assign data_done=(count==7);
/*reg [3:0]bcount;
wire next_bit;
always @(posedge clock or negedge reset_n)
begin
	if(!reset_n)
		bcount<=0;
	else
		bcount<=bcount+1;
end
assign next_bit=(bcount==4'd15);*/

parameter IDLE=2'b00,
					 DATA=2'b01,
					 PARITY=2'b10,
					 STOP=2'b11;
reg [1:0]current_state,next_state;
always @(posedge clock or negedge reset_n)
begin
	if(!reset_n)
		current_state<=0;
	else
		current_state<=next_state;
end

always @(*)
begin
	case(current_state)
		IDLE:
			begin
				if(start_bit_detected)
					next_state=DATA;
				else
					next_state=IDLE;
			end
		DATA:
			begin
				if(data_done)
					next_state=PARITY;
				else
					next_state=DATA;
			end
		PARITY:
			begin
				if(parity_error)
					next_state=IDLE;
				else
					next_state=STOP;
			end
		STOP:
			begin
				next_state=IDLE;
			end
	endcase
end
always @(*)
begin
	case(current_state)
		IDLE:
			begin
				//RX_data_out=0;
				count_en=0;
				run_shift=0;
				parity_load=0;
				chk_stop=0;
			end
		DATA:
			begin
				count_en=1;
				run_shift=1;
				parity_load=0;
				chk_stop=0;
			end
		PARITY:
			begin
				count_en=0;
				run_shift=0;
				parity_load=1;
				chk_stop=0;
			end
		STOP:
			begin
				count_en=0;
				run_shift=0;
				parity_load=0;
				chk_stop=1;
			end
	endcase
end

endmodule
