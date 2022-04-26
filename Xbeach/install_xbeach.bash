#!/bin/bash
#SBATCH -N 1
#SBATCH -n 32
#SBATCH -p short
#SBATCH --mem=10G
#SBATCH -t 01:00:00
#SBATCH --constraint=cascadelake
#SBATCH -J install_Xbeach

#====================================================================================
#title           :install_xbeach.bash
#description     :This script will install the Xbeach with NetCDF and MPI support.
#author          :Prasanth Dwadasi
#date            :March. 2022
#version         :5920   
#usage           :sbatch install_xbeach.bash
#notes           :Installs Xbeach with Netcdf and openmpi 4.0.5 support
#bash_version    :4.2.46(2)-release (x86_64-redhat-linux-gnu)
#====================================================================================

set -e

source env_xbeach.bash

pip install --user mako numpy

rm -rf $BUILD_PATH $SOFTWARE_INSTALL_PATH

mkdir -p $SOFTWARE_INSTALL_PATH
mkdir -p $BUILD_PATH
cd $BUILD_PATH

FC=gfortran MPIFC=`which mpif90` PKG_CONFIG_PATH=/usr/lib64/pkgconfig $SOFTWARE_DIR/configure  --prefix=$SOFTWARE_INSTALL_PATH --with-mpi --with-netcdf NETCDF_FORTRAN_LIBS="-L/usr/lib64 -lnetcdff" NETCDF_FORTRAN_CFLAGS="-I/usr/lib64/gfortran/modules" NETCDF_CFLAGS="-I/usr/lib64/gfortran/modules" NETCDF_LIBS="-L/usr/lib64 -lnetcdf" 

make

make install

# bash install_xbeach.bash 2>&1 | tee output.log
