#!/bin/bash

#====================================================================================
#title           :env_xbeach.bash
#description     :This script will source path for xbeach installation
#author          :Prasanth Dwadasi
#date            :March 2022
#version         :5920  
#usage           :source env_xbeach.bash
#notes           :Installs Xbeach with Netcdf and OpenMPI support
#bash_version    :4.2.46(2)-release (x86_64-redhat-linux-gnu)
#====================================================================================

## Set the user-defined path - all libraries will be installed inside $SOFTWARE_DIR.
## Set SOFTWARE_DIR to the path where the xbeach files were located.
## You can modify the software and install directory paths:

export SOFTWARE_DIR=/work/rc/shared/xbeach/trunk/
export SOFTWARE_INSTALL_PATH=$HOME/software/xbeach/gcc4/install
export BUILD_PATH=$HOME/software/xbeach/gcc4/build

module load gcc/4.8.5
module load openmpi/4.0.5
module load python/3.6.12

export PATH=$SOFTWARE_INSTALL_PATH/bin:$HOME/.local/bin:$PATH
export LD_LIBRARY_PATH=$SOFTWARE_INSTALL_PATH/lib:$LD_LIBRARY_PATH
export LIBRARY_PATH=$SOFTWARE_INSTALL_PATH/lib:$LIBRARY_PATH
export CPATH=$SOFTWARE_INSTALL_PATH/include:$CPATH
