
module detect_start(
							//input clock,
							//input reset_n,
							input rx_in,
							output  start_bit_detected
							);
/*parameter S0=3'd0,	
					  S1=3'd1,	
					  S2=3'd2,	
					  S3=3'd3,	
					  S4=3'd4,	
					  S5=3'd5,	
					  S6=3'd6,	
					  S7=3'd7;	
reg [2:0]current_state,next_state;
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
		S0:
			begin
				if(rx_in==0)
					next_state=S1;
				else
					next_state=S0;
			end
		S1:
			begin
				if(rx_in==0)
					next_state=S2;
				else
					next_state=S0;
			end
		S2:
			begin
				if(rx_in==0)
					next_state=S3;
				else
					next_state=S0;
			end
		S3:
			begin
				if(rx_in==0)
					next_state=S4;
				else
					next_state=S0;
			end
		S4:
			begin
				if(rx_in==0)
					next_state=S5;
				else
					next_state=S0;
			end
		S5:
			begin
				if(rx_in==0)
					next_state=S6;
				else
					next_state=S0;
			end
		S6:
			begin
				if(rx_in==0)
					next_state=S7;
				else
					next_state=S0;
			end
		S7:
			begin
				
					next_state=S0;
			end
	endcase
end
assign start_bit_detected=(next_state==S7);*/
assign start_bit_detected=(rx_in==0);


endmodule
