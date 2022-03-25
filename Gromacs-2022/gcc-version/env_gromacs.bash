#!/bin/bash

#====================================================================================
#title           :env_gromacs.bash
#description     :This script loads necessary modules and path for gromacs-2022
#author          :Deenadayalan Dasarathan
#date            :Mar 2022
#version         :1.0
#usage           :source env_gromacs.bash
#notes           :This script loads module that supports only gromacs-2022 version.
#bash_version    :4.2.46(2)-release (x86_64-redhat-linux-gnu)
#====================================================================================

module purge

## Load the modules necessary for gromacs-2022 installation.
module load discovery/2021-10-06
module load python/3.8.1
module load cmake/3.18.1
module load gcc/11.1.0

INSTALL_DIR=${HOME}
GROMACS_DIR=${INSTALL_DIR}/gromacs-2022

export PATH=${GROMACS_DIR}/bin:$PATH
export LD_LIBRARY_PATH=${GROMACS_DIR}/lib64:$LD_LIBRARY_PATH
