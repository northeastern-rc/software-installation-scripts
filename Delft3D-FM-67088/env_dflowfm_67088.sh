#!/bin/bash

#====================================================================================
#title           :env_dflowfm_67088.sh
#description     :This script sources Delft3D - Flexible Mesh software (version 67088) and SWAN (v40.91-nrlv4.2) shell environment.
#author          :Mariana Levi
#date            :May 2021
#version         :0.1    
#usage           :source env_dflowfm_67088.sh
#notes           :uses Intel 2021.2.0 compilers, MPI and MKL libraries. Sources BZIP2, Libsd, Expat, readline, zlib, hdf5, netcdf-c, netcdf-fortran, libtool, automake, PETSc, metis, parmetis. 
#bash_version    :4.2.46(2)-release (x86_64-redhat-linux-gnu)
#====================================================================================

## Set the user-defined path - all libraries will be installed inside:
## Make sure to change $PWD to where your OpenSees root path is located.
export SOFTWARE_DIR=$PWD

export DELFT3DFM_DIR=$SOFTWARE_DIR/d3d-67088

export LIBSDIR=$SOFTWARE_DIR/libs

## Load intel 2021 compilers +  Intel MPI environment:
source /shared/centos7/intel/oneapi/2021.2.0/setvars.sh
#module load intel/compilers-2021.2.0
#module load intel/mpi-2021.2.0
#module load intel/mkl-2021.2.0

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
export I_MPI_F90=ifort
export NETCDFROOT=$LIBSDIR

export MPI_ROOT=$I_MPI_ROOT
export MPICC_CC=mpicc
export MPICXX_CXX=mpicxx
export MPIF90_F90=mpif90

export PETSC_DIR=$LIBSDIR
export METIS_DIR=$LIBSDIR
export NETCDFHOME=$LIBSDIR
export NETCDF_DIR=$LIBSDIR
export LIBTOOLIZE=$LIBSDIR/bin/libtoolize
export ACLOCAL=$LIBSDIR/bin/aclocal


# Source D3D:
export PATH=$DELFT3DFM_DIR/bin:$PATH
export LD_LIBRARY_PATH=$DELFT3DFM_DIR/lib:$LD_LIBRARY_PATH
export LIBRARY_PATH=$DELFT3DFM_DIR/lib:$LIBRARY_PATH

## swan:
export SWANDIR=$SOFTWARE_DIR/swan-v40.91-nrlv4.2
export PATH=$SWANDIR:$PATH

