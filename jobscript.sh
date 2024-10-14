#!/usr/bin/zsh

### SBATCH Section
#SBATCH --nodes=1
#SBATCH --beeond

#SBATCH --ntasks-per-node=16
#SBATCH --mem-per-cpu=4G
#SBATCH --job-name=h5bench_dlio
#SBATCH --time=3:00:00

# Declare file where the STDOUT/STDERR outputs will be written
#SBATCH --output=output.%J.txt
#SBATCH --account=rwth1666

export HDF5_HOME=/home/kr166361/hdf5/install
export LD_LIBRARY_PATH=/home/kr166361/hdf5/install/lib:/home/kr166361/vol-async/install/lib:/home/kr166361/vol-async/argobots/install/lib:$LD_LIBRARY_PATH

cp -r $HPCWORK/h5bench $BEEOND
rm -rf $BEEOND/h5bench/install/bin/storage/*-*

cd $BEEOND/h5bench/install/bin
./h5bench /home/kr166361/h5bench/samples/sync-dlio.json

rsync -av --exclude=storage/data storage $HOME

