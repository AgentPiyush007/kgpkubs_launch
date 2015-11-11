#!/bin/bash
# Start SSL functionality in screen sessions
# to kill all sessions: killall -15 screen

function launcher {
    if screen -ls | grep -q $1; then
        echo "WARNING! $1 is already running!"
    else
        screen -S $1 -d -m bash
        screen -S $1 -p 0 -X stuff "source ~/Desktop/robocup/devel/setup.bash; $2$(printf \\r)"
    fi
}

function pr_launcher {
    launcher $1 "roslaunch kgpkubs_launch $2 --wait"
}



launcher    "core"         "roscore"
pr_launcher "vision"    "vision.launch"
pr_launcher "belief_state"      "belief_state.launch"
pr_launcher "grsim_comm"    "grsim_comm.launch"
pr_launcher "robot"         "robot.launch"
# pr_launcher "rj_robot"         "rj_robot.launch"