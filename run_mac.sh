#!/bin/bash

# Script to run a Lennard-Jones liquid simulation using Lammps
# The script runs the simulation in blocks of 500 ps. It uses 
# two template files to prepare the run files for the simulation.

# The script uses a serial version of lammps.

if [ $# != 1 ]
then
    echo 'Argument Error: Need one argument'
    exit
fi

folder=$1
simpart=$2

lmppath="/Users/laflij/Software/lammps/lammps-27Aug13"
lmpexec="lmp_mac_mpi"

if [ ! -d $folder ]
then
    echo 'Error: Folder path not found'
    exit 
fi 

cd $folder

logfile=md-0.log
runfile=${folder}.run
#     $lmppath/$lmpexec  -log $logfile < $runfile
mpirun -np 4 $lmppath/$lmpexec -log $logfile < $runfile
