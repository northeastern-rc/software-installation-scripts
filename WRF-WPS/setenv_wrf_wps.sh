#!/bin/bash

#====================================================================================
#title           :install_wrf_wps.sh
#description     :This script will install the parallel WRF/WPS versions 4.1.4/4.1.
#author          :Mariana Levi
#date            :May 2021
#version         :0.1    
#usage           :sbatch install_wrf_wps.sh
#notes           :Installs WRF/WPS after dependencies were installed (using Intel 2021): zlib, libpng, jpg, szip, JASPER, hdf5-parallel, netcdf-c & netcdf-fortran.
#bash_version    :4.2.46(2)-release (x86_64-redhat-linux-gnu)
#====================================================================================

## Set the user-defined path - all libraries will be installed inside:
## Make sure to change $PWD to where your OpenSees root path is located.
export SOFTWARE_DIR=$PWD

## Clean old modules in case of conflicts:
module purge
module load discovery

## Source the environment shell script for Intel compilers + MPI 2021:
source /shared/centos7/intel/oneapi/2021.1_u9-base/setvars.sh
export INTEL_DIR=/shared/centos7/intel/oneapi/2021.1_u9-base
#source compilers:
source $INTEL_DIR/compiler/latest/env/vars.sh
##source MPI:
source $INTEL_DIR/mpi/latest/env/vars.sh

## Set Intel compiler flags:
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
export I_MPI_F90=ifort

## Set library paths:
export diretorio=$SOFTWARE_DIR/libraries
export PATH=$diretorio/bin:$PATH
export LIBRARY_PATH=$diretorio/lib:$diretorio/lib64:$LIBRARY_PATH
export LD_LIBRARY_PATH=$diretorio/lib:$diretorio/lib64:$LD_LIBRARY_PATH
export CPATH=$diretorio/include:$CPATH

## Set additional shell env vars:
export NETCDF=${diretorio}
export YACC='/usr/bin/yacc -d'
export FLEX_LIB_DIR=/usr/lib64
export JASPERLIB=$diretorio/lib64
export JASPERINC=$diretorio/include

## Set WRF-specific shell env vars:
export WRFIO_NCD_LARGE_FILE_SUPPORT=1
export WRF_EM_CORE=1
export WRF_CHEM=1
export WRF_KPP=1
export MALLOC_CHECK=O

export WRF_DIR=$SOFTWARE_DIR/WRF-4.1.4
export WPS_DIR=$SOFTWARE_DIR/WPS-4.1

## Set main program paths:
export PATH=$WRF_DIR:$WPS_DIR:$PATH
