//final stage, eight FLOPs
module final_stage(CLK,r7,r8,END_00,END_11,END_10,END_01,temp_c00, temp_c11,temp_c110, temp_c001,codeword,shortest_path);
input CLK;
input[7:0] r7,r8,END_00,END_11,END_10,END_01; 
input[5:0] temp_c00, temp_c11,temp_c110, temp_c001;
output reg[7:0] codeword, shortest_path;

reg[7:0] m7,m8,path_1,path_2,path_3,path_4,min_path,edge_met,temp_codeword;


always@(posedge CLK) begin
path_1 <= END_00;
min_path <= path_1;
temp_codeword <= {temp_c00,00};
//edge metric calcs
m7 <= r7;
m8 <= r8;
m7[7] <= ~m7[7]; //bit flip, able to flip the sign of our created data structure without performing a FLOP.
m8[7] <= ~m8[7]; //bit flip, now just need to do bit shift.
m7 <= m7<<1; //bit shift by one is equal to multiply by 2 without performing an actual FLOP, now we have -2m metric
m8 <= m8<<1;
edge_met <= m7+m8+8'b00010000; //two FLOPs --> -2m1-2m2+1 = (-2m1)+(-2m2)+1
//calculating final paths
path_2 <= END_11+edge_met; //one FLOP
path_3 <= END_10+m7; //one FLOP
path_4 <= END_01+m8; //one FLOP

//finding shortest path, one FLOP for each if statement (three FLOPs)
if (min_path>path_2) begin
min_path <= path_2;
temp_codeword <= {temp_c11,11};
end

if (min_path>path_3) begin
min_path <= path_3;
temp_codeword <= {temp_c110,10};
end

if (min_path>path_4) begin
min_path <= path_4;
temp_codeword <= {temp_c001,01};
end

codeword <= temp_codeword;
shortest_path <= min_path;
end
endmodule
