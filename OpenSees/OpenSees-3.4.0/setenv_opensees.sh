#!/bin/bash
#====================================================================================
#title           :setenv_opensees.sh
#description     :This script will source the runtime shell environment for OpenSees Parallel version MP.
#author          :Mariana Levi
#date            :Feb 2022
#version         :0.3 
#usage           :source setenv_opensees.sh 
#notes           :Install OpenSees and dependencies first with install_opensees.sh. Loads environment of Intel 2021.3 compilers, MKL and MPICH libraries. 
#bash_version    :4.2.46(2)-release (x86_64-redhat-linux-gnu)
#====================================================================================

## Set the user-defined path - all libraries will be installed inside:
## Make sure to change $PWD to where your OpenSees root path is located.
export SOFTWARE_DIR=/shared/centos7/opensees/3.4.0-mp

module purge
module load discovery
module load intel/mkl-2021.3.0 
module load intel/compilers-2021.3.0
module load ucx/1.10.1-intel2021
module load mpich/3.4.2-intel2021

export CC=mpicc
export CXX=mpicxx
export FC=mpif90
export F90=mpif90
export FORTRAN=mpif90

## Where dependency libraries are:
export LIBSDIR=$SOFTWARE_DIR/lib
export BINSDIR=$SOFTWARE_DIR/bin
export SRCDIR=$SOFTWARE_DIR/src
export INCLUDEDIR=$SOFTWARE_DIR/include

export SCOTCH_DIR=$SOFTWARE_DIR/src/scotch-v6.1.0
export MUMPSDIR=$SOFTWARE_DIR/src/MUMPS_5.0.2
export OPENSEESDIR=$SOFTWARE_DIR/OpenSees

## Source dependency location:
export PATH=$OPENSEESDIR/bin:$BINSDIR:$SCOTCH_DIR/bin:$PATH
export CPATH=$INCLUDEDIR:$SCOTCH_DIR/include:$MUMPSDIR/include:$CPATH
export LD_LIBRARY_PATH=$OPENSEESDIR/lib:$LIBSDIR:$SCOTCH_DIR/lib:$MUMPSDIR/lib:$LD_LIBRARY_PATH
export LIBRARY_PATH=$OPENSEESDIR/lib:$LIBSDIR:$SCOTCH_DIR/lib:$MUMPSDIR/lib:$LIBRARY_PATH
export PKG_CONFIG_PATH=$LIBSDIR/pkgconfig:$PKG_CONFIG_PATH
