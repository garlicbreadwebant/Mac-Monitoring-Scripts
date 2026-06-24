sudo powermetrics --samplers smc | awk -F': ' '
/^CPU die temperature:/ {
    temp = $2
}

/^Fan:/ {
    fan = $2
}

temp && fan {
    printf "CPU Temperature: %s , Fan Speed: %s\n", temp, fan
    temp = ""
    fan = ""
    fflush()
}'