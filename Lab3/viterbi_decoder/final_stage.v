//final stage, eight FLOPs
module final_stage(CLK,r7,r8,END_00,END_11,END_10,END_01,temp_c00, temp_c11,temp_c110, temp_c001,codeword,shortest_path);
input CLK;
input[7:0] r7,r8,END_00,END_11,END_10,END_01; 
input[5:0] temp_c00, temp_c11,temp_c110, temp_c001;
output reg[7:0] codeword, shortest_path;

reg[7:0] m7,m8,path_1,path_2,path_3,path_4,min_path,edge_met,temp_codeword;
reg[7:0] one;


<<<<<<< HEAD
always@(posedge CLK) begin
path_1 <= END_00;
min_path <= path_1;
=======
//always@(posedge CLK) begin
always@* begin
one <= 8'b00010000;

>>>>>>> StoneY
temp_codeword <= {temp_c00,2'b00};
//edge metric calcs
m7 <= r7<<1; //bit shift by one is equal to multiply by 2 without performing an actual FLOP, now we have -2m metric
m8 <= r8<<1;
m7[7] <= ~r7[7]; //bit flip, able to flip the sign of our created data structure without performing a FLOP.
m8[7] <= ~r8[7]; //bit flip, now just need to do bit shift.

//edge_met = m7 + m8 + one
if(m7[7]==1 && m8[7]==1) begin
	edge_met <= {1'b1,(m7[6:0]+m8[6:0])}+one; //two FLOPs --> -2m1-2m2+1 = (-2m1)+(-2m2)+1
end else if (m7[7]==0 && m8[7]==0) begin
	edge_met <= {1'b0,(m7[6:0]+m8[6:0])}+one; 
end
else begin
	if (m7[6:0]>m8[6:0]) begin
		edge_met <= {m7[7],(m7[6:0]-m8[6:0])}+one;
	end
	else begin
		edge_met <= {m8[7],(m8[6:0]-m7[6:0])}+one;
	end
end

//calculating final paths
path_1 <= END_00;
//path_2 = END_11 + edge_met
if(END_11[7]==1 && edge_met[7]==1) begin
	path_2 <= {1'b1,(END_11[6:0]+edge_met[6:0])}; 
end else if (END_11[7]==0 && edge_met[7]==0) begin
	path_2 <= {1'b0,(END_11[6:0]+edge_met[6:0])};  
end
else begin
	if (END_11[6:0]>edge_met[6:0]) begin
		path_2 <= {END_11[7],(END_11[6:0]-edge_met[6:0])}; 
	end
	else begin
		path_2 <= {edge_met[7],(edge_met[6:0]-END_11[6:0])};
	end
end

//path_3 = END_10 + m7
if(END_10[7]==1 && m7[7]==1) begin
	path_3 <= {1'b1,(END_10[6:0]+m7[6:0])}; 
end else if (END_10[7]==0 && m7[7]==0) begin
	path_3 <= {1'b0,(END_10[6:0]+m7[6:0])};  
end
else begin
	if (END_10[6:0]>m7[6:0]) begin
		path_3 <= {END_10[7],(END_10[6:0]-m7[6:0])}; 
	end
	else begin
		path_3 <= {m7[7],(m7[6:0]-END_10[6:0])};
	end
end

//path_4 = END_01 + m8
if(END_01[7]==1 && m8[7]==1) begin
	path_4 <= {1'b1,(END_01[6:0]+m8[6:0])}; 
end else if (END_01[7]==0 && m8[7]==0) begin
	path_4 <= {1'b0,(END_01[6:0]+m8[6:0])};  
end
else begin
	if (END_01[6:0]>m8[6:0]) begin
		path_4 <= {END_01[7],(END_01[6:0]-m8[6:0])}; 
	end
	else begin
		path_4 <= {m8[7],(m8[6:0]-END_01[6:0])};
	end
end

//finding shortest path, one FLOP for each if statement (three FLOPs)

if ($signed(path_1)<$signed(path_2)&&$signed(path_1)<$signed(path_3)&&$signed(path_1)<$signed(path_4)) begin
min_path <= path_1;
temp_codeword <= {temp_c00, 2'b00};
end

else if ($signed(path_2)<$signed(path_1) && $signed(path_2)<$signed(path_3) && $signed(path_2)<path_4) begin
min_path <= path_2;
temp_codeword <= {temp_c11,2'b11};
end

else if ($signed(path_3)<$signed(path_1) && $signed(path_3)<$signed(path_2) && $signed(path_3)<path_4) begin
min_path <= path_3;
temp_codeword <= {temp_c110,2'b10};
end

else begin
min_path <= path_4;
temp_codeword <= {temp_c001,2'b01};
end

codeword <= temp_codeword;
shortest_path <= min_path;
end
endmodule
