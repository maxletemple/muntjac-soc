#define UART_BASE 0x10000000

#define UART_RBR UART_BASE + 0x0000
#define UART_THR UART_BASE + 0x0000
#define UART_FCR UART_BASE + 0x0008
#define UART_LSR UART_BASE + 0x0014
#define UART_LCR UART_BASE + 0x000C
#define UART_DLL UART_BASE + 0x0000
#define UART_DLM UART_BASE + 0x0004

.global uart_init
.balign 16, 1
.type uart_init, @function
uart_init:
    addi sp, sp, -32
    sd s0, 24(sp)

    # Enable FIFO
    li t0, UART_FCR
    li t1, 7
    sw t1, 0(t0)

    # Enable DLAB access for config
    li t0, UART_LCR
    li t1, 0x80
    sw t1, 0(t0)

    # Configure baudrate to 230400
    li t0, UART_DLL
    li t1, 5
    sw t1, 0(t0)
    li t0, UART_DLM
    li t1, 0
    sw t1, 0(t0)

    # Disable DLAB access
    li t0, UART_LCR
    li t1, 3
    sw t1, 0(t0)

    ld s0, 24(sp)
    addi sp, sp, 32
    ret

.global uart_try_read_byte
.balign 16, 1
.type uart_try_read_byte, @function
uart_try_read_byte:
    addi sp, sp, -32

    li t0, UART_LSR # check if RBR has been transfered
    lw t1, 0(t0)
    andi t1, t1, 0x01
    beqz t1, _read_failed

    li t0, UART_RBR
    lw a0, 0(t0)
    j _read_end
    
_read_failed:
    li a0, 0

_read_end:
    addi sp, sp, 32
    ret

.global uart_send_byte
.balign 16, 1
.type uart_send_byte, @function
uart_send_byte:
    addi sp, sp, -32

_wait:
    li t0, UART_LSR # check if THR is empty
    lw t1, 0(t0)
    andi t1, t1, 0x20

    li t0, UART_THR
    sw a0, 0(t0)

    addi sp, sp, 32
    ret