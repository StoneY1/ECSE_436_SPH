//full butterfly stage edge metric module, three FLOPs for this component
module full_stage1_edge_top(CLK,r3,r4,edge_00,edge_11,survivor_00,survivor_11,temp_c0, temp_c1);
input CLK;
input[7:0] r3; input[7:0] r4;
input[7:0] edge_00; input[7:0] edge_11;
output reg[7:0] survivor_00; output reg[7:0] survivor_11; 
output reg[3:0] temp_c0; output reg[3:0] temp_c1;

reg[7:0] m3; 
reg[7:0] m4;
reg[7:0] edge_met;
reg[7:0] path_011;
reg[7:0] path_100;
reg[7:0] path_111;
reg[7:0] path_000;
reg[7:0] one;

//always@(posedge CLK) begin
always@* begin
//calculating edge metrics
one <= 8'b00010000;
m3 <= r3<<1; //bit shift by one is equal to multiply by 2 without performing an actual FLOP, now we have -2m metric
m4 <= r4<<1;
m3[7] <= ~r3[7]; //bit flip, able to flip the sign of our created data structure without performing a FLOP.
m4[7] <= ~r4[7]; //bit flip, now just need to do bit shift.

//calculate edge_met
if(m3[7]==1 && m4[7]==1) begin
	edge_met <= {1'b1,(m3[6:0]+m4[6:0])}+one; //two FLOPs --> -2m1-2m2+1 = (-2m1)+(-2m2)+1
end else if (m3[7]==0 && m4[7]==0) begin
	edge_met <= {1'b0,(m3[6:0]+m4[6:0])}+one; 
end
else begin
	if (m3[6:0]>m4[6:0]) begin
		edge_met <= {m3[7],(m3[6:0]-m4[6:0])}+one;
	end
	else begin
		edge_met <= {m4[7],(m4[6:0]-m3[6:0])}+one;
	end
end

path_011 <= edge_met; // edge_00 is a zero, so no addition needed
path_111 <= edge_11; //edge_11 is also a zero. No addition needed, just forward the edge_11 input
path_000 <= 8'd0;

//calculate path_100. Since our data structure is sign-magnitude-esque, need to compare MSBs
//path_100 = edge_met+edge_11
if(edge_met[7]==1 && edge_11[7]==1) begin
	path_100 <= {1'b1,(edge_met[6:0]+edge_11[6:0])}; //two FLOPs --> -2m1-2m2+1 = (-2m1)+(-2m2)+1
end else if (edge_met[7]==0 && edge_11[7]==0) begin
	path_100 <= {1'b0,(edge_met[6:0]+edge_11[6:0])};  
end
else begin
	if (edge_met[6:0]>edge_11[6:0]) begin
		path_100 <= {edge_met[7],(edge_met[6:0]-edge_11[6:0])}; 
	end
	else begin
		path_100 <= {edge_11[7],(edge_11[6:0]-edge_met[6:0])};
	end
end

//Now compare path lengths. For this part of the trellis, only need to check MSB of edge_0 and edge_1 to determine survivor paths
if ($signed(path_011) <=$signed(path_111)) begin //if MSB is 1, edge is negative and is shorter
	survivor_11 <= path_011;
	temp_c1 <= 4'b0011;
end
else begin
	survivor_11 <= path_111;
	temp_c1 <= 4'b1100;
end

if (path_100[7] == 1) begin
	survivor_00 <= path_100;
	temp_c0 <= 4'b1111;
end
else begin
	survivor_00 <= 8'd0;
	temp_c0 <= 4'b0000;
end
end
endmodule
