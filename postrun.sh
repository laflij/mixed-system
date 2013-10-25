# Get folder of run
if [ $# != 1]
then
    echo 'Argument Error: Need Folder'
    exit
fi

folder=$1

# Remove state data files
rm -rf state_cpt-*

# Get current date and time
time_stamp=$(date +%d-%m-%Y_%H-%M)

# Make a folder for run data files
folder="$time_stamp-run"
mkdir -p $folder/$runfolder

# Move all data from run to this folder
mv $folder/system.lammpstrj $folder/$runfolder/
mv $folder/traj-0.xtc $folder/$runfolder/
mv $folder/msd.xvg $folder/$runfolder/
mv $folder/rdf.xvg $folder/$runfolder/

# Copy plot scrips for convienience
cp $folder/plot_rdf.gnu $folder/$runfolder/
cp $folder/plot_msd.gnu $folder/$runfolder/

