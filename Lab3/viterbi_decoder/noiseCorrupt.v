module noiseCorrupt(in_0, in_1, in_2, in_3, in_4, in_5, in_6, in_7,
       out_0, out_1,out_2, out_3,out_4,out_5, out_6,out_7);
 
input [7:0] in_0;
input [7:0] in_1;
input [7:0] in_2;
input [7:0] in_3;
input [7:0] in_4;
input [7:0] in_5;
input [7:0] in_6;
input [7:0] in_7;
//input reg [3:0] rand; //rand will allow me choose the SNR of the noise channel
output reg[7:0] out_0;
output reg[7:0] out_1;
output reg[7:0] out_2;
output reg[7:0] out_3;
output reg[7:0] out_4;
output reg[7:0] out_5;
output reg[7:0] out_6;
output reg[7:0] out_7;

always @ * begin
  //rand = $random(4);
	out_0 <= mod((in_0 + {4'b0,$random(4)}),2); //i think this addition would need to be of the same size so concatenate with 0's
  out_1 <= mod((in_1 + $random(4)),2);
  out_2 <= mod((in_2 + $random(4)),2);
  out_3 <= mod((in_3 + $random(4)),2);
  out_4 <= mod((in_4 + $random(4)),2);
  out_5 <= mod((in_5 + $random(4)),2);
  out_6 <= mod((in_6 + $random(4)),2);
  out_7 <= mod((in_7 + $random(4)),2);
 end
endmodule

