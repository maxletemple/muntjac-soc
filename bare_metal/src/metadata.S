#define UEVT(n) .word (n << 20) + 0x0002a28b

.global load_metadata
.balign 16,1
.type load_metadata, @function
load_metadata:
    lw a0, 0(a0)
    nop
    nop
    .word 0x0005850b
    nop
    nop
    ret

.global store_metadata
.balign 16,1
.type store_metadata, @function
store_metadata:
    lw t0, 0(a0)
    nop
    nop
    .word 0x00b5150b
    nop
    nop
    sw t0, 0(a0)
    ret

.global user_event_0
.balign 16,1
.type user_event_0, @function
user_event_0:
    lw t0, 0(a0)
    nop
    nop
    UEVT(0)
    nop
    nop
    sw t0, 0(a0)
    ret

.global user_event_1
.balign 16,1
.type user_event_1, @function
user_event_1:
    lw t0, 0(a0)
    nop
    nop
    UEVT(1)
    nop
    nop
    sw t0, 0(a0)
    ret

.global user_event_2
.balign 16,1
.type user_event_2, @function
user_event_2:
    lw t0, 0(a0)
    nop
    nop
    UEVT(2)
    nop
    nop
    sw t0, 0(a0)
    ret

.global user_event_3
.balign 16,1
.type user_event_3, @function
user_event_3:
    lw t0, 0(a0)
    nop
    nop
    UEVT(3)
    nop
    nop
    sw t0, 0(a0)
    ret

.global user_event_4
.balign 16,1
.type user_event_4, @function
user_event_4:
    lw t0, 0(a0)
    nop
    nop
    UEVT(4)
    nop
    nop
    sw t0, 0(a0)
    ret

.global user_event_5
.balign 16,1
.type user_event_5, @function
user_event_5:
    lw t0, 0(a0)
    nop
    nop
    UEVT(5)
    nop
    nop
    sw t0, 0(a0)
    ret

.global user_event_6
.balign 16,1
.type user_event_6, @function
user_event_6:
    lw t0, 0(a0)
    nop
    nop
    UEVT(6)
    nop
    nop
    sw t0, 0(a0)
    ret

.global user_event_7
.balign 16,1
.type user_event_7, @function
user_event_7:
    lw t0, 0(a0)
    nop
    nop
    UEVT(7)
    nop
    nop
    sw t0, 0(a0)
    ret

.global user_event_8
.balign 16,1
.type user_event_8, @function
user_event_8:
    lw t0, 0(a0)
    nop
    nop
    UEVT(8)
    nop
    nop
    sw t0, 0(a0)
    ret

.global user_event_9
.balign 16,1
.type user_event_9, @function
user_event_9:
    lw t0, 0(a0)
    nop
    nop
    UEVT(9)
    nop
    nop
    sw t0, 0(a0)
    ret

.global user_event_10
.balign 16,1
.type user_event_10, @function
user_event_10:
    lw t0, 0(a0)
    nop
    nop
    UEVT(10)
    nop
    nop
    sw t0, 0(a0)
    ret

.global user_event_11
.balign 16,1
.type user_event_11, @function
user_event_11:
    lw t0, 0(a0)
    nop
    nop
    UEVT(11)
    nop
    nop
    sw t0, 0(a0)
    ret

.global user_event_12
.balign 16,1
.type user_event_12, @function
user_event_12:
    lw t0, 0(a0)
    nop
    nop
    UEVT(12)
    nop
    nop
    sw t0, 0(a0)
    ret

.global user_event_13
.balign 16,1
.type user_event_13, @function
user_event_13:
    lw t0, 0(a0)
    nop
    nop
    UEVT(13)
    nop
    nop
    sw t0, 0(a0)
    ret

.global user_event_14
.balign 16,1
.type user_event_14, @function
user_event_14:
    lw t0, 0(a0)
    nop
    nop
    UEVT(14)
    nop
    nop
    sw t0, 0(a0)
    ret

.global user_event_15
.balign 16,1
.type user_event_15, @function
user_event_15:
    lw t0, 0(a0)
    nop
    nop
    UEVT(15)
    nop
    nop
    sw t0, 0(a0)
    ret