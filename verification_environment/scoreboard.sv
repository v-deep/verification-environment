class scoreboard;
string name; // unique identifier
bit [3:0] store;
typedef mailbox #(packet) out_box_type;
out_box_type out_box;// mailbox for packet object from drivers

extern function new(string name = "scoreboard", out_box_type  out_box = null);
endclass

function scoreboard::new(string name = "scoreboard", out_box_type  out_box = null);
this.name = name;
if(out_box == null)
out_box = new();
else this.out_box = out_box;
endfunction


