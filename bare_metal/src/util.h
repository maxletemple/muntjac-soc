extern void uart_init();
extern char uart_try_read_byte();
extern int uart_send_byte(char c);
extern int get_hartid();
extern void set_msip(int hartid, int value);

char getc();
int putc(char c);
int print_str(char* str);
int print_hex(char* hex, int size);