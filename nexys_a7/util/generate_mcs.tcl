set mode [lindex $argv 0]
set bootloader [lindex $argv 1]

if { $mode == "nobit" } {
  write_cfgmem -format mcs -size 16 -interface SPIx4 -loaddata {up 0x00800000 firmware.bin } -force -file firmware.mcs
} else {
  if { $bootloader == "firmware"} {
    write_cfgmem -format mcs -size 16 -interface SPIx4 -loadbit {up 0x00000000 bitstream.bit } -loaddata {up 0x00800000 firmware.bin } -force -file bitstream.mcs
  } else {
    write_cfgmem -format mcs -size 16 -interface SPIx4 -loadbit {up 0x00000000 bitstream.bit } -loaddata {up 0x00800000 bare_metal.bin } -force -file bitstream_bare.mcs
  }
}
