#!/bin/bash
#SBATCH -N 1
#SBATCH -n 16
#SBATCH -p short
#SBATCH -t 03:00:00
#SBATCH --constraint=cascadelake
#SBATCH -J install_dflowfm_67088

#====================================================================================
#title           :deps_install_67088.sh
#description     :This script installs the dependencies for Delft3D - Flexible Mesh software (version 67088) and SWAN (v40.91-nrlv4.2).
#author          :Mariana Levi
#date            :May 2021
#version         :0.1    
#usage           :sbatch deps_install_67088.sh
#notes           :uses Intel 2021.2.0 compilers, MPI and MKL libraries to install: BZIP2, Libsd, Expat, readline, zlib, hdf5, netcdf-c, netcdf-fortran, libtool, automake, PETSc, metis, parmetis. 
#bash_version    :4.2.46(2)-release (x86_64-redhat-linux-gnu)
#====================================================================================

## Set the user-defined path - all libraries will be installed inside:
## Make sure to change $PWD to where your OpenSees root path is located.
export SOFTWARE_DIR=$PWD

mkdir -p $SOFTWARE_DIR $SOFTWARE_DIR/src
cd $SOFTWARE_DIR/src

source env_dflowfm_67088.sh

#1. BZIP2:
cd $SOFTWARE_DIR/src
wget https://sourceware.org/pub/bzip2/bzip2-1.0.8.tar.gz
tar -zxvf bzip2-1.0.8.tar.gz
cd bzip2-1.0.8
make -f Makefile-libbz2_so
make install PREFIX=$LIBSDIR
cp libbz2.so.1.0.8 $LIBSDIR/lib/libbz2.so

#2. Libsd:
cd $SOFTWARE_DIR/src
wget https://libbsd.freedesktop.org/releases/libbsd-0.10.0.tar.xz
tar -xvf libbsd-0.10.0.tar.xz
cd libbsd-0.10.0
./configure --prefix=$LIBSDIR
make -j
make install

#3. Expat:
cd $SOFTWARE_DIR/src
wget https://github.com/libexpat/libexpat/releases/download/R_2_2_10/expat-2.2.10.tar.bz2
tar -xvf expat-2.2.10.tar.bz2
cd expat-2.2.10
autoconf
CC=icc CXX=icpc FC=ifort CPP='icpc -E' CPPFLAGS="-fPIC -I$LIBSDIR/include" LDFLAGS="-L$LIBSDIR/lib" ./configure --prefix=$LIBSDIR --with-libbsd
make -j
make install

#5. readline:
cd $SOFTWARE_DIR/src
wget https://ftpmirror.gnu.org/readline/readline-8.1.tar.gz
tar -zxvf readline-8.1.tar.gz
cd readline-8.1
C=icc CXX=icpc FC=ifort CPP='icpc -E' CPPFLAGS="-fPIC -I$LIBSDIR/include" LDFLAGS="-L$LIBSDIR/lib" ./configure --prefix=$LIBSDIR --enable-multibyte
make -j
make install

#6. zlib:
cd $SOFTWARE_DIR/src
wget https://zlib.net/zlib-1.2.11.tar.gz
tar -zxvf zlib-1.2.11.tar.gz
cd zlib-1.2.11
C=icc CXX=icpc FC=ifort CPP='icpc -E' CPPFLAGS="-fPIC -I$LIBSDIR/include" LDFLAGS="-L$LIBSDIR/lib" ./configure --prefix=$LIBSDIR
make install

#7. hdf5:
cd $SOFTWARE_DIR/src
wget https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-1.10/hdf5-1.10.1/src/hdf5-1.10.1.tar.gz
tar -zxvf hdf5-1.10.1.tar.gz
cd hdf5-1.10.1
CC=mpiicc FC=mpiifort CXX=mpiicpc CPPFLAGS="-fPIC -I$LIBSDIR/include" LDFLAGS="-L$LIBSDIR/lib" ./configure --enable-shared --enable-hl --enable-parallel --enable-fortran --prefix=$LIBSDIR --with-zlib=$LIBSDIR
make -j
make install

