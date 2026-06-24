#!/bin/bash

# mac_powermetrics_diagnostics.sh

sudo powermetrics --samplers smc,cpu_power,gpu_power -i 5000 | awk -F': ' '
/^CPU die temperature:/ {
    cpu_temp = $2
}

/^GPU die temperature:/ {
    gpu_temp = $2
}

/^Fan:/ {
    fan = $2
}

/^CPU Power:/ {
    cpu_power = $2
}

/^GPU Power:/ {
    gpu_power = $2
}

/^Combined Power \(CPU \+ GPU \+ ANE\):/ {
    combined_power = $2
}

/^Thermal pressure:/ {
    thermal = $2
}

cpu_temp != "" && fan != "" {
    print "----------------------------------------"
    print "CPU Temperature: " cpu_temp
    if (gpu_temp != "") print "GPU Temperature: " gpu_temp
    print "Fan Speed: " fan
    if (cpu_power != "") print "CPU Power: " cpu_power
    if (gpu_power != "") print "GPU Power: " gpu_power
    if (combined_power != "") print "Combined Power: " combined_power
    if (thermal != "") print "Thermal Pressure: " thermal
    fflush()

    cpu_temp = ""
    gpu_temp = ""
    fan = ""
    cpu_power = ""
    gpu_power = ""
    combined_power = ""
    thermal = ""
}'
