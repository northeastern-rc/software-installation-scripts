###Installation instructions for OpenMM version 7.5 on Discovery (V100 GPU + Skylake_AVX512 cCPU):
These instructions are for the installation for OpenMM version 7.5 on the Discovery cluster with Miniconda, GNU 10.1.0 compilers and OpenMPI v. 4.1.0 with CUDA support version 11.2. The installation script will also intall the dependency package Swig v. 3.0.5.

You'll need to copy the appropriate environment shell script `env_openmm_miniconda.sh` (that loads the modules and sets up the environment variables) and the installation script `install_openmm_miniconda.sh` to Discovery to be able to modify and run them.

## Step 1 - set up the installation scripts:
1. Login to Discovery with your NU credentials, clone the repository, and navigate to your desired directory location for your installation. In this example, the location is assumed to be at `$HOME/openmolcas`: 
```bash
ssh <username>@login.discovery.neu.edu
cd $HOME
## clone the software installation scripts repository to access the scripts:
git clone git@github.com:northeastern-rc/software-installation-scripts.git
mkdir -p $HOME/openmm
cd $HOME/openmm
```
2. Copy over the two shell scripts:
```bash
cp $HOME/software-installation-scripts/env_openmm_miniconda.sh .
cp $HOME/software-installation-scripts/install_openmm_miniconda.sh .
```
3. There's no need to directly modify the install script `install_openmm_miniconda.sh` unless you want to change any of the Slurm options, modify compilation flags, or add the additional packages. Note that the only requirement is that both scripts are in the same directory. 
4. You do need to modify the file `env_openmm_miniconda.sh`. Open it in a file editor and modifiy the following:
   - Update which directory you'll use for the OpenMM installation (line 6: `export OPEMMDIR=$HOME/openmm`). By default, it will use directory: `$HOME/openmm`. All libraries, source code and executables will be places inside sub-folders in this directory.
   - Update which miniconda version you'd like to use (line 9: `export MYCONDA_DIR=$HOME/miniconda3`). By default, it points to a miniconda3 version in your `$HOME` directory. If you don't have miniconda installed, follow the instructions provided [here](https://rc-docs.northeastern.edu/en/latest/software/conda.html#working-with-a-miniconda-environment).
   - Optional changes (caution - may not work): you can also change the module versions in line 12, and other paths. But this is not recommended as this was not tested by RC, and may fail your installation.

## Step 2 - install the software:
Once you made all of the required changes, you can submit the installation script as a Discovery Slurm job:
```bash
sbatch install_openmm_miniconda.sh
```

## Step 3 - check if installation was successful:
Once the job finishes running, review output files: `openmm_install.out` and `openmm_install.err` from the Slurm job. If no errors are present in those files, you can run now use script `env_openmm_miniconda.sh` to run openmm jobs.

## Step 4 - run OpenMM jobs:
Here's an example template of an OpenMM sbatch script:

```bash
#!/bin/bash
#SBATCH -N 1 
#SBATCH -n 10
#SBATCH -p gpu
#SBATCH --gres=gpu:v100-sxm2:1
#SBATCH -t 08:00:00
#SBATCH --output=openmm_myrun.out
#SBATCH --error=openmm_myrun.err

## Load your OpenMM software:
source $HOME/openmm/env_openmm_miniconda.sh
conda activate openmm

## Enter your work directory:
cd /path/to/my/work/dir

## Follow with OpenMM commands, for example:
python simulatePdb.py
```
