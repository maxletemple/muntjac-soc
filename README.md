# Muntjac SoC

This repository contains a simple SoC that builds upon [muntjac](https://github.com/lowRISC/muntjac) that can be used out-of-the-box.

For a detailed walkthough about how to build/use this project, please check the [tutorial](./docs/tutorial.md).

## Components

The SoC contains the following components out of the box:
* 2 Muntjac cores
* Interrupt controller and timer (PLIC and CLINT)
* Flash memory controller[^1] (work in XIP mode)
* DDR memory controller[^1]
* UART 16550[^1]
* SD card controller
* PS/2 controller[^3]
* *(optional)* Ethernet controller[^2]
* *(optional)* Display controller[^3]

[^1]: Xilinx IP that comes with Vivado, but not open source
[^2]: Xilinx IP, not open source, separate license required
[^3]: For Nexys Video and Genesys 2 boards only

## Core complex architecture

The [core complex](rtl/ccx.sv) of this SoC is divided into the following modules:
* [rom_adapter](https://github.com/lowRISC/muntjac/blob/master/ip/tl/rtl/tl_adapter.sv), [mem_adapter](https://github.com/lowRISC/muntjac/blob/master/ip/tl/rtl/tl_adapter.sv) and [io_adapter](https://github.com/lowRISC/muntjac/blob/master/ip/tl/rtl/tl_adapter.sv) : adapter for TileLink links with different parameters
* [rom_term](https://github.com/lowRISC/muntjac/blob/master/ip/tl/rtl/tl_rom_terminator.sv), [mem_term](https://github.com/lowRISC/muntjac/blob/master/ip/tl/rtl/tl_ram_terminator.sv) and [io_term](https://github.com/lowRISC/muntjac/blob/master/ip/tl/rtl/tl_io_terminator.sv): TL-C bus (TileLink Cached) to TL-UL bus (TileLink Uncached Lightweight) converter
* [inst](https://github.com/lowRISC/muntjac/blob/master/ip/core/rtl/muntjac_llc.sv): L2 (last level cache) shared by all the cores
* [socket_1n](https://github.com/lowRISC/muntjac/blob/master/ip/tl/rtl/tl_socket_1n.sv): single to multiple TL bus converter
* [host_aggregator](https://github.com/lowRISC/muntjac/blob/master/ip/tl/rtl/tl_socket_m1.sv): multiple to single TL bus converter
* [core n](https://github.com/lowRISC/muntjac/blob/master/ip/core/rtl/muntjac_core.sv): one Muntjac RISC-V core
* [dcache_inst](https://github.com/lowRISC/muntjac/blob/master/ip/core/rtl/muntjac_dcache.sv): L1 data cache
* [icache_inst](https://github.com/lowRISC/muntjac/blob/master/ip/core/rtl/muntjac_icache.sv): L1 instruction cache
* [frontend](https://github.com/lowRISC/muntjac/blob/master/ip/pipeline/rtl/muntjac_frontend.sv): pipeline frontend (instruction cache related)
* [backend](https://github.com/lowRISC/muntjac/blob/master/ip/pipeline/rtl/muntjac_backend.sv): pipeline backend (data cache related)

![ccx](docs/assets/ccx_schem.svg)

## Supported Targets

Currently these FPGA boards are supported:
* Nexys A7
* Nexys Video
* Genesys 2

## Licensing

Unless otherwise noted, everything in this repository is dual-licensed in the MIT license and the Apache
License, Version 2.0. See [LICENSE-APACHE](./LICENSE-APACHE), [LICENSE-MIT](./LICENSE-MIT) for details.
