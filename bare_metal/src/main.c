#include "util.h"

 

char bonjour[] = "Hello World !";

#define  WAIT(n) for(int i = 0; i < (n) ; i++) asm volatile ("nop");

int main_hart0(){
    //uart_init();

    // char c;
    // while (1)
    // {
    //     c = getc();
    //     if ( c == '1') set_msip(1, 1);
    //     if ( c != '\0') putc(c);
    // }

    // set_msip(1, 1);

    int* leds0 = (int*) 0x00001000;
    *leds0 = 1;

    WAIT(2);

    //*leds0 = 42;

    for (int i = 0; i < 10000; i++){
         *leds0 += 1;
    }

    return 0;
}

int main_hart1(){
    int* leds1 = (int*) 0x00001000;
    *leds1 |= 1<<1;


    for (int i = 0; i < 10000; i++){
         *leds1 += 1;
    }

    return 0;
}