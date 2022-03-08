#!/bin/bash

#====================================================================================
#title           :activate_gromacs.bash
#description     :This script will source modules and path gromacs-2022 installed in $HOME
#author          :Deenadayalan Dasarathan
#date            :Mar 2022
#version         :1.0
#usage           :source activate_gromacs.bash
#notes           :This scipt sets the environment to use gromacs-2022 software
#bash_version    :4.2.46(2)-release (x86_64-redhat-linux-gnu)
#====================================================================================

## Load the modules necessary for activate gromacs-2022 installation.
cd ${HOME}
GROMACS_DIR=${HOME}/gromacs-2022

module load discovery/2021-10-06
module load python/3.8.1
module load cmake/3.18.1
module load cuda/11.4
module load openmpi/4.1.2-gcc10.1
source ${GROMACS_DIR}/bin/GMXRC
#PATH=$PATH:${HOME}/gromacs-2022/bin
gmx_mpi mdrun -version
