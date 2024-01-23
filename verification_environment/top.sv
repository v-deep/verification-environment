module execute_test_top;
parameter simulation_cycle = 10;
reg sysclock;
initial
begin
sysclock = 0;
forever begin
#(simulation_cycle/2)
sysclock = ~sysclock;
end
end

intf_io execute(sysclock);
execute_test test(execute);
one_counter dut(
.clk(execute.clk), // bcz hum toh jo bhi mapping karge dut se use interface ke through hi dege
.data(execute.data),
.reset(execute.reset),
.count(execute.count)
);

endmodule

