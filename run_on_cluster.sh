for i in $(seq 101 116); do
    ssh dietpi@192.168.0.$i $@
done
