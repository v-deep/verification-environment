class packet; // so this is how we make transaction class
randc bit data;
bit reset;
string name;
extern function new(string name  = "packet");
endclass

function packet ::new(string name = "packet"); // eske maddat se packet ke piche number lga duga ki konsa no. ka packet h ye
this.name = name;
endfunction

class generator;
// generator , driver aur agent ka mailbox ek hi hota h aur mailbox top m hota h

string name;
packet pkt2send;
typedef mailbox #(packet) in_box_type; // accept only packet datatype
in_box_type in_box = new(); // unbounded mailbox as we have used new() not anything like new(5)
int packet_number; // no. of that particular packet
int number_packet; //no. of packet 
extern function new( string name = "generator", int number_packet);
extern virtual task start();

// why we made the above func. as virtual

endclass

function generator :: new(string name = "generator", int number_packet);
this.name = name;
this.packet_number = 0;
this.number_packet = number_packet;
endfunction

//use of sprintf

task generator :: start();
fork
for(int i = 0; i<number_packet; i++)
begin
pkt2send = new();
pkt2send.name = $psprintf("packet[%0d]", packet_number++); // post increment h means phele value bhej dege fir increment hoga so the first value it will send is 0 (not 1) and after sending 0 it will become 1 for next iteration

// did we used here printf or sprintf

$display("in generator in_box.num %d	%s pkt2send.name", in_box.num(), pkt2send.name); // in box.num = tells ki kitne packet hai h abhi inside mailbox
// 2 class ke bich mailbox lekin what about 2 module ke bich, means kya hum 2 interface use karege
if(pkt2send.randomize())
begin
$display("%d data randomize reset is %d", pkt2send.data, pkt2send.reset);
// yha mailbox esliye use kar rhe h instead of queue bcz hume class pass karni h toh mailbox hi kaam aayega
in_box.put(pkt2send);
$display("in_box.num %d", in_box.num());
// use mu option to compile multiple file at same time
end
end
join_none
// one thing to notice is we have used here join_none
endtask
