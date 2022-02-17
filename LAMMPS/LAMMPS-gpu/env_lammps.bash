#!/bin/bash
#====================================================================================
#title           :env_lammps.bash
#description     :This script will source the parallel LAMMPS version with CUDA support.
#author          :Mariana Levi
#date            :Feb. 2022
#version         :0.2    
#usage           :source env_lammps.bash
#notes           :Installs LAMMPS 29Sep2021_update2 using GNU 6.4.0, CUDA11.1, 
#                 Intel MKL & OpenMPI 4.1.1.
#bash_version    :4.2.46(2)-release (x86_64-redhat-linux-gnu)
#====================================================================================

## Set the user-defined path - all libraries will be installed inside $SOFTWARE_DIR.
## Set SOFTWARE_DIR to the path where the installation should be located (default to $HOME):
export SOFTWARE_DIR=$HOME
## You can modify the build & install directory paths:
export SOFTWARE_INSTALL_PATH=$HOME/29Sep2021_u2
## the source code root directory (for cmake files):
export SOFTWARE_SRC_PATH=$SOFTWARE_DIR/lammps-stable_29Sep2021_update2
export SOFTWARE_BUILD_PATH=$SOFTWARE_DIR/build

## Load modules:

module load intel/mkl-2021.3.0
module load gcc/10.1.0
module load cuda/11.2
module load openmpi/4.1.0-gcc10.1-cuda11.2 
module load cmake/3.18.1
module load python/3.8.1

## Set runtime shell environment:
export PATH=$SOFTWARE_INSTALL_PATH/bin:$PATH
export LD_LIBRARY_PATH=$SOFTWARE_INSTALL_PATH/lib:$SOFTWARE_INSTALL_PATH/lib64:$LD_LIBRARY_PATH
export LIBRARY_PATH=$SOFTWARE_INSTALL_PATH/lib:$SOFTWARE_INSTALL_PATH/lib64:$LIBRARY_PATH
export CPATH=$SOFTWARE_INSTALL_PATH/include:$CPATH
