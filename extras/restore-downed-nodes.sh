#!/bin/bash
# original script by JM 10/26/2018, modified by WG 12/5/2018

PREEMPTED=( `/apps/slurm/current/bin/sinfo | grep down~ | awk '{print $6}'` );

if [[ $PREEMPTED ]]; then
        /apps/slurm/current/bin/scontrol update nodename=$PREEMPTED state=idle
fi
