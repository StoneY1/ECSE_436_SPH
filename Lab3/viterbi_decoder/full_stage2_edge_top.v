//full butterfly stage edge metric module, six FLOPs for this component
module full_stage2_edge_top(CLK,r5,r6,temp_c0,temp_c1,survivor_00,survivor_11,END_00, END_11,temp_c00, temp_c11);
input CLK;
input[7:0] r5; input[7:0] r6;
input[7:0] survivor_00; input[7:0] survivor_11; input[3:0] temp_c0; input[3:0] temp_c1;
output reg[7:0] END_00; output reg[7:0] END_11; 
output reg[5:0] temp_c00; output reg[5:0] temp_c11;

reg[7:0] m5; 
reg[7:0] m6;
reg[7:0] edge_met;
reg[7:0] path_011;
reg[7:0] path_100;
reg[7:0] one;

always@(posedge CLK) begin
//calculating edge metrics
one <= 8'b00010000;
m5 <= r5;
m6 <= r6;
m5 <= m5<<1; //bit shift by one is equal to multiply by 2 without performing an actual FLOP, now we have -2m metric
m6 <= m6<<1;
m5[7] <= ~r5[7]; //bit flip, able to flip the sign of our created data structure without performing a FLOP.
m6[7] <= ~r6[7]; //bit flip, now just need to do bit shift.

edge_met <= $signed(m5)+$signed(m6)+$signed(one);
path_011 <= $signed(edge_met)+$signed(survivor_00);
path_100 <= $signed(edge_met)+$signed(survivor_11);

//Now compare path lengths. One FLOP for each if statement (two FLOPs)
if ($signed(path_011)<$signed(survivor_11)) begin //if MSB is 1, edge is negative and is shorter
	END_11 <= path_011;
	temp_c11 <= {temp_c0,2'b11};
end
else begin
	END_11 <= survivor_11;
	temp_c11 <= {temp_c0,2'b00};
end
if ($signed(path_100) < $signed(survivor_00)) begin
		END_00 <= path_100;
		temp_c00 <= {temp_c1,2'b11};
end
else begin
	END_00 <= 8'd0;
	temp_c00 <= {temp_c1,2'b00};
end

end
endmodule
