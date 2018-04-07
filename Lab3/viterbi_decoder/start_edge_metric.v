//Edge metric calculator, two FLOPs in this stage
module start_edge_metric(CLK, r1, r2, edge_00, edge_11, edge_10, edge_01);
input CLK;
input [7:0] r1;
input [7:0] r2;
output reg[7:0] edge_00;
output reg[7:0] edge_11;
output reg[7:0] edge_10;
output reg[7:0] edge_01;
reg[7:0] m1;
reg[7:0] m2;
reg[7:0] one;

//always@(posedge CLK) begin
always@* begin
edge_00 <= 8'd0;
one <= 8'b00010000;

m1 <= r1<<1; //bit shift by one is equal to multiply by 2 without performing an actual FLOP, now we have -2m metric
m2 <= r2<<1;
m1[7] <= ~r1[7]; //bit flip, able to flip the sign of our created data structure without performing a FLOP.
m2[7] <= ~r2[7]; //bit flip, now just need to do bit shift.

edge_10 <= m1;
edge_01 <= m2;

if(m1[7]==1 && m2[7]==1) begin
	edge_11 <= {1'b1,(m1[6:0]+m2[6:0])}+one; //two FLOPs --> -2m1-2m2+1 = (-2m1)+(-2m2)+1
end else if (m1[7]==0 && m2[7]==0) begin
	edge_11 <= {1'b0,(m1[6:0]+m2[6:0])}+one; 
end
else begin
	if (m1[6:0]>m2[6:0]) begin
		edge_11 <= {m1[7],(m1[6:0]-m2[6:0])}+one;
	end
	else begin
		edge_11 <= {m2[7],(m2[6:0]-m1[6:0])}+one;
	end
end

end
endmodule
