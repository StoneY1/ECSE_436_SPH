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

if(m3[7]==1 && edge_10[7]==1) begin
	path_1001 <= {1'b1,(m3[6:0]+edge_10[6:0])}; //two FLOPs --> -2m1-2m2+1 = (-2m1)+(-2m2)+1
end else if (m3[7]==0 && edge_10[7]==0) begin
	path_1001 <= {1'b0,(m3[6:0]+edge_10[6:0])};  
end
else begin
	if (m3[6:0]>edge_10[6:0]) begin
		path_1001 <= {m3[7],(m3[6:0]+edge_10[6:0])}; 
	end
	else begin
		path_1001 <= {edge_10[7],(m3[6:0]+edge_10[6:0])};
	end
end

if(m4[7]==1 && edge_10[7]==1) begin
	path_1010 <= {1'b1,(m4[6:0]+edge_10[6:0])}; //two FLOPs --> -2m1-2m2+1 = (-2m1)+(-2m2)+1
end else if (m4[7]==0 && edge_10[7]==0) begin
	path_1010 <= {1'b0,(m4[6:0]+edge_10[6:0])};  
end
else begin
	if (m4[6:0]>edge_10[6:0]) begin
		path_1010 <= {m4[7],(m4[6:0]+edge_10[6:0])}; 
	end
	else begin
		path_1010 <= {edge_10[7],(m4[6:0]+edge_10[6:0])};
	end
end

if(m3[7]==1 && edge_01[7]==1) begin
	path_0110 <= {1'b1,(m3[6:0]+edge_01[6:0])}; //two FLOPs --> -2m1-2m2+1 = (-2m1)+(-2m2)+1
end else if (m3[7]==0 && edge_01[7]==0) begin
	path_0110 <= {1'b0,(m3[6:0]+edge_01[6:0])};  
end
else begin
	if (m3[6:0]>edge_01[6:0]) begin
		path_0110 <= {m3[7],(m3[6:0]+edge_01[6:0])}; 
	end
	else begin
		path_0110 <= {edge_01[7],(m3[6:0]+edge_01[6:0])};
	end
end

if(m4[7]==1 && edge_01[7]==1) begin
	path_0110 <= {1'b1,(m4[6:0]+edge_01[6:0])}; //two FLOPs --> -2m1-2m2+1 = (-2m1)+(-2m2)+1
end else if (m4[7]==0 && edge_01[7]==0) begin
	path_0110 <= {1'b0,(m4[6:0]+edge_01[6:0])};  
end
else begin
	if (m4[6:0]>edge_01[6:0]) begin
		path_0110 <= {m4[7],(m4[6:0]+edge_01[6:0])}; 
	end
	else begin
		path_0110 <= {edge_01[7],(m4[6:0]+edge_01[6:0])};
	end
end


//Now compare path lengths. One FLOP per if statement (two FLOPs)
if(path_1010[7]==1 && path_0110[7]==1) begin
	if (path_1010 > path_0110) begin 
		survivor_10 <= path_1010;
		temp_c10 <= 4'b1001;
	end
	else begin
		survivor_10 <= path_0110;
		temp_c10 <= 4'b0110;
	end
end
else if (path_1010[7]==1) begin
	survivor_10 <= path_1010;
	temp_c10 <= 4'b1001;
end 
else if (path_0110[7]==1) begin
	survivor_10 <= path_0110;
	temp_c10 <= 4'b0110;
end
else begin
	if (path_1010<path_0110) begin
		survivor_10 <= path_1010;
		temp_c10 <= 4'b1001;
	end
	else begin
		survivor_10 <= path_0110;
		temp_c10 <= 4'b0110;
	end
end

if(path_1001[7]==1 && path_0101[7]==1) begin
	if (path_1001 > path_0101) begin
		survivor_01 <= path_1001;
		temp_c01 <= 4'b1010;
	end
end
else if (path_1001[7]==1) begin
	survivor_01 <= path_1001;
	temp_c01 <= 4'b1010;
end
else if (path_0101[7]==1) begin
	survivor_01 <= path_0101;
	temp_c01 <= 4'b0101;
end

else begin
	if(path_1001>path_0101) begin
		survivor_01 <= path_0101;
		temp_c01 <= 4'b0101;
	end
	else begin
		survivor_01 <= path_1001;
		temp_c01 <= 4'b1010;
	end
end
end
endmodule
