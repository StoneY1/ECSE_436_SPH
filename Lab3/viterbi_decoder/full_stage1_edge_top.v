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
reg[7:0] one;

always@(posedge CLK) begin
//calculating edge metrics
one <= 8'b00010000;
m3 <= r3;
m4 <= r4;
m3[7] <= ~m3[7]; //bit flip, able to flip the sign of our created data structure without performing a FLOP.
m4[7] <= ~m4[7]; //bit flip, now just need to do bit shift.
m3 <= m3<<1; //bit shift by one is equal to multiply by 2 without performing an actual FLOP, now we have -2m metric
m4 <= m4<<1;

//calculate edge_met
edge_met <= $signed(m3)+$signed(m4)+$signed(one);
path_011 <= edge_met; // edge_00 is a zero, so no addition needed

//calculate path_100. Since our data structure is sign-magnitude-esque, using sign system function
path_100 <= $signed(edge_met)+$signed(edge_11);

//Now compare path lengths. For this part of the trellis, only need to check MSB of edge_0 and edge_1 to determine survivor paths
if (path_011[7] == 1) begin //if MSB is 1, edge is negative and is shorter
survivor_11 <= path_011;
temp_c1 <= 4'b0011;
end
else begin
survivor_11 <= edge_11;
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
