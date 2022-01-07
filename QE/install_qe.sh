#!/bin/bash
#SBATCH -N 1
#SBATCH -n 56
#SBATCH -p short
#SBATCH -t 04:00:00
#SBATCH --constraint=cascadelake
#SBATCH -J install_q-e_cascadelake

#====================================================================================
#title           :install_opensees.sh
#description     :This script will install the parallel QE with dependencies.
#author          :Mariana Levi
#date            :Jan. 2022
#version         :0.3    
#usage           :sbatch install_qe.sh
#notes           :Installs QE and dependencies using Intel2021 compilers + MKL & Intel MPI. 
#bash_version    :4.2.46(2)-release (x86_64-redhat-linux-gnu)
#====================================================================================

## Set the installation shell environment (modify paths in env_qe.sh first if needed):
## Note - if left unchanged, will install q-e + dependencies in $PWD
source env_qe.sh
rm -rf $SOFTWARE_DIR/src $mylibs $qedir

# Create installation and source directories:
mkdir -p $SOFTWARE_DIR/src $mylibs 

# Install LIBXC:
cd $SOFTWARE_DIR/src
wget https://www.tddft.org/programs/libxc/down.php?file=5.1.3/libxc-5.1.3.tar.gz --no-check-certificate -O libxc-5.1.3.tar.gz
tar -zxvf libxc-5.1.3.tar.gz
cd libxc-5.1.3
mkdir build-$archname
cd build-$archname
export MYCFLAGS="-O3 -I$mylibs/include"
export MYFCFLAGS="-O3 -I$mylibs/include"
CC="mpicc -std=c99" FC=mpif90 CPPFLAGS=$MYCFLAGS CFLAGS=$MYCFLAGS FCFLAGS=$MYFCFLAGS LDFLAGS=$MYLDFLAGS ../configure --prefix=$mylibs
make -j
make install  

# Install FFTW3:
cd $SOFTWARE_DIR/src
wget http://www.fftw.org/fftw-3.3.9.tar.gz
tar -zxvf fftw-3.3.9.tar.gz
cd fftw-3.3.9
mkdir build-$archname
cd build-$archname
export MYCFLAGS="-O3 -I$mylibs/include -fopenmp -w -fallow-argument-mismatch"
export MYFCFLAGS="-O3 -I$mylibs/include -fopenmp -w -fallow-argument-mismatch"
MPICC=mpicc CC=mpicc FC=mpif90 CXX=mpicxx CPPFLAGS=$MYCFLAGS CFLAGS=$MYCFLAGS CXXFLAGS=$MYCFLAGS FFLAGS=$MYFCFLAGS FCFLAGS=$MYFCFLAGS LDFLAGS=$MYLDFLAGS  ../configure --prefix=$mylibs --enable-sse2 --enable-avx --enable-avx2 --enable-shared --enable-openmp --enable-threads --enable-mpi  --enable-float 
make -j
make install 

# Install QE:
cd $SOFTWARE_DIR
wget https://gitlab.com/QEF/q-e/-/archive/qe-7.0/q-e-qe-$qeversion.tar.gz -O qe-$qeversion.tar.gz
tar -zxvf qe-$qeversion.tar.gz
rm -rf qe-$qeversion.tar.gz
mv q-e-qe-$qeversion $qeversion-$archname
cd $qeversion-$archname
export MYCFLAGS="-O3 -w -fallow-argument-mismatch -I$mylibs/include"
export MYFCFLAGS="-O3 -w -fallow-argument-mismatch -I$mylibs/include"

CC=mpicc F77=mpif90 FC=mpif90 CXX=mpicxx CPPFLAGS=$MYCFLAGS CFLAGS=$MYCFLAGS CXXFLAGS=$MYCFLAGS FFLAGS=$MYFCFLAGS FCFLAGS=$MYFCFLAGS LDFLAGS=$MYLDFLAGS ./configure --prefix=$qedir --with-scalapack=yes --enable-parallel --enable-environment --with-libxc=yes --with-libxc-prefix=$mylibs EXTLIB_FLAGS="-L$mylibs/lib -L/shared/centos7/openblas/0.3.13/lib -lopenblas -L/shared/centos7/scalapack/2.1.0-openmpi4.0.5-gcc10.1/lib -lscalapack" LIBS="-L$mylibs/lib -lfftw3f -lfftw3f_mpi -lfftw3f_threads" CPPFLAGS="$MYCFLAGS -I$mylibs/include -I/shared/centos7/openblas/0.3.13/include" 

make -j all
#make install
