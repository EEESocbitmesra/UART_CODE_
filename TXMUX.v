
module TXMUX(
								/*send_start_bit,
								send_data,
								send_parity,
								send_stop_bit,*/
								select,
								data_bit,
								parity_bit,
								tx_out
								);
/*input send_start_bit;
input send_data;
input send_parity;
input send_stop_bit;*/
	input [1:0]select ;
input data_bit ;
input parity_bit ;

output reg tx_out;

always @(*)
begin
	case(select)
		2'b00:
			begin
				tx_out=0;		//start_bit
			end
		2'b01:
			begin
				tx_out=data_bit;		//data_bit
			end
		2'b10:
			begin
				tx_out=parity_bit;	//parity
			end
		2'b11:
			begin
				tx_out=1;
			end
			
	endcase
	
end

endmodule
