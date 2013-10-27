#!/bin/bash

# Script to run a Lennard-Jones liquid simulation using Lammps
# The script runs the simulation in blocks of 500 ps. It uses 
# two template files to prepare the run files for the simulation.

# The script uses a serial version of lammps.

if [ $# != 2 ]
then
    echo 'Argument Error: Need one argument'
    echo 'Usage: sh run.sh folder <simpart>'
    exit
fi

folder=$1
simpart=$2

lmpexec="lammps"

if [ ! -d $folder ]
then
    echo 'Error: Folder path not found'
    exit 
fi 

cd $folder

if [ $simpart = 0 ]
then
    logfile=md-0.log
    runfile=${folder}.run
    mpirun -np 4 $lmpexec -log $logfile < $runfile
    #$lmpexec -log $logfile < $runfile
else
    oldpart=`echo $simpart | awk '{print $1-1}'`
    if [ ! -f confout-$oldpart.data ]
    then
	echo "Error: Missing restart file from simpart '$oldpart'"
	exit
    fi 
    logfile=md-$simpart.log
    sed "s/SIMPART/$simpart/g;s/OLDPART/$oldpart/g" ${folder}-continue.run \
	> ${folder}-$simpart.run
    runfile=${folder}-$simpart.run
    mpirun -np 4 $lmpexec -log $logfile < $runfile
    #$lmpexec -log $logfile < $runfile
fi
