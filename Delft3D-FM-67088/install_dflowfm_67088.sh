#!/bin/bash
#SBATCH -N 1
#SBATCH -n 16
#SBATCH -p short
#SBATCH -t 03:00:00
#SBATCH --constraint=cascadelake
#SBATCH -J install_dflowfm_67088

#====================================================================================
#title           :install_dflowfm_67088.sh
#description     :This script will install the parallel Delft3D FM 67088.
#author          :Mariana Levi
#date            :May 2021
#version         :0.1    
#usage           :sbatch install_dflowfm_67088.sh
#notes           :Installs Delft3D FM after dependencies were installed (using Intel 2021).
#bash_version    :4.2.46(2)-release (x86_64-redhat-linux-gnu)
#====================================================================================

## Set the user-defined path - all libraries will be installed inside:
## Make sure to change $PWD to where your OpenSees root path is located.
export SOFTWARE_DIR=$PWD

source env_dflowfm_67088.sh

## 1. Install D3D, provided from "dflowfm_src_v1.2.4-67088":
cd $SOFTWARE_DIR/src
cp $SOFTWARE_DIR/dflowfm_src_v1.2.4-67088/d3d-67088_src.tar.gz .
mkdir -p $SOFTWARE_DIR/d3d-67088
tar -zxvf d3d-67088_src.tar.gz --directory $SOFTWARE_DIR/d3d-67088 --strip-components=1

export D3D_VERSION=67088

export PETSC_DIR=$LIBSDIR
export METIS_DIR=$LIBSDIR

./autogen.sh --verbose >  log.autogen
cd third_party_open/kdtree2
./autogen.sh --verbose > log.autogen.third_party_open 2>&1
cd -

fflags="-O2 -fopenmp `nc-config --fflags` " cflags="-O2 " CPPFLAGS=' ' LDFLAGS=' ' CFLAGS=${cflags} CXXFLAGS=${cflags} AM_FFLAGS=' ' FFLAGS=${fflags} AM_FCFLAGS=' ' FCFLAGS=${fflags} AM_LDFLAGS=' ' ./configure --prefix="$(pwd)" --with-mpi --with-petsc --with-metis=$METIS_DIR > log.configure 2>&1

cd /shared/centos7/delft3dfm/d3d-67088/utils_lgpl/esmfsm/packages/esmfsm_version_number/src
cp ../include/version_number.h.svn version_number.h
cd /shared/centos7/delft3dfm/d3d-67088/tools_gpl/datsel/packages/datsel_version_number/src
cp ../include/version_number.h.svn version_number.h
cd /shared/centos7/delft3dfm/d3d-67088/tools_gpl/kubint/packages/kubint_version_number/src
cp ../include/version_number.h.svn version_number.h
cd /shared/centos7/delft3dfm/d3d-67088/tools_gpl/lint/packages/lint_version_number/src
cp ../include/version_number.h.svn version_number.h
cd /shared/centos7/delft3dfm/d3d-67088/tools_gpl/vs/packages/vs_version_number/src

cd $SOFTWARE_DIR/d3d-67088

FC=mpif90 make ds-install 2>&1 | tee make.log

# 2. Install DELFT3D-FM:
 
export NETCDFHOME=$LIBSDIR
export NETCDF_DIR=$LIBSDIR

FC=mpif90 make ds-install -C engines_gpl/dflowfm

# 3. Install swan:

cp $SOFTWARE_DIR/dflowfm_src_v1.2.4-67088/swan-v40.91-nrlv4.2.tar.gz $SOFTWARE_DIR/src
tar -zxvf swan-v40.91-nrlv4.2.tar.gz
mv swan-v40.91-nrlv4.2 ../
cd $SOFTWARE_DIR/swan-v40.91-nrlv4.2
make clean
rm -rf *.exe
cp config/macros.Linux.i686.intel.inc macros.inc
make -j 16 mpi 
