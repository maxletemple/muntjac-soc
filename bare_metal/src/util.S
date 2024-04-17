.global get_hartid
.balign 16, 1
.type get_hartid, @function
get_hartid:
    addi sp, sp, -32

    csrr a0, mhartid

    addi sp, sp, 32
    ret

.global set_msip
.balign 16, 1
.type set_msip, @function
set_msip:
    addi sp, sp, -32

    /*  a0: hartid
        a1: value to set

        desc: enables software interrupt. Used to start a core.
    */

    li t0, 0x11400000
    slli t1, a0, 2
    add t0, t0, t1
    sw a1, 0(t0)
    
    li a0, 0

    addi sp, sp, 32
    ret

.global set_start_address
.balign 16, 1
.type set_start_address, @function
set_start_address:
    addi sp, sp, -32

    /*  a0: address

        desc: sets the pc. Does not start
    */

    addi sp, sp, 32
    ret