module noise_corrupt(left_channel_audio_in, right_channel_audio_in, SNR, AWGN, left_channel_audio_out, right_channel_audio_out);
	input reg[31:0] AWGN;
	input reg[2:0] SNR;
	input reg[31:0] left_channel_audio_in;
	input reg[31:0] right_channel_audio_in;
	output reg[31:0] left_channel_audio_out;
	output reg[31:0] right_channel_audio_out;
	reg[31:0] shifted_AWGN;
	
	always@* begin
	case(SNR)
		//No noise case
		3'b010:
			begin
				right_channel_audio_out <= right_channel_audio_in;
				left_channel_audio_out <= left_channel_audio_in;
			end
		//40dB
		3'b001:
			begin
				shifted_AWGN <= AWGN >> 10;
				right_channel_audio_out <= right_channel_audio_in+shifted_AWGN;
				left_channel_audio_out <= left_channel_audio_in+shifted_AWGN;
			end
		//30dB
		3'b011:
			begin
				shifted_AWGN = AWGN >> 8;
				right_channel_audio_out <= right_channel_audio_in+shifted_AWGN;
				left_channel_audio_out <= left_channel_audio_in+shifted_AWGN;
			end
		//20dB
		3'b111:
			begin
				shifted_AWGN = AWGN >> 6;
				right_channel_audio_out <= right_channel_audio_in+shifted_AWGN;
				left_channel_audio_out <= left_channel_audio_in+shifted_AWGN;			
			end
		//10dB
		3'b110:
			begin
				shifted_AWGN = AWGN >> 4;
				right_channel_audio_out <= right_channel_audio_in+shifted_AWGN;
				left_channel_audio_out <= left_channel_audio_in+shifted_AWGN;			
			end
		//0dB
		3'b100:
			begin
				shifted_AWGN = AWGN >> 2;
				right_channel_audio_out <= right_channel_audio_in+shifted_AWGN;
				left_channel_audio_out <= left_channel_audio_in+shifted_AWGN;
			end
		//-10dB
		3'b101:
			begin
				right_channel_audio_out <= right_channel_audio_in+AWGN;
				left_channel_audio_out <= left_channel_audio_in+AWGN;
			end
		default: 
			begin
				left_channel_audio_out <= 32'd0;
				right_channel_audio_out <= 32'd0;
			end
		endcase
	end
	
endmodule
