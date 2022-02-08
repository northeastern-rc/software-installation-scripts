# Installation instructions of OpenSeesMP v. 3.4.0 (Parallel) on Discovery:
These instructions are set up with the following modules: `intel/compilers-2021.3.0` , `intel/mkl-2021.3.0`, `mpich/3.4.2-intel2021`.

## Step 0 - clone the scripts to your local directory (on a Shell window on Discovery):
For example, create a new directory in your $HOME directory:
```bash
cd $HOME
git clone https://github.com/northeastern-rc/software-installation-scripts.git
mkdir -p opensees
cd opensees
##copy scripts:
cp ~/software-installation-scripts/OpenSees/OpenSees-3.4.0/* .
```

## Step 1 - set up the installation environment: 
Use the settings Shell script `setenv_opensees.sh` to change the following if installing on your own:
1. Set the user-defined path - all libraries will be installed inside: change variable `SOFTWARE_DIR` to point to where your OpenSees root path should be located.
2. You can change the compilers, MKL or MPI libraries by loading other modules in lines 18-22. Note that some combinations may not compile or work well together. Make sure the compiler matches the MPI library.
3. Set up any compilation flags and compiler variables lines 24-28.

## Step 2 - submit the installation script:
Run this command to submit the script to build OpenSeesMP as a job on the cluster:
```bash
sbatch install_opensees.sh
```

## Step 3 - load and run OpenSeesMP:
Once the job completes, and there are no job errors, you can now run OpenSeesMP jobs.
To load it within a Slurm script, use the following example:

```bash
#!/bin/bash
#SBATCH --job-name=OpenSeesMP-test
#SBATCH --output=%j.out
#SBATCH --error=%j.err
#SBATCH --time=24:00:00
#SBATCH --ntasks=64 ## use 64 CPUs for the parallel run
#SBATCH --mem=20GB
#SBATCH --partition=short
#SBATCH --constraint=ib ##use only new nodes, with IB network support

source $HOME/opensees/setenv_opensees.sh

mpirun -n 64 OpenSeesMP input.tcl
```

