module alias_block(
	left_channel_audio_in,
	right_channel_audio_in,
	
	
	vol,
	
	counterVal,
	audio_in_available,
	audio_out_allowed,
	
	left_channel_audio_out,
	right_channel_audio_out,
	read_audio_in,
	write_audio_out
);



input wire audio_in_available;
input wire audio_out_allowed;
input reg[3:0]counterVal;
input reg[2:0]vol;
input reg[31:0]left_channel_audio_in;
input reg[31:0]right_channel_audio_in;
 
output reg[31:0]left_channel_audio_out = 32'd0;
output reg[31:0]right_channel_audio_out = 32'd0;
output wire read_audio_in;
output wire write_audio_out;

always begin

read_audio_in <= audio_in_available && audio_out_allowed;
write_audio_out <= audio_in_available && audio_out_allowed;
case (vol)
	
	//2:1 
	3'b001 : 
			begin

				if(counterVal[0] == 0) begin
					left_channel_audio_out <= left_channel_audio_in;
					right_channel_audio_out <= right_channel_audio_in;
				end else begin
					left_channel_audio_out <= 32'd0;
					right_channel_audio_out <= 32'd0;
				end		
			end
	//4:1 
	3'b010 : 
		begin				
				if(counterVal[1:0] == 2'b00) begin
					left_channel_audio_out <= left_channel_audio_in;
					right_channel_audio_out <= right_channel_audio_in;
				end else begin
					left_channel_audio_out <= 32'd0;
					right_channel_audio_out <= 32'd0;
				end	
		end
	//8:1
	3'b100: 
		begin
				if(counterVal[2:0] == 3'b000) begin
					left_channel_audio_out <= left_channel_audio_in;
					right_channel_audio_out <= right_channel_audio_in;
				end else begin
					left_channel_audio_out <= 32'd0;
					right_channel_audio_out <= 32'd0;
				end	
		end
	

	default: 
			begin
				left_channel_audio_out <= left_channel_audio_in;
				right_channel_audio_out <= right_channel_audio_in;
			end
			
endcase	


end

endmodule 