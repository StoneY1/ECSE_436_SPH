//full butterfly stage edge metric module, six FLOPs for this component
module full_stage2_edge_bottom(CLK,r5,r6,temp_c10,temp_c01,survivor_10,survivor_01,END_10,END_01,temp_c110, temp_c001);
input CLK;
input[7:0] r5; input[7:0] r6;
input[7:0] survivor_10; input[7:0] survivor_01;
input[3:0] temp_c10; input[3:0] temp_c01;
output reg[7:0] END_10; output reg[7:0] END_01; 
output reg[5:0] temp_c110; output reg[5:0] temp_c001;

reg[7:0] m5; 
reg[7:0] m6;
reg[7:0] path_1001;
reg[7:0] path_1010;
reg[7:0] path_0110;
reg[7:0] path_0101;

always@(posedge CLK) begin
//calculating edge metrics
m5 <= r5;
m6 <= r6;
m5[7] <= ~m5[7]; //bit flip, able to flip the sign of our created data structure without performing a FLOP.
m6[7] <= ~m6[7]; //bit flip, now just need to do bit shift.
m5 <= m5<<1; //bit shift by one is equal to multiply by 2 without performing an actual FLOP, now we have -2m metric
m6 <= m6<<1;

if(m5[7]==1 && survivor_10[7]==1) begin
	path_1001 <= {1'b1,(m5[6:0]+survivor_10[6:0])}; //two FLOPs --> -2m1-2m2+1 = (-2m1)+(-2m2)+1
end else if (m5[7]==0 && survivor_10[7]==0) begin
	path_1001 <= {1'b0,(m5[6:0]+survivor_10[6:0])};  
end
else begin
	if (m5[6:0]>survivor_10[6:0]) begin
		path_1001 <= {m5[7],(m5[6:0]+survivor_10[6:0])}; 
	end
	else begin
		path_1001 <= {survivor_10[7],(m5[6:0]+survivor_10[6:0])};
	end
end

if(m6[7]==1 && survivor_10[7]==1) begin
	path_1010 <= {1'b1,(m6[6:0]+survivor_10[6:0])}; //two FLOPs --> -2m1-2m2+1 = (-2m1)+(-2m2)+1
end else if (m6[7]==0 && survivor_10[7]==0) begin
	path_1010 <= {1'b0,(m6[6:0]+survivor_10[6:0])};  
end
else begin
	if (m6[6:0]>survivor_10[6:0]) begin
		path_1010 <= {m6[7],(m6[6:0]+survivor_10[6:0])}; 
	end
	else begin
		path_1010 <= {survivor_10[7],(m6[6:0]+survivor_10[6:0])};
	end
end

if(m5[7]==1 && survivor_01[7]==1) begin
	path_0110 <= {1'b1,(m5[6:0]+survivor_01[6:0])}; //two FLOPs --> -2m1-2m2+1 = (-2m1)+(-2m2)+1
end else if (m5[7]==0 && survivor_01[7]==0) begin
	path_0110 <= {1'b0,(m5[6:0]+survivor_01[6:0])};  
end
else begin
	if (m5[6:0]>survivor_01[6:0]) begin
		path_0110 <= {m5[7],(m5[6:0]+survivor_01[6:0])}; 
	end
	else begin
		path_0110 <= {survivor_01[7],(m5[6:0]+survivor_01[6:0])};
	end
end

if(m6[7]==1 && survivor_01[7]==1) begin
	path_0110 <= {1'b1,(m6[6:0]+survivor_01[6:0])}; //two FLOPs --> -2m1-2m2+1 = (-2m1)+(-2m2)+1
end else if (m6[7]==0 && survivor_01[7]==0) begin
	path_0110 <= {1'b0,(m6[6:0]+survivor_01[6:0])};  
end
else begin
	if (m6[6:0]>survivor_01[6:0]) begin
		path_0110 <= {m6[7],(m6[6:0]+survivor_01[6:0])}; 
	end
	else begin
		path_0110 <= {survivor_01[7],(m6[6:0]+survivor_01[6:0])};
	end
end

//Now compare path lengths. One FLOP per if statement (two FLOPs)
if(path_1010[7]==1 && path_0110==1) begin
	if (path_1010 > path_0110) begin 
		END_10 <= path_1010;
		temp_c110 <= {temp_c10,2'b01};
	end
	else begin
		END_10 <= path_0110;
		temp_c110 <= {temp_c10,2'b10};
	end
end
else if(path_1010[7]==1) begin
	END_10 <= path_1010;
	temp_c110 <= {temp_c10,2'b01};
end
else if(path_0110) begin
	END_10 <= path_0110;
	temp_c110 <= {temp_c10,2'b10};
end
else begin
	if (path_1010 < path_0110) begin 
		END_10 <= path_1010;
		temp_c110 <= {temp_c10,2'b01};
	end
	else begin
		END_10 <= path_0110;
		temp_c110 <= {temp_c10,2'b10};
	end
end

if(path_1001[7]==1 && path_0101[7]==1) begin
	if (path_1001 > path_0101) begin
		END_01 <= path_1001;
		temp_c001 <= {temp_c01,2'b10};
	end
	else begin
		END_01 <= path_0101;
		temp_c001 <= {temp_c10,2'b01};
	end
end
else if(path_1001[7]==1) begin
	END_01 <= path_1001;
	temp_c001 <= {temp_c01,2'b10};
end
else if(path_0101[7]==1) begin
	END_01 <= path_0101;
	temp_c001 <= {temp_c10,2'b01};
end
else begin
	if (path_1001 < path_0101) begin
		END_01 <= path_1001;
		temp_c001 <= {temp_c01,2'b10};
	end
	else begin
		END_01 <= path_0101;
		temp_c001 <= {temp_c10,2'b01};
	end
end
end
endmodule
