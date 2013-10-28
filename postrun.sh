# Get folder of run
if [ $# != 1 ]
then
    echo 'Argument Error: Need Folder'
    exit
fi

folder=$1

# Remove state data files
rm -rf $folder/state_cpt-*

# Get current date and time
time_stamp=$(date +%d-%m-%Y_%H-%M)

# Make a folder for run data files
runfolder="run-$time_stamp"
mkdir -p $folder/$runfolder

# Move all data from run to this folder
mv $folder/system.lammpstrj $folder/$runfolder/
mv $folder/traj-0.xtc $folder/$runfolder/
mv $folder/*.xvg $folder/$runfolder/
mv $folder/*log* $folder/$runfolder/

# Copy plot files for ease
cp $folder/*.gnu $folder/$runfolder/

# Copy run file and data file for repeatability
cp $folder/$folder.run $folder/$runfolder/
cp $folder/$folder.data $folder/$runfolder/
 
