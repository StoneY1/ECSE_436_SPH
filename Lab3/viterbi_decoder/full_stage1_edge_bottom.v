//full butterfly stage edge metric module, six FLOPs for this component
module full_stage1_edge_bottom(CLK,r3,r4,edge_10,edge_01,survivor_10,survivor_01,temp_c10, temp_c01);
input CLK;
input[7:0] r3; input[7:0] r4;
input[7:0] edge_10; input[7:0] edge_01;
output reg[7:0] survivor_10; output reg[7:0] survivor_01; 
output reg[3:0] temp_c10; output reg[3:0] temp_c01;

reg[7:0] m3; 
reg[7:0] m4;
reg[7:0] path_1001;
reg[7:0] path_1010;
reg[7:0] path_0110;
reg[7:0] path_0101;

always@(posedge CLK) begin
//calculating edge metrics
m3 <= r3;
m4 <= r4;
m3[7] <= ~m3[7]; //bit flip, able to flip the sign of our created data structure without performing a FLOP.
m4[7] <= ~m4[7]; //bit flip, now just need to do bit shift.
m3 <= m3<<1; //bit shift by one is equal to multiply by 2 without performing an actual FLOP, now we have -2m metric
m4 <= m4<<1;
path_1001 <= m3+edge_10; //one FLOP
path_1010 <= m4+edge_10; // one FLOP
path_0110 <= m3+edge_01; //one FLOP
path_0101 <= m4+edge_01; //one FLOP

//Now compare path lengths. One FLOP per if statement (two FLOPs)
if (path_1010 < path_0110) begin 
survivor_10 <= path_1010;
temp_c10 <= 4'b1001;
end
else begin
survivor_10 <= path_0110;
temp_c10 <= 4'b0110;
end

if (path_1001 < path_0101) begin
survivor_01 <= path_1001;
temp_c01 <= 4'b1010;
end
else begin
survivor_01 <= path_0101;
temp_c01 <= 4'b0101;
end
end
endmodule
