#!/bin/bash

# Script to run a Lennard-Jones liquid simulation using Lammps
# The script runs the simulation in blocks of 500 ps. It uses 
# two template files to prepare the run files for the simulation.

# The script uses a serial version of lammps.

if [ $# != 1 ]
then
    echo 'Argument Error: Need one argument'
    echo 'Usage: sh run.sh <simpart>'
    exit
fi

simpart=$1

lmppath="/Users/laflij/Software/lammps/lammps-27Aug13"
lmpexec="lmp_mac_mpi"

if [ $simpart == 0 ]
then
    logfile=mixed-system-0.log
    runfile=mixed-system.run
    mpirun -np 4 $lmppath/$lmpexec  -log $logfile < $runfile
else
    oldpart=`echo $simpart | awk '{print $1-1}'`
    if [ ! -f confout-$oldpart.data ]
    then
	echo "Error: Missing restart file from simpart '$oldpart'"
	exit
    fi 
    logfile=mixed-system-$simpart.log
    sed "s/SIMPART/$simpart/g;s/OLDPART/$oldpart/g" mixed-system-continue.run \
	> mixed-system-$simpart.run
    runfile=mixed-system-$simpart.run
    mpirun -np 2 $lmppath/$lmpexec  -log $logfile < $runfile
fi
