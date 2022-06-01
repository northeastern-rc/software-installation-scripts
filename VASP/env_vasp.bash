#!/bin/bash

#====================================================================================
#title           :env_vasp.bash
#description     :This script will source path for vasp installation
#author          :Prasanth Dwadasi
#date            :June 2022
#version         :6.3.1  
#usage           :source env_vasp.bash
#notes           :Installs VASP with Intel compilers and OpenMPI
#bash_version    :4.2.46(2)-release (x86_64-redhat-linux-gnu)
#====================================================================================



## Set the user-defined path - all libraries will be installed inside $SOFTWARE_DIR.
## Set SOFTWARE_DIR to the path where the VASP files were located.
## You can modify the software and build  directory paths:

export SOFTWARE_DIR=$HOME/software/vasp.6.3.1
export SOFTWARE_BUILD_PATH=$HOME/software/vasp.6.3.1/build

module load intel/compilers-2021.1
module load openmpi/4.1.0-amd-intel2021
module load intel/mkl-2021.1

export PATH=$SOFTWARE_DIR/bin:$PATH
