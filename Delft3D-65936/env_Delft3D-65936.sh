#!/bin/bash

#====================================================================================
#title           :env_Delft3D-65936.sh
#description     :This script will install the parallel Delft3D + wave 65936.
#author          :Mariana Levi
#date            :May 2021
#version         :0.1    
#usage           :source env_Delft3D-65936.sh
#notes           :sources Delft3D shell environment and dependencies (using Intel 2021 +  mpich/3.4.2-intel2021).
#bash_version    :4.2.46(2)-release (x86_64-redhat-linux-gnu)
#====================================================================================

## Set the user-defined path - all libraries will be installed inside:
## Make sure to change $PWD to where your OpenSees root path is located.
export SOFTWARE_DIR=/shared/centos7/delft3d

export LIBSDIR=$SOFTWARE_DIR/libs
export DELFT3D_DIR=/shared/centos7/delft3d/65936

## Load intel 2021 compilers + MPI:
module load intel/compilers-2021.2.0
module load mpich/3.4.2-intel2021

export CC=icc
export CXX=icpc
export CFLAGS='-O2 -fpic'
export CXXFLAGS='-O2 -fpic'
export CPPFLAGS='-O2 -fpic'
export F77=ifort
export FC=ifort
export F90=ifort
export FFLAGS='-O2 -fpic'
export CPP='icpc -E'
export CXXCPP='icpc -E'

## Source dependency location:
export PATH=$LIBSDIR/bin:$PATH
export CPATH=$LIBSDIR/include:$CPATH
export LD_LIBRARY_PATH=$LIBSDIR/lib:$LD_LIBRARY_PATH
export LIBRARY_PATH=$LIBSDIR/lib:$LIBRARY_PATH
export PKG_CONFIG_PATH=$LIBSDIR/lib/pkgconfig:$PKG_CONFIG_PATH

