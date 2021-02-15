
module TXFSM(
								clock,
								reset_n,
								TXstart,
								select,
								load,
								shift,
								TXbusy,
								parity_load
								
								);
//*********************************************************************************************************************************************************//
input clock;
input reset_n;
input TXstart;
output reg [1:0]select;
output reg load;
output reg shift;
output reg parity_load;
output reg TXbusy;

//*********************************************************************************************************************************************************//
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
						count<=0;
					else
						count<=count+1;
				end
			else
				count<=0;
		end
end
assign data_done=(count==7);
//*********************************************************************************************************************************************************//

//*********************************************************************************************************************************************************//
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
//**********************************************************************************************************************************************************//
parameter IDLE=3'd0,
					 START_BIT=3'd1,
					 DATA=3'd2,
					 PARITY=3'd3,
					 STOP=3'd4;
reg [2:0]current_state,next_state;
//*********************************************************************************************************************************************************//
always @(posedge clock or negedge reset_n)
begin
	if(!reset_n)
		current_state<=0;
	else
		current_state<=next_state;
end
//*********************************************************************************************************************************************************//
always @(*)
begin
	case(current_state)
		IDLE:
			begin
				if(TXstart)
					next_state=START_BIT;
				else
					next_state=IDLE;
			end
		START_BIT:
			begin
				next_state=DATA;
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
				next_state=STOP;
			end
		STOP:
			begin
				if(TXstart)
					next_state=START_BIT;
				else
					next_state=IDLE;
			end
		default:
			begin
				next_state=IDLE;
			end
	endcase
end
//*********************************************************************************************************************************************************//
always @(*)
begin
	case(current_state)
		IDLE:
			begin
				select=2'b11;
				load=0;
				shift=0;
				parity_load=0;
				count_en=0;
				TXbusy=0;
			end
		START_BIT:
			begin
				select=2'b00;
				load=1;
				shift=0;
				parity_load=1;
				count_en=0;
				TXbusy=1;
			end
		DATA:
			begin
				select=2'b01;
				load=0;
				shift=1;
				parity_load=0;
				count_en=1;
				TXbusy=1;
			end
		PARITY:
			begin
				select=2'b10;
				load=0;
				shift=0;
				parity_load=0;
				count_en=0;
				TXbusy=1;
			end
		STOP:
			begin
				select=2'b11;
				load=0;
				shift=0;
				parity_load=0;
				count_en=0;
				TXbusy=1;
			end
		default:
			begin
				select=2'b11;
				load=0;
				shift=0;
				parity_load=0;
				count_en=0;
				TXbusy=0;
			end
	endcase
end
//*********************************************************************************************************************************************************//
endmodule
