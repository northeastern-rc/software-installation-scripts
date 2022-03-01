#!/bin/bash

#====================================================================================
#title           :env_xbeach.bash
#description     :This script will source path for xbeach installation
#author          :Prasanth Dwadasi
#date            :Feb 2022
#version         :5920  
#usage           :source env_xbeach.bash
#notes           :Installs Xbeach with Netcdf 4.7.4 and mpich 3.3.2 support
#bash_version    :4.2.46(2)-release (x86_64-redhat-linux-gnu)
#====================================================================================



## Set the user-defined path - all libraries will be installed inside $SOFTWARE_DIR.
## Set SOFTWARE_DIR to the path where the xbeach files were located.
## You can modify the software and install directory paths:

export SOFTWARE_DIR=$HOME/xbeach/xbeach/trunk
export SOFTWARE_INSTALL_PATH=$HOME/xbeach/xbeach_install_dir

module load gcc/7.3.0  mpich/3.3.2-skylake-gcc7.3 
module load netcdf/4.7.4-skylake-gcc7.3 hdf5/1.12.0-skylake-gcc7.3
module load python/3.8.1

export PATH=$SOFTWARE_INSTALL_PATH/bin:$PATH

