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
#date            :Feb. 2022
#version         :5920   
#usage           :sbatch install_xbeach.bash
#notes           :Installs Xbeach with Netcdf 4.7.4 and mpich 3.3.2 support
#bash_version    :4.2.46(2)-release (x86_64-redhat-linux-gnu)
#====================================================================================

source env_xbeach.bash

mkdir -p $SOFTWARE_DIR $SOFTWARE_INSTALL_PATH

cd $SOFTWARE_DIR

./autogen.sh

./configure --prefix=$SOFTWARE_INSTALL_PATH PKG_CONFIG_PATH=/shared/centos7/netcdf/4.7.4-skylake-gcc7.3/lib/pkgconfig/  --with-mpi --with-netcdf


make clean

make

make install
