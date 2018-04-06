//final stage, eight FLOPs
module final_stage(CLK,r7,r8,END_00,END_11,END_10,END_01,temp_c00, temp_c11,temp_c110, temp_c001,codeword,shortest_path);
input CLK;
input[7:0] r7,r8,END_00,END_11,END_10,END_01; 
input[5:0] temp_c00, temp_c11,temp_c110, temp_c001;
output reg[7:0] codeword, shortest_path;

reg[7:0] m7,m8,path_1,path_2,path_3,path_4,min_path,edge_met,temp_codeword;
reg[7:0] one;


always@(posedge CLK) begin
one <= 8'b00010000;

temp_codeword <= {temp_c00,2'b00};
//edge metric calcs
m7 <= r7;
m8 <= r8;
m7[7] <= ~m7[7]; //bit flip, able to flip the sign of our created data structure without performing a FLOP.
m8[7] <= ~m8[7]; //bit flip, now just need to do bit shift.
m7 <= m7<<1; //bit shift by one is equal to multiply by 2 without performing an actual FLOP, now we have -2m metric
m8 <= m8<<1;

edge_met<= $signed(m7)+$signed(m8)+$signed(one);


//calculating final paths
path_1 <= END_00;
path_2 <= $signed(END_11)+$signed(edge_met);
path_3 <= $signed(END_10)+$signed(m7);
path_4 <= $signed(END_01)+$signed(m8);

//finding shortest path, one FLOP for each if statement (three FLOPs)

if ($signed(path_1)<$signed(path_2)&&$signed(path_1)<$signed(path_3)&&$signed(path_1)<$signed(path_4)) begin
min_path <= path_1;
temp_codeword <= {temp_c11, 2'b00};
end

else if ($signed(path_2)<$signed(path_1) && $signed(path_1)<$signed(path_1) && $signed(path_1)<path_4) begin
min_path <= path_2;
temp_codeword <= {temp_c11,2'b11};
end

else if ($signed(path_1)<$signed(path_1) && $signed(path_1)<$signed(path_1) && $signed(path_1)<path_4) begin
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
