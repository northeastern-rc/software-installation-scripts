#!/bin/bash
#====================================================================================
#title           :setenv_opensees.sh
#description     :This script will source the runtime shell environment for OpenSees.
#author		 :Mariana Levi
#date            :May 2021
#version         :0.1    
#usage		 :source setenv_opensees.sh 
#notes           :Install OpenSees and dependencies first with install_opensees.sh. 
#bash_version    :4.2.46(2)-release (x86_64-redhat-linux-gnu)
#====================================================================================

## Set the user-defined path - all libraries will be installed inside:
## Make sure to change $PWD to where your OpenSees root path is located.
export SOFTWARE_DIR=$PWD

module purge
module load discovery
module load intel/2019-4
module load mpich/3.3.2-intel
module load intel/mkl-2020u2

export MPICC_CC=mpicc
export MPICXX_CXX=mpicxx
export MPIF90_F90=mpif90

## Where dependency libraries are:
export LIBSDIR=$SOFTWARE_DIR/lib
export BINSDIR=$SOFTWARE_DIR/bin
export SRCDIR=$SOFTWARE_DIR/src
export INCLUDEDIR=$SOFTWARE_DIR/include

## Source dependency location:
export PATH=$BINSDIR:$PATH
export CPATH=$INCLUDEDIR:$CPATH
export LD_LIBRARY_PATH=$LIBSDIR:$LD_LIBRARY_PATH
export LIBRARY_PATH=$LIBSDIR:$LIBRARY_PATH
export PKG_CONFIG_PATH=$LIBSDIR/pkgconfig:$PKG_CONFIG_PATH

export MUMPSDIR=$SOFTWARE_DIR/src/MUMPS_5.0.2
export SCOTCH_DIR=$SOFTWARE_DIR/src/scotch-v6.1.0

export PATH=$SOFTWARE_DIR/OpenSees/bin:$PATH
export LD_LIBRARY_PATH=$SOFTWARE_DIR/OpenSees/lib:$LD_LIBRARY_PATH 
