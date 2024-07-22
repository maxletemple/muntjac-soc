#include "util.h"

#define  WAIT(n) for(int i = 0; i < (n) ; i++) asm volatile ("nop");
#define LOAD_META(val, dest) asm volatile ("mv t0, %0\n" \
                                            ".word 0x0002830b\n" \
                                            "mv %1, t1\n" \
                                            : : "rw" (val), "rw" (dest) : "t0", "t1");

int main_hart0(){

    int *ptr = (int*) 0x40000000;

    asm volatile ("mv t0, %0\n"
                    ".word 0x0002a28b\n"
                    "fence rw, rw\n"
                    ".word 0x0002830b\n"
                    "mv %0, t1\n"
                    : "=r" (*ptr)
                    : "rw" (*ptr) : "t0");
    (*ptr) ++;
    return 0;
}

int main_hart1(){


    return 0;
}