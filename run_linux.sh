#!/bin/bash

# Script to run a Lennard-Jones liquid simulation using Lammps
# The script runs the simulation in blocks of 500 ps. It uses 
# two template files to prepare the run files for the simulation.

# The script uses a serial version of lammps.

if [ $# != 1 ]
then
    echo 'Argument Error: Need one argument'
    echo 'Usage: sh run.sh folder <simpart>'
    exit
fi

simpart=$1

lmpexec="lammps"

if [ $simpart = 0 ]
then
    logfile=md-0.log
    runfile=mixed-system.run
#     $lmppath/$lmpexec  -log $logfile < $runfile
    mpirun -np 4 $lmpexec -log $logfile < $runfile
else
    oldpart=`echo $simpart | awk '{print $1-1}'`
    if [ ! -f confout-$oldpart.data ]
    then
	echo "Error: Missing restart file from simpart '$oldpart'"
	exit
    fi 
    logfile=md-$simpart.log
    sed "s/SIMPART/$simpart/g;s/OLDPART/$oldpart/g" mixed-system-continue.run \
	> mixed-system-$simpart.run
    runfile=mixed-system-$simpart.run
#     $lmppath/$lmpexec -log $logfile < $runfile
    mpirun -np 4 $lmpexec -log $logfile < $runfile
fi