#8. netcdf-c:
cd $SOFTWARE_DIR/src
wget ftp://ftp.unidata.ucar.edu/pub/netcdf/netcdf-c-4.7.4.tar.gz
tar -zxvf netcdf-c-4.7.4.tar.gz
cd netcdf-c-4.7.4
CC=mpiicc FC=mpiifort CXX=mpiicpc CPPFLAGS="-fPIC -I$LIBSDIR/include" LDFLAGS="-L$LIBSDIR/lib" ./configure --prefix=$LIBSDIR --with-hdf5=$LIBSDIR --with-zlib=$LIBSDIR LIBS=-lhdf5 --enable-netcdf4 --disable-dap --disable-fortran-type-check --enable-large-file-tests --with-temp-large=$LIBSDIR
make -j
make install

#9. netcdf-fortran:
cd $SOFTWARE_DIR/src
wget ftp://ftp.unidata.ucar.edu/pub/netcdf/netcdf-fortran-4.5.3.tar.gz
tar -zxvf netcdf-fortran-4.5.3.tar.gz
cd netcdf-fortran-4.5.3
CC=mpiicc FC=mpiifort CXX=mpiicpc CPPFLAGS="-fPIC -I$LIBSDIR/include" LDFLAGS="-L$LIBSDIR/lib" LIBS=-lnetcdf ./configure --prefix=$LIBSDIR
make -j
make install

#10. libtool  https://ftpmirror.gnu.org/libtool/libtool-2.4.6.tar.gz
cd $SOFTWARE_DIR/src
wget  https://ftpmirror.gnu.org/libtool/libtool-2.4.6.tar.gz
tar -zxvf libtool-2.4.6.tar.gz
cd libtool-2.4.6
./configure --prefix=$LIBSDIR CC=$CC
make 
make install

#11. automake-1.15:
cd $SOFTWARE_DIR/src
wget https://ftpmirror.gnu.org/automake/automake-1.15.tar.gz
tar -zxvf automake-1.15.tar.gz
cd automake-1.15
./configure --prefix=$LIBSDIR CC=$CC
make
make install

#12. PETSc 3.13.0:
export PETSC_VERSION=3.13.0
export PETSC_ARCH=linux-intel
cd $SOFTWARE_DIR/src
## !!! copied from dflowfm_src_v1.2.4-67088, together with:
#parametis: v4.0.3-p4.tar.gz
#metis: v5.1.0-p5.tar.gz
wget http://ftp.mcs.anl.gov/pub/petsc/release-snapshots/petsc-lite-3.13.0.tar.gz
tar -zxvf petsc-3.13.0.tar.gz
cd petsc-3.13.0
export MPI_ROOT=$I_MPI_ROOT
export MPICC_CC=mpicc
export MPICXX_CXX=mpicxx
export MPIF90_F90=mpif90
./configure --prefix=$LIBSDIR --with-cc=mpicc --with-cxx=mpicxx --with-fc=mpif90 \
CPPFLAGS=$CPPFLAGS LDFLAGS=$LDFLAGS \
COPTFLAGS=-O2 CXXOPTFLAGS=-O2 FOPTFLAGS=-O2 \
--download-metis=$SOFTWARE_DIR/src/metis.v5.1.0-p5.tar.gz \
--download-parmetis=$SOFTWARE_DIR/src/parametis.v4.0.3-p4.tar.gz \
--with-blaslapack-dir=$MKLROOT \
--with-debugging=1 \
--with-valgrind=1 
make PETSC_DIR=/shared/centos7/delft3dfm/src/petsc-3.13.0 PETSC_ARCH=linux-intel all
make PETSC_DIR=/shared/centos7/delft3dfm/src/petsc-3.13.0 PETSC_ARCH=linux-intel install

