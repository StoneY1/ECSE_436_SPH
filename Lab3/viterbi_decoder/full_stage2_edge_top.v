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

always@(posedge CLK) begin
//calculating edge metrics
m5 <= r5;
m6 <= r6;
m5[7] <= ~m5[7]; //bit flip, able to flip the sign of our created data structure without performing a FLOP.
m6[7] <= ~m6[7]; //bit flip, now just need to do bit shift.
m5 <= m5<<1; //bit shift by one is equal to multiply by 2 without performing an actual FLOP, now we have -2m metric
m6 <= m6<<1;

if(m5[7]==1 && m6[7]==1) begin
	edge_met <= {1'b1,(m5[6:0]+m6[6:0])}+8'b00010000; //two FLOPs --> -2m1-2m2+1 = (-2m1)+(-2m2)+1
end else if (m5[7]==0 && m6[7]==0) begin
	edge_met <= {1'b0,(m5[6:0]+m6[6:0])}+8'b00010000; 
end
else begin
	if (m5[6:0]>m6[6:0]) begin
		edge_met <= {m5[7],(m5[6:0]+m6[6:0])}+8'b00010000;
	end
	else begin
		edge_met <= {m6[7],(m5[6:0]+m6[6:0])}+8'b00010000;
	end
end

if(edge_met[7]==1 && survivor_00[7]==1) begin
	path_011 <= {1'b1,(edge_met[6:0]+survivor_00[6:0])}; //two FLOPs --> -2m1-2m2+1 = (-2m1)+(-2m2)+1
end else if (edge_met[7]==0 && survivor_00[7]==0) begin
	path_011 <= {1'b0,(edge_met[6:0]+survivor_00[6:0])};  
end
else begin
	if (edge_met[6:0]>survivor_00[6:0]) begin
		path_011 <= {edge_met[7],(edge_met[6:0]+survivor_00[6:0])}; 
	end
	else begin
		path_011 <= {survivor_00[7],(edge_met[6:0]+survivor_00[6:0])};
	end
end

if(edge_met[7]==1 && survivor_11[7]==1) begin
	path_100 <= {1'b1,(edge_met[6:0]+survivor_11[6:0])}; //two FLOPs --> -2m1-2m2+1 = (-2m1)+(-2m2)+1
end else if (edge_met[7]==0 && survivor_11[7]==0) begin
	path_011 <= {1'b0,(edge_met[6:0]+survivor_11[6:0])};  
end
else begin
	if (edge_met[6:0]>survivor_11[6:0]) begin
		path_100 <= {edge_met[7],(edge_met[6:0]+survivor_11[6:0])}; 
	end
	else begin
		path_100 <= {survivor_11[7],(edge_met[6:0]+survivor_11[6:0])};
	end
end

//Now compare path lengths. One FLOP for each if statement (two FLOPs)
if(path_011[7]==1 && survivor_11[7]==1) begin
	if (path_011>survivor_11) begin //if MSB is 1, edge is negative and is shorter
		END_11 <= path_011;
		temp_c11 <= {temp_c0,2'b11};
	end
	else begin
		END_11 <= survivor_11;
		temp_c11 <= {temp_c0,2'b00};
	end
end
else if (path_011[7]==1) begin
	END_11 <= path_011;
	temp_c11 <= {temp_c0,2'b11};
end
else if (survivor_11[7]==1) begin
	END_11 <= survivor_11;
	temp_c11 <= {temp_c0,2'b00};
end
else begin
	if (path_011<survivor_11) begin //if MSB is 1, edge is negative and is shorter
		END_11 <= path_011;
		temp_c11 <= {temp_c0,2'b11};
	end
	else begin
		END_11 <= survivor_11;
		temp_c11 <= {temp_c0,2'b00};
	end
end

if(path_100[7]==1 && survivor_00[7]==1) begin
	if (path_100 > survivor_00) begin
		END_00 <= path_100;
		temp_c00 <= {temp_c1,2'b11};
	end
	else begin
		END_00 <= 8'd0;
		temp_c00 <= {temp_c1,2'b00};
	end
end
else if(path_100[7]==1) begin
	END_00 <= path_100;
	temp_c00 <= {temp_c1,2'b11};
end
else if(survivor_00[7]==1) begin
	END_00 <= 8'd0;
	temp_c00 <= {temp_c1,2'b00};
end
else begin
	if (path_100 < survivor_00) begin
		END_00 <= path_100;
		temp_c00 <= {temp_c1,2'b11};
	end
	else begin
		END_00 <= 8'd0;
		temp_c00 <= {temp_c1,2'b00};
	end
end
end
endmodule
