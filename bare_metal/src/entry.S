#define MEMORY_BASE 0x40000000
#define MEMORY_SIZE 0x07e00000
#define MEMORY_LIMIT MEMORY_BASE + MEMORY_SIZE

.extern main

.section .text.start
.option arch, +zicsr
.globl _start
_start:
.type _start, @function
.option push
.option norelax

    # Initialise all registers to zero
    li x1, 0
    li x2, 0
    li x3, 0
    li x4, 0
    li x5, 0
    li x6, 0
    li x7, 0
    li x8, 0
    li x9, 0
    li x10, 0
    li x11, 0
    li x12, 0
    li x13, 0
    li x14, 0
    li x15, 0
    li x16, 0
    li x17, 0
    li x18, 0
    li x19, 0
    li x20, 0
    li x21, 0
    li x22, 0
    li x23, 0
    li x24, 0
    li x25, 0
    li x26, 0
    li x27, 0
    li x28, 0
    li x29, 0
    li x30, 0
    li x31, 0

    csrr s0, mhartid
    bnez s0, .secondary_start

    # lla a0, __data_start
    # lla a1, __data_rom_start
    # lla a2, __data_size
    # call memcpy

    j .relocated


.secondary_start:
    csrwi mie, 1 << 3

# 1:
#     # Wait until MSIP to fire
#     wfi
#     csrr t0, mip
#     andi t0, t0, 1 << 3
#     beqz t0, 1b

.relocated:

    li sp, MEMORY_LIMIT
    slli t0, s0, 14
    sub sp, sp, t0


    beqz s0, _hart0
    j _hart1

_hart0:
    call main_hart0
    j _end
_hart1:
    call main_hart1
    j _end
    
_end:
    j _end
