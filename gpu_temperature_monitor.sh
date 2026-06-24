sudo powermetrics --samplers smc | awk -F': ' '
/^GPU die temperature:/ {
    print "GPU Temperature: " $2
    fflush()
}'
