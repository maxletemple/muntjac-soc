SOURCES = $(wildcard src/*)

bare_metal.elf:
	riscv64-linux-gnu-gcc -Wno-builtin-declaration-mismatch -T linker.ld -Wl,--build-id=none,--eh-frame-hdr -nostartfiles -o build/bare_metal.elf $(SOURCES) 