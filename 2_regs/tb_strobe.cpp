#include <stdio.h>
#include <stdlib.h>
#include <iostream>
#include "Vstrobe.h"
#include "verilated.h"
#include "verilated_vcd_c.h"

void tick(unsigned int tickcnt, Vstrobe* tb, VerilatedVcdC* tfp){
    tb->eval();
    if(tfp)
        tfp->dump(tickcnt * 10 - 2); // dump 2ns before the tick
    tb->i_clk = 1;
    tb->eval();
    if(tfp)
        tfp->dump(tickcnt * 10);
    tb->i_clk = 0;
    tb->eval();
    if(tfp){
        tfp->dump(tickcnt * 10 + 5);
        tfp->flush();
    }
}

int main(int argc, char **argv){
    Verilated::commandArgs(argc, argv);

    int last_led = 0;
    unsigned int tickcnt = 0;

    Vstrobe *tb = new Vstrobe;
    Verilated::traceEverOn(true);
    VerilatedVcdC* tfp = new VerilatedVcdC;
    tb->trace(tfp, 99);
    tfp->open("strobe_trace.vcd");

    for(int k = 0; k < (1<<20); k++){
        tick(++tickcnt, tb, tfp);

        if(last_led != tb->o_led){
            printf("k = %7x, ", k);
            printf("led = %d\n", tb->o_led);
        }
        last_led = tb->o_led;
    }
}