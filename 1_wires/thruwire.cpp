#include <stdio.h>
#include <stdlib.h>
#include <iostream>
#include "Vthruwire.h"
#include "verilated.h"

int main(int argc, char **argv){
    Verilated::commandArgs(argc, argv);

    Vthruwire *tb = new Vthruwire;

    while(true){
        std::cin >> tb->i_rx;
        tb->eval();
        printf("input: %c => ", tb->i_rx);
        printf("output: %c\n", tb->o_tx);
        char output = tb->o_tx;
        if(output == 'q'){
            printf("Ending tx->rx sim!\n");
            break;
        }
    }
    // for(int k = 0; k < 32; k++){
    //     tb->i_sw = k&1;
    //     tb->eval();

    //     printf("k = %2d, ", k);
    //     printf("sw = %d, ", tb->i_sw);
    //     printf("led = %d\n", tb->o_led);
    // }
}