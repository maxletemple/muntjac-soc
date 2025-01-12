if {[info exists env(PART)]} {
    set part $env(PART)
} else {
    puts "ERROR: FPGA part not specified"
    exit 1
}

if {[info exists env(CFGMEM_PART)]} {
    set cfgmem_part $env(CFGMEM_PART)
} else {
    puts "ERROR: Flash memory part not specified"
    exit 1
}

if {[info exists env(PROGRAM)]} {
    set program $env(PROGRAM)
} else {
    puts "ERROR: MCS file not specified"
    exit 1
}

# Connect to Xilinx Hardware Server
if { [ catch { open_hw_manager } ] } { open_hw }

if {[info exists env(HW_SERVER)]} {
    connect_hw_server -url $env(HW_SERVER) -allow_non_jtag
} else {
    connect_hw_server
}

set hw_targets [get_hw_targets]

if { [llength $hw_targets] == 0 } {
    puts "ERROR: Failed to find any targets"
    exit 1
}

# Find the first target and device that contains a FPGA $part.
set hw_device_found 0
foreach hw_target $hw_targets {
    puts "NFO: Trying to use hardware target $hw_target"
    current_hw_target $hw_target

    # Open hardware target
    # The Vivado hardware server isn't always able to reliably open a target.
    # Try three times before giving up.
    set hw_target_opened 0
    for {set open_hw_target_try 1} {$open_hw_target_try <= 3} {incr open_hw_target_try} {
        if {[catch {open_hw_target} res_open_hw_target] == 0} {
            set hw_target_opened 1
            break
        }
    }
    if { $hw_target_opened == 0 } {
        puts "WARNING: Unable to open hardware target $hw_target after " \
            "$open_hw_target_try tries. Skipping."
        continue
    }
    puts "INFO: Opened hardware target $hw_target on try $open_hw_target_try."

    # Iterate through all devices and find one which contains $part
    foreach { hw_device } [get_hw_devices] {
        if { [string first [get_property PART $hw_device] $part] == 0 } {
            puts "INFO: Found $part as part of $hw_device."
            current_hw_device $hw_device
            set hw_device_found 1
            break
        }
    }

    if { $hw_device_found == 1 } {
        break
    } else {
        # Close currently tried device, and try with next one.
        puts "INFO: Part not found as part of $hw_target. Trying next device."
        close_hw_target
    }
}
if { $hw_device_found == 0 } {
    puts "ERROR: None of the hardware targets included a $part FPGA part. \
        Check cables and ensure that jumpers are correct for JTAG programming."
    exit 1
}
puts "INFO: Programming flash to device $hw_device on target $hw_target."

current_hw_device $hw_device
set_property PARAM.FREQUENCY 15000000 [get_hw_targets $hw_target]

create_hw_cfgmem -hw_device [current_hw_device] [lindex [get_cfgmem_parts $cfgmem_part] 0]
set_property PROGRAM.ADDRESS_RANGE {use_file} [get_property PROGRAM.HW_CFGMEM [current_hw_device]]
set_property PROGRAM.FILES [list $program] [get_property PROGRAM.HW_CFGMEM [current_hw_device]]
set_property PROGRAM.PRM_FILE {} [get_property PROGRAM.HW_CFGMEM [current_hw_device]]
set_property PROGRAM.UNUSED_PIN_TERMINATION {pull-none} [get_property PROGRAM.HW_CFGMEM [current_hw_device]]
set_property PROGRAM.BLANK_CHECK 0 [get_property PROGRAM.HW_CFGMEM [current_hw_device]]
set_property PROGRAM.ERASE 1 [get_property PROGRAM.HW_CFGMEM [current_hw_device]]
set_property PROGRAM.CFG_PROGRAM 1 [get_property PROGRAM.HW_CFGMEM [current_hw_device]]
set_property PROGRAM.VERIFY 1 [get_property PROGRAM.HW_CFGMEM [current_hw_device]]
set_property PROGRAM.CHECKSUM 0 [get_property PROGRAM.HW_CFGMEM [current_hw_device]]
startgroup
create_hw_bitstream -hw_device [current_hw_device] [get_property PROGRAM.HW_CFGMEM_BITFILE [current_hw_device]]
program_hw_devices [current_hw_device]
refresh_hw_device [current_hw_device]
program_hw_cfgmem -hw_cfgmem [get_property PROGRAM.HW_CFGMEM [current_hw_device]]
endgroup

# Disconnect from Xilinx Hardware Server
close_hw_target
disconnect_hw_server

puts ""
puts "INFO: SUCCESS! Flash has been programmed with firmware"
