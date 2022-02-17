#!/bin/bash

#====================================================================================
#title           :env_lammps_ani.bash
#description     :This script will source the parallel Lammps + ANI with GPU V100 support.
#author          :Mariana Levi
#date            :Feb. 2022
#version         :0.2    
#usage           :source env_lammps_ani.bash
#notes           :Installs Lammps+ANI using GNU 10.1.0, MKL & OpenMPI 4.1.1.
#bash_version    :4.2.46(2)-release (x86_64-redhat-linux-gnu)
#====================================================================================

## Set the user-defined path - all libraries will be installed inside $SOFTWARE_DIR.
## Set ANI_DIR to the path where the ani package is located.
export SOFTWARE_DIR=/shared/centos7/lammps/src/29Sep2021_update2
## You can modify the build & install directory paths:
export SOFTWARE_INSTALL_PATH=/shared/centos7/lammps/29Sep2021_u2-mpi
## the source code root directory (for cmake files):
export SOFTWARE_SRC_PATH=$SOFTWARE_DIR/lammps-stable_29Sep2021_update2
export SOFTWARE_BUILD_PATH=$SOFTWARE_DIR/build-mpi

## Load modules:

module load intel/mkl-2021.3.0
module load gcc/10.1.0
module load openmpi/4.1.2-gcc10.1
module load cmake/3.18.1
module load python/3.8.1

## Set runtime shell environment:
export PATH=$SOFTWARE_INSTALL_PATH/bin:$PATH
export LD_LIBRARY_PATH=$SOFTWARE_INSTALL_PATH/lib:$SOFTWARE_INSTALL_PATH/lib64:$LD_LIBRARY_PATH
export LIBRARY_PATH=$SOFTWARE_INSTALL_PATH/lib:$SOFTWARE_INSTALL_PATH/lib64:$LIBRARY_PATH
export CPATH=$SOFTWARE_INSTALL_PATH/include:$CPATH
