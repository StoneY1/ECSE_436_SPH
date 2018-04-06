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

always@(posedge CLK) begin
edge_00 <= 8'd0;
one <= 8'b00010000;
m1 <= r1;
m2 <= r2;
m1[7] <= ~m1[7]; //bit flip, able to flip the sign of our created data structure without performing a FLOP.
m2[7] <= ~m2[7]; //bit flip, now just need to do bit shift.
m1 <= m1<<1; //bit shift by one is equal to multiply by 2 without performing an actual FLOP, now we have -2m metric
m2 <= m2<<1;

edge_10 <= m1;
edge_01 <= m2;

edge_11 <= $signed(m1)+$signed(m2)+$signed(one); //two FLOPs --> -2m1-2m2+1 = (-2m1)+(-2m2)+1

end
endmodule
