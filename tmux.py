#!python

import os
import sys

cluster=[
    [101, 102, 103, 104],
    [105, 106, 107, 108],
    [109, 110, 111, 112],
    [113, 114, 115, 116]
]

if "--test" in sys.argv:
    command = lambda system: "\"uptime && sleep 5\""
if "--hostname" in sys.argv:
    command = lambda system: f"\"scp htoprc {sys.argv[sys.argv.index('--hostname')+1]}:~/.config/htop/htoprc && ssh {sys.argv[sys.argv.index('--hostname')+1]} -t 'htop'\""
else:
    command = lambda system: f"\"scp htoprc dietpi@192.168.0.{system}:/home/dietpi/.config/htop/htoprc && ssh dietpi@192.168.0.{system} -t 'htop'\""


# create the initial tmux vertical frames
for stack in cluster:
    if stack[0] == cluster[0][0]:
        print("creating session")
        os.system(f"tmux new-session -s cluster -d {command(stack[0])}")
    else:
        print("splitting section")
        os.system(f"tmux split-window {command(stack[0])}")

for i, stack in enumerate(cluster):
    print(f"switching to {i*4}")
    os.system(f"tmux select-pane -t {i*4}")
    for system in stack[1:]:
        print("creating new section")
        os.system(f"tmux split-window -h {command(system)}")

print("setting layout")
os.system("tmux select-layout tiled")

if not "--dont-attach" in sys.argv:
    os.system("tmux attach")
