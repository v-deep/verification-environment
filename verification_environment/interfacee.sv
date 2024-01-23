// our first step was to make a design then 2nd step is to make an interface and then 3rd step is to make an generator then agent and then driver 
interface intf_io(input bit clk);
logic reset;
logic data;
logic [3:0] count;
// single design h toh no need of interface 

// ek baar puchiyo ki sir yha kya keh rhe the , means interface hi btaya tha ya kuch aur
//also discuss about clocking block means how we decide i/p - o/p of a clocking block 

// since es design m clock h so we will need a clocking block also
clocking cb @(posedge clk);
output reset;
output data;
input count;
endclocking

endinterface

