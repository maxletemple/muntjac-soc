#define UEVT(n) .word (n << 20) + 0x0002a28b

.global user_event_0
.balign 16,1
.type user_event_0, @function
user_event_0:
    lw t0, 0(a0)
    UEVT(0)
    sw t0, 0(a0)
    ret

.global user_event_1
.balign 16,1
.type user_event_1, @function
user_event_1:
    lw t0, 0(a0)
    UEVT(1)
    sw t0, 0(a0)
    ret