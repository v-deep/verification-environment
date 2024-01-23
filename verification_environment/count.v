module one_counter(clk, reset, data, count);
input clk, reset, data;
output reg[3:0] count;

always@(posedge clk)
if(!reset)
count <= 0;
else if(count == 15)
count<= 4'b0;
else if(data ==1)
count <= count + 4'b1;
endmodule

