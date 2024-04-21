command(){
    printf "ssh dietpi@192.168.0.%s -t 'htop'" "$1"
}

tmux new-session -s main -d "$(command 101)"
tmux split-window "$(command 105)"
tmux split-window "$(command 109)"
tmux split-window "$(command 113)"
tmux select-pane -t 0
tmux split-window -h "$(command 102)"
tmux split-window -h "$(command 103)"
tmux split-window -h "$(command 104)"
tmux select-pane -t 4
tmux split-window -h "$(command 106)"
tmux split-window -h "$(command 107)"
tmux split-window -h "$(command 108)"
tmux select-pane -t 8
tmux split-window -h "$(command 110)"
tmux split-window -h "$(command 111)"
tmux split-window -h "$(command 112)"
tmux select-pane -t 12
tmux split-window -h "$(command 114)"
tmux split-window -h "$(command 115)"
tmux split-window -h "$(command 116)"
tmux select-layout tiled
tmux attach

