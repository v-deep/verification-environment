class driver;
// vaise bnana toh agent chaiye tha before driver but sir ne agent bnaya nhi h toh we will make driver directly
virtual intf_io execute; // toh yha hum dekh skte h ki interface ke aage virtual likh rkha h
string name;
packet pkt2get;
reg payload_reset;
reg payload_data;
int number_packet = 21;
typedef mailbox #(packet) in_box_type;
in_box_type in_box;
typedef mailbox #(packet) out_box_type;
out_box_type out_box;
extern function new(string name = "driver", in_box_type in_box, out_box_type out_box, virtual intf_io execute);
extern virtual task start();
extern virtual task send();
endclass

function driver :: new(string name = "driver", in_box_type in_box, out_box_type out_box, virtual intf_io execute);
this.in_box = in_box;
this.out_box = out_box;
this.name = name;
this.execute = execute;
endfunction

// jo clocking block m data and reset se use maine map kiya h payload_data se and payload_reset se
// and other thing we noticed is we used non-blocking assignment
task driver::send();
execute.cb.data <= payload_data;
execute.cb.reset <= payload_reset;
endtask

task driver :: start();
int packet_sent = 0;
fork
//forever
for(int i = 0; i<number_packet; i++)
begin
in_box.get(pkt2get);
$display("in_box.num %d	%s pkt2get.name", in_box.num(), pkt2get.name);
this.payload_data = pkt2get.data;
$display("payload_reset = pkt2get.reset %d pkt2get.data %d", payload_reset, pkt2get.data);
send();
//pkt2send.name = $psprintf("driver [%0d]", packet_sent);
// thing to notice is humne chije join_none se chalayi h

out_box.put(pkt2get);
packet_sent ++;
//pkt2send.name = $psprintf("driver[%0d]", packet_sent);
//humne monitor aur checker yha scoreboard ke ander hi bna rkha h

$display("out_box.num %d pkt2get.data %d packet_sent %d", out_box.num(), pkt2get.data, packet_sent);
@(execute.cb);
end
join_none
endtask
