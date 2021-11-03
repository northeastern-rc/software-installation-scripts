#!/bin/bash
#SBATCH -N 1
#SBATCH -n 56
#SBATCH --time=24:00:00
#SBATCH --constraint=cascadelake
#SBATCH -J myJobName
 
## Load modules and the GA+OpenMolcas environment variables:
source env-intel-openmolcas.bash
 
## Job settings ##
export MOLCAS_MEM=800
export SUBMIT=/path/to/my/projectdir
export Project=test000
export MOLCAS_NPROCS=56
#Molcas settings:
export MOLCAS=/path/to/settings/molcas80.par/
export WorkDir=/tmp
 
cd $SUBMIT
molcas $Project.input -f


