extern void uart_init();
extern char uart_try_read_byte();
extern int uart_send_byte(char c);
extern int get_hartid();
extern void set_msip(int hartid, int value);
extern int load_metadata(void* address);
extern void store_metadata(void* address, int value);
extern void user_event_0(void* address);
extern void user_event_1(void* address);
extern void user_event_2(void* address);
extern void user_event_3(void* address);
extern void user_event_4(void* address);
extern void user_event_5(void* address);
extern void user_event_6(void* address);
extern void user_event_7(void* address);
extern void user_event_8(void* address);
extern void user_event_9(void* address);
extern void user_event_10(void* address);
extern void user_event_11(void* address);
extern void user_event_12(void* address);
extern void user_event_13(void* address);
extern void user_event_14(void* address);
extern void user_event_15(void* address);

char getc();
int putc(char c);
int print_str(char* str);
int print_hex(char* hex, int size);