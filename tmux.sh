name="cluster"

htop_command() {
    echo "scp htoprc $1:~/.config/htop/htoprc && ssh $1 -t htop"
}

nvtop_command() {
    echo "ssh $1 -t nvtop"
}


tmux new-session -s $name -d "$(htop_command "asck@10.0.0.101")"
tmux split-window "$(nvtop_command "asck@10.0.0.101")"
tmux split-window "$(htop_command "asck@10.0.0.105")"
tmux split-window "$(nvtop_command "asck@10.0.0.105")"

tmux select-pane -t 0
tmux split-window -h "$(htop_command "asck@10.0.0.102")"
tmux split-window -h "$(htop_command "asck@10.0.0.103")"
tmux split-window -h "$(htop_command "asck@10.0.0.104")"

tmux select-pane -t 4
tmux split-window -h "$(nvtop_command "asck@10.0.0.102")"
tmux split-window -h "$(nvtop_command "asck@10.0.0.103")"
tmux split-window -h "$(nvtop_command "asck@10.0.0.104")"

tmux select-pane -t 8
tmux split-window -h "$(htop_command "asck@10.0.0.106")"
tmux split-window -h "$(htop_command "asck@10.0.0.107")"
tmux split-window -h "$(htop_command "asck@10.0.0.108")"

tmux select-pane -t 12
tmux split-window -h "$(nvtop_command "asck@10.0.0.106")"
tmux split-window -h "$(nvtop_command "asck@10.0.0.107")"
tmux split-window -h "$(nvtop_command "asck@10.0.0.108")"

tmux select-layout tiled

tmux attach
