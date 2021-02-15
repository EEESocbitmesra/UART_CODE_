`timescale 1ns / 1ps
module switch_debouncer(
		input switch,
		input clock,
		input reset,
		output reg switch_debounced
    );
	 


parameter DEBOUNCE_COUNT=19;		//for 10ms tick

reg [DEBOUNCE_COUNT-1:0] count;
wire tick;


//the counter will generate the tick

always @(posedge clock or negedge reset)
	begin
		if (!reset)
			count<=0;
		else
			count<=count+1;
	end
	
assign tick=&count;  //AND every bit of count with itself. tick will go high when
							// all 19 bits of count are 1 i.e after 10 ms
							
							
localparam[2:0]                     //defining the various states to be used
                WAIT_FOR_PRESS        = 3'b000, 
                PRESSSED_chk_aftr10ms = 3'b001,
                PRESSSED_chk_aftr20ms = 3'b010,
                PRESSSED              = 3'b011,
                WAIT_FOR_RELEASE      = 3'b100,
                RELEASED_chk_aftr10ms = 3'b101,
                RELEASED_chk_aftr20ms = 3'b110,
                RELEASED  				  = 3'b111;
 
reg [2:0]state;
reg [2:0]next_state;
                 
always @ (posedge clock or negedge reset)      
    begin
        if (!reset)
            state <= WAIT_FOR_PRESS;
        else
            state <= next_state;
    end
	 
always @(*)
	begin
		next_state<=state;  //to make current state the default state
		switch_debounced<=1'b0;
		
		case (state)
		 WAIT_FOR_PRESS: 
					if (switch)
						next_state<=PRESSSED_chk_aftr10ms;
		 PRESSSED_chk_aftr10ms:
					if(~switch)
						next_state<=WAIT_FOR_PRESS;
					else if(tick)
						next_state<=PRESSSED_chk_aftr20ms;
		 PRESSSED_chk_aftr20ms:
					if(~switch)
						next_state<=WAIT_FOR_PRESS;
					else if(tick)
						next_state<=PRESSSED;
		 PRESSSED:
					if(~switch)
						next_state<=WAIT_FOR_PRESS;
					else if(tick)
						next_state<=WAIT_FOR_RELEASE;
		 WAIT_FOR_RELEASE:
					begin
						switch_debounced<=1'b1;
							if(~switch)
								next_state<=RELEASED_chk_aftr10ms;
					end
		 RELEASED_chk_aftr10ms: 
					if(switch)
							next_state<=WAIT_FOR_RELEASE;
						else if(tick)
							next_state<=RELEASED_chk_aftr20ms;
		 RELEASED_chk_aftr20ms: 
					if(switch)
							next_state<=WAIT_FOR_RELEASE;
						else if(tick)
							next_state<=RELEASED;
					
		 RELEASED: 
					if(switch)
							next_state<=WAIT_FOR_RELEASE;
						else if(tick)
							next_state<=WAIT_FOR_PRESS;
		 
		endcase
											
		
	end
	 


endmodule
