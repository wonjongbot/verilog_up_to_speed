#include <verilatedos.h>
#include <stdio.h>
#include <fcntl.h>
#include <unistd.h>
#include <string.h>
#include <time.h>
#include <sys/types.h>
#include <signal.h>
#include "verilated.h"
#include "Vuart.h"
#include "testb.h"

int	main(int argc, char **argv) {
	Verilated::commandArgs(argc, argv);
	TESTB<Vuart>	*tb
		= new TESTB<Vuart>;
	unsigned	divisor  = 325;
    char* input = "Hello World!";
    int stri = 0;

    tb->m_core->divisor = divisor;

	tb->opentrace("uart.vcd");

    tb->m_core->i_rst_n = 0;
    tb->m_core->tx_din = input[0];
    for(unsigned c = 0; c < 10; c++)
        tb->tick();
    tb->m_core->i_rst_n = 1;
    for(unsigned c = 0; c < 10; c++)
        tb->tick();
        
	for(unsigned clocks=0; clocks < 16*divisor*10*12; clocks++) {
		tb->tick();
        if(!(tb->m_core->o_tx_busy)){
            printf("input: %c\n",tb->m_core->tx_din);
            tb->m_core->tx_din = *(input + (++stri % 12));}
        if(!(tb->m_core->o_rx_busy)){
            printf("output: %c\n",tb->m_core->rx_dout);
        }
	}

	printf("\n\nSimulation complete\n");
}