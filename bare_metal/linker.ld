OUTPUT_FORMAT("elf64-littleriscv")
OUTPUT_ARCH(riscv)
ENTRY(_start)

__ramStart = 0x00001000;
__romStart = 0x00000000;

__ramSize  = 0x07ffffff;
__romSize  = 0x01ffffff;

MEMORY
{
  ROM (rx) : ORIGIN = __romStart, LENGTH = __romSize
  RAM (xrw): ORIGIN = __ramStart, LENGTH = __ramSize
}

SECTIONS
{
  . = 0;

  .text.startup : {
    *(.text.start)
  }

  .text : {
    *(.text)
  } > ROM

  .rodata : {
    *(.rodata*)
  } > ROM
  
  .data : {
    __data_start = . ;
    *(.data*)
    __data_end = . ;
  } > RAM AT > ROM
  
  .bss (NOLOAD) : {
    *(.bss*)
  } > RAM AT > ROM

  __data_rom_start = LOADADDR(.data);
  __data_size = __data_end - __data_start;

  /DISCARD/ : {
  *(.interp)
  *(.dynsym)
  *(.dynstr)
  *(.hash)
  *(.gnu.hash)
  }

  _end = .;

}

