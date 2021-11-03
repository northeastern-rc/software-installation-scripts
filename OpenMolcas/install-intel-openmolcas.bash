#!/bin/bash
#SBATCH -N 1
#SBATCH -n 32
#SBATCH -p short
#SBATCH -t 04:00:00
#SBATCH --constraint=cascadelake
#SBATCH -J install_openmolcas

#====================================================================================
#title           :install-intel-openmolcas.bash
#description     :This script will install the parallel OpenMolcas latest version.
#author          :Mariana Levi
#date            :November 2021
#version         :0.1    
#usage           :sbatch install-intel-openmolcas.bash
#notes           :Installs OpenMolcas after dependencies were installed (using Intel 2021 compilers) - GA library.
#bash_version    :4.2.46(2)-release (x86_64-redhat-linux-gnu)
#====================================================================================

## Set the software environment:
source env-intel-openmolcas.bash
module load cmake/3.18.1

## Create the software directory and subdirectories:
mkdir -p $SOFTWARE_DIR 
cd $SOFTWARE_DIR

mkdir -p src 

## Install GA:
cd src
# Download source code:
wget https://github.com/GlobalArrays/ga/releases/download/v5.8/ga-5.8.tar.gz
tar -zxvf ga-5.8.tar.gz
cd ga-5.8 
mkdir build-intel2021
cd build-intel2021
# Configure GA:
../configure --prefix=$SOFTWARE_DIR/ga MPICXX=mpiicpc MPICC=mpiicc MPIF77=mpiifort CC=icc FC=ifort --with-mpi --enable-i8 GA_COPT="-march=skylake-avx512" GA_CXXOPT="-march=skylake-avx512" GA_FOPT="-march=skylake-avx512" --enable-i8 --with-blas8="-L$MKLROOT/lib/intel64 -lmkl_intel_ilp64 -lmkl_intel_thread -lmkl_core -liomp5 -lpthread -lm -lmkl_blacs_intelmpi_ilp64 -I$MKLROOT/include" --with-scalapack8="-L$MKLROOT/lib/intel64 -lmkl_scalapack_ilp64 -lmkl_intel_ilp64 -lmkl_intel_thread -lmkl_core -lmkl_blacs_intelmpi_ilp64 -liomp5 -lpthread -lm -lmkl_scalapack_ilp64 -I$MKLROOT/include"
# Install GA:
make -j
make install 

## Install OpenMolcas:
cd $SOFTWARE_DIR
git clone https://gitlab.com/Molcas/OpenMolcas.git
cd OpenMolcas
mkdir build-intel2021
cd build-intel2021
CFLAGS='-O2 -fpic' CXXFLAGS='-O2 -fpic' CPPFLAGS='-O2 -fpic' FFLAGS='-O2 -fpic'  CPP='icpc -E' CXXCPP='icpc -E' CC=mpiicc FC=mpiifort  cmake ../ -DMPI=ON -DBUILD_SHARED_LIBS=ON -DCMAKE_INSTALL_PREFIX=$SOFTWARE_DIR/latest-intel -DGA=ON -DLINALG=MKL -DOPENMP=ON -DCMAKE_C_FLAGS="-march=skylake-avx512" -DCMAKE_CXX_FLAGS="-march=skylake-avx512" -DCMAKE_Fortran_FLAGS="-march=skylake-avx512"
make -j 
make install

## Setup PyMolcas:
cd $SOFTWARE_DIR/OpenMolcas/Tools/pymolcas/
./export.py
pymolcas -setup
