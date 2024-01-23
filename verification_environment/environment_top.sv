//`include "interface.sv"
//`include "scoreboard.sv"
program execute_test(intf_io execute); // verification environment hum program block se likhte h esliye program block use kiya h
// generally checker scoreboard m hi hota h aur monitor bhar hota h

generator generator;
driver drvr;
scoreboard sb;
packet pkt2send;
int number_packet;
int packet_got = 0;
reg[3:0] count_cmp;
reg [3:0] temp;
initial
begin
number_packet = 21;
generator = new("generator" , number_packet);
sb = new();
reset();
drvr = new("drvr[0]", generator.in_box , sb.out_box, execute);
generator.start();
drvr.start();
fork recv();
join
repeat(number_packet + 1)
@(execute.cb);
end

task reset();
@(execute.cb);
execute.cb.reset <= 1'b0;
//execute.cb.count <= 4'b0; // hum testbench ke o/p ko drive nhi kar skte
@(execute.cb);
execute.cb.reset <= 1'b1;
endtask

task recv(); // works like monitor i.e. task recieve
@(execute.cb);// means ek posedge of clock ko hum chod rhe h
repeat(number_packet)
begin
@(execute.cb)
//apko help karne ke liye step by step debugging h so that will help you
get_payload();
check();
end
endtask

task get_payload(); // ye ek tarike se monitor h
count_cmp = execute.cb.count;
endtask

task check();
//checker humne vaise hi bna rkha h like scoreboard se hum chije nikalte h aur use ek variable m sy=tore karvate h
if(sb.out_box.num() != 0)
begin
sb.out_box.get(pkt2send);
$display("get value from scoreboard pkt2send.data %d ", pkt2send.data);
// if(pkt2send.reset)
//begin
sb.store = sb.store + pkt2send.data;
//end
$display($time, "ns count_cmp : %b , my_count : %b", count_cmp, sb.store);
end
endtask
endprogram
