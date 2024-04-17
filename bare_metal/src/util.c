#include "util.h"

int print_str(char* str){
    int i = 0;
    while (str[i] != '\0'){
        uart_send_byte(str[i]);
        i++;
    }
    return 0;
}

int print_hex(char* hex, int size){
    char buffer;
    for (int i = 0; i < 2 * size; i++){
        if (i % 2 == 0) buffer = hex[i/2] >> 4;
        else buffer = hex[i/2] & 0x0f;

        if (buffer < 10) putc(buffer + 48);
        else putc(buffer + 97 - 10);
    }
}

char getc(){
    return uart_try_read_byte();
}

int putc(char c){
    return uart_send_byte(c);
}