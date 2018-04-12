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
reg[7:0] path_000;
reg[7:0] path_111;
reg[7:0] one;

//always@(posedge CLK) begin
always@* begin
//calculating edge metrics
one <= 8'b00010000;
m5 <= r5<<1; //bit shift by one is equal to multiply by 2 without performing an actual FLOP, now we have -2m metric
m6 <= r6<<1;
m5[7] <= ~r5[7]; //bit flip, able to flip the sign of our created data structure without performing a FLOP.
m6[7] <= ~r6[7]; //bit flip, now just need to do bit shift.

//edge_met = m5 + m6 + one
if(m5[7]==1 && m6[7]==1) begin
	edge_met <= {1'b1,(m5[6:0]+m6[6:0])}+one; //two FLOPs --> -2m1-2m2+1 = (-2m1)+(-2m2)+1
end else if (m5[7]==0 && m6[7]==0) begin
	edge_met <= {1'b0,(m5[6:0]+m6[6:0])}+one; 
end
else begin
	if (m5[6:0]>m6[6:0]) begin
		edge_met <= {m5[7],(m5[6:0]-m6[6:0])}+one;
	end
	else begin
		edge_met <= {m6[7],(m6[6:0]-m5[6:0])}+one;
	end
end
//path_011 = edge_met + survivor_00
if(edge_met[7]==1 && survivor_00[7]==1) begin
	path_011 <= {1'b1,(edge_met[6:0]+survivor_00[6:0])}; //two FLOPs --> -2m1-2m2+1 = (-2m1)+(-2m2)+1
end else if (edge_met[7]==0 && survivor_00[7]==0) begin
	path_011 <= {1'b0,(edge_met[6:0]+survivor_00[6:0])};  
end
else begin
	if (edge_met[6:0]>survivor_00[6:0]) begin
		path_011 <= {edge_met[7],(edge_met[6:0]-survivor_00[6:0])}; 
	end
	else begin
		path_011 <= {survivor_00[7],(survivor_00[6:0]-edge_met[6:0])};
	end
end

//path_100 = edge_met + survivor_11
if(edge_met[7]==1 && survivor_11[7]==1) begin
	path_100 <= {1'b1,(edge_met[6:0]+survivor_11[6:0])}; //two FLOPs --> -2m1-2m2+1 = (-2m1)+(-2m2)+1
end else if (edge_met[7]==0 && survivor_11[7]==0) begin
	path_100 <= {1'b0,(edge_met[6:0]+survivor_11[6:0])};  
end
else begin
	if (edge_met[6:0]>survivor_11[6:0]) begin
		path_100 <= {edge_met[7],(edge_met[6:0]-survivor_11[6:0])}; 
	end
	else begin
		path_100 <= {survivor_11[7],(survivor_11[6:0]-edge_met[6:0])};
	end
end

//path_000 is a zero
path_000 <= survivor_00;
path_111 <= survivor_11;

//Now compare path lengths. One FLOP for each if statement (two FLOPs)
if ($signed(path_011)<$signed(path_111)) begin //if MSB is 1, edge is negative and is shorter
	END_11 <= path_011;
	temp_c11 <= {temp_c1,2'b11};
end
else begin
	END_11 <= survivor_11;
	temp_c11 <= {temp_c1,2'b00};
end
if ($signed(path_100) < $signed(path_000)) begin
		END_00 <= path_100;
		temp_c00 <= {temp_c0,2'b11};
end
else begin
	END_00 <= 8'd0;
	temp_c00 <= {temp_c0,2'b00};
end

end
endmodule
