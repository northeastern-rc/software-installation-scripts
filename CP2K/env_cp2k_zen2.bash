#!/bin/bash
#====================================================================================
#title           :env_cp2k_zen2.bash
#description     :This script will source the runtime shell environment for CP2K for
#                 zen2 AMD microarchitecture.
#author          :Mariana Levi
#date            :April 2022
#version         :0.1    
#usage           :source env_cp2k_zen2.bash 
#notes           :Sources CP2K and dependencies - GNU 11.1.0, OpenMPI 4.1.2 and 
#                 Intel 2022.0.1 MKL. 
#bash_version    :4.2.46(2)-release (x86_64-redhat-linux-gnu)
#====================================================================================

## Set the user-defined path - all libraries will be installed inside:
## Make sure to change $PWD to where your CP2K root path is located.
export SOFTWARE_DIR=$HOME/cp2k

VERSION=9.1
ARCH=zen2
COMPILER=gcc

## Also, set the install directory as desired:
export NICKNAME=$VERSION-$ARCH-$COMPILER
export INSTALL_DIR=$HOME/cp2k/$NICKNAME

module purge
module load discovery
module load gcc/11.1.0
module load openmpi/4.1.2-gcc11.1
module load cmake/3.18.1
source /shared/centos7/intel/oneapi/2022.1.0/mkl/2022.0.1/env/vars.sh

## Load CP2K dependencies:
source $INSTALL_DIR/tools/toolchain/install/setup

## Update CP2K paths to executables:
export PATH=$INSTALL_DIR/exe/local:$PATH
export LD_LIBRARY_PATH=$INSTALL_DIR/lib/local/pdbg:$INSTALL_DIR/lib/local/psmp:$INSTALL_DIR/lib/local/sdbg:$INSTALL_DIR/lib/local/ssmp:$LD_LIBRARY_PATH
export LIBRARY_PATH=$INSTALL_DIR/lib/local/pdbg:$INSTALL_DIR/lib/local/psmp:$INSTALL_DIR/lib/local/sdbg:$INSTALL_DIR/lib/local/ssmp:$LIBRARY_PATH
