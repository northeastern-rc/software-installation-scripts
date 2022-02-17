#!/bin/bash
#SBATCH -N 1
#SBATCH -n 56
#SBATCH -p short
#SBATCH -t 04:00:00
#SBATCH -J build_Lammps-mpi
#SBATCH --constraint=cascadelake

#====================================================================================
#title           :install_lammps.bash
#description     :This script will install the parallel Lammps + with MKL support.
#author          :Mariana Levi
#date            :Feb. 2022
#version         :0.2    
#usage           :sbatch install_lammps.bash
#notes           :Installs Lammps+ using GNU 10.1.0, MKL and OpenMPI 4.1.2.
#bash_version    :4.2.46(2)-release (x86_64-redhat-linux-gnu)
#====================================================================================

## Source lammps environment (define the SOFTWARE_DIR variable in the script first):
source env_lammps.bash

mkdir -p $SOFTWARE_DIR $SOFTWARE_INSTALL_PATH/lib 

## Build FFTW3 with MKL:
cd $MKLROOT/interfaces/fftw3xc
make libintel64 compiler=gnu INSTALL_DIR=$SOFTWARE_INSTALL_PATH/lib INSTALL_LIBNAME=libfftw3xc.so
cd $MKLROOT/interfaces/fftw3xf
make libintel64 compiler=gnu INSTALL_DIR=$SOFTWARE_INSTALL_PATH/lib INSTALL_LIBNAME=libfftw3xf.so

cd $SOFTWARE_DIR
## Get latest release (updated with every patch release):
#git clone -b unstable https://github.com/lammps/lammps.git mylammps
wget https://github.com/lammps/lammps/archive/refs/tags/stable_29Sep2021_update2.tar.gz
tar -zxvf stable_29Sep2021_update2.tar.gz
cd stable_29Sep2021_update2

mkdir -p $SOFTWARE_BUILD_PATH
cd $SOFTWARE_BUILD_PATH

## configure:

cmake $SOFTWARE_SRC_PATH/cmake -DPKG_ASPHERE=yes -DPKG_BODY=yes -DPKG_CLASS2=yes -DPKG_COLLOID=yes -DPKG_COMPRESS=yes -DPKG_DIPOLE=yes -DPKG_KSPACE=yes -DPKG_MANYBODY=yes -DPKG_GRANULAR=yes -DPKG_CORESHELL=yes -DPKG_MC=yes -DPKG_MISC=yes -DPKG_MOLECULE=yes -DPKG_MPIIO=yes -DPKG_PERI=yes -DPKG_PYTHON=yes -DPKG_QEQ=yes -DPKG_REPLICA=yes -DPKG_RIGID=yes -DPKG_SHOCK=yes -DPKG_SNAP=yes -DPKG_SPIN=yes -DPKG_SRD=yes -DPKG_USER-REAXC=yes -DPKG_USER-MISC=yes -DBUILD_MPI=yes -DBUILD_OMP=yes -D MKL_INCLUDE_DIR=$MKLROOT/include -D FFT=MKL -D FFTW3_INCLUDE_DIR=$MKLROOT/include/fftw -D FFTW3_LIBRARY=$SOFTWARE_INSTALL_PATH/lib -D FFT_MKL_THREADS=on -D LAMMPS_SIZES=bigbig -D LAMMPS_LONGLONG_TO_LONG=yes -D CMAKE_CXX_COMPILER=mpicxx -D CMAKE_C_COMPILER=mpicc -D CMAKE_Fortran_COMPILER=mpif90 -DCMAKE_TUNE_FLAGS="-O3" -DBUILD_SHARED_LIBS=yes -D PYTHON_EXECUTABLE=$PYTHON -D CMAKE_INSTALL_PREFIX=$SOFTWARE_INSTALL_PATH

## build:
make -j

## install to path $SOFTWARE_INSTALL_PATH:
make install

