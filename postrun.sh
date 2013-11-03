# Get folder of run
if [ $# != 2 ]
then
    echo 'Argument Error: Need one argument'
    echo 'Usage: ./postrun folder <simpart>'
    exit
fi

folder=$1
simpart=$2

# Remove state data files
rm -rf $folder/state_cpt-*

# Make a folder for run data files
runfolder="run-$simpart"
mkdir -p $folder/$runfolder

# Move all data from run to this folder
mv $folder/$folder-$simpart.run $folder/$runfolder/
mv $folder/*.lammpstrj $folder/$runfolder/
mv $folder/*.xtc $folder/$runfolder/
mv $folder/*.xvg $folder/$runfolder/
mv $folder/*log* $folder/$runfolder/

# Copy binary data file 
cp $folder/confout-$simpart.data $folder/$runfolder/
# Copy plot files for ease
cp $folder/*.gnu $folder/$runfolder/
