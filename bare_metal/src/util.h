extern void uart_init();
extern char uart_try_read_byte();
extern int uart_send_byte(char c);
extern int get_hartid();
extern void set_msip(int hartid, int value);
extern int load_metadata(void* address);
extern void store_metadata(void* address, int value);
extern void user_event_0(void* address);
extern void user_event_1(void* address);

char getc();
int putc(char c);
int print_str(char* str);
int print_hex(char* hex, int size);