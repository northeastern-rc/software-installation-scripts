#!/bin/bash
#SBATCH -N 1
#SBATCH -n 16
#SBATCH -p short
#SBATCH -t 03:00:00
#SBATCH --constraint=cascadelake
#SBATCH -J install_OpenSees

#====================================================================================
#title           :install_opensees.sh
#description     :This script will install the parallel OpenSees with dependencies.
#author          :Mariana Levi
#date            :May 2021
#version         :0.1    
#usage           :sbatch install_opensees.sh
#notes           :Installs OpenSees and dependencies using Intel2019-4 compilers & MPICH/3.3.2.
#bash_version    :4.2.46(2)-release (x86_64-redhat-linux-gnu)
#====================================================================================

## Set the user-defined path - all libraries will be installed inside:
## Make sure to change $PWD to where your OpenSees root path is located.
export SOFTWARE_DIR=$PWD

module purge
module load discovery
module load intel/2019-4
module load mpich/3.3.2-intel
module load intel/mkl-2020u2

export MPICC_CC=mpicc
export MPICXX_CXX=mpicxx
export MPIF90_F90=mpif90

## Where dependency libraries are:
export LIBSDIR=$SOFTWARE_DIR/lib
export BINSDIR=$SOFTWARE_DIR/bin
export SRCDIR=$SOFTWARE_DIR/src
export INCLUDEDIR=$SOFTWARE_DIR/include
mkdir -p $LIBSDIR $BINSDIR $SRCDIR $INCLUDEDIR

## Source dependency location:
export PATH=$BINSDIR:$PATH
export CPATH=$INCLUDEDIR:$CPATH
export LD_LIBRARY_PATH=$LIBSDIR:$LD_LIBRARY_PATH
export LIBRARY_PATH=$LIBSDIR:$LIBRARY_PATH
export PKG_CONFIG_PATH=$LIBSDIR/pkgconfig:$PKG_CONFIG_PATH

# 1. install PETSC:
cd $SOFTWARE_DIR/src
wget http://ftp.mcs.anl.gov/pub/petsc/release-snapshots/petsc-lite-3.15.0.tar.gz
tar -zxvf petsc-lite-3.15.0.tar.gz
cd petsc-3.15.0

./configure --prefix=$SOFTWARE_DIR --with-cc=mpicc --with-cxx=mpicxx --with-fc=mpif90 COPTFLAGS=-O2 CXXOPTFLAGS=-O2 FOPTFLAGS=-O2 --with-blaslapack-dir=$MKLROOT --with-scalapack-dir=$MKLROOT --download-hdf5=yes  PETSC_ARCH=linux-intel-mpich -download-szlib=yes  

make PETSC_DIR=/work/rc/mariana.levi/software/opensees/src/petsc-3.15.0 PETSC_ARCH=linux-intel-mpich all
make PETSC_DIR=/work/rc/mariana.levi/software/opensees/src/petsc-3.15.0 PETSC_ARCH=linux-intel-mpich install

# 2. install PT SCOTCH:
cd $SOFTWARE_DIR/src
wget https://gitlab.inria.fr/scotch/scotch/-/archive/v6.1.0/scotch-v6.1.0.tar.gz
cd src
line1="mpiicc"
line2="mpicc"
sed "s|$line1|$line2|g" Make.inc/Makefile.inc.x86-64_pc_linux2.icc.impi > Makefile.inc
make -j10 ptesmumps

export SCOTCH_DIR=$SOFTWARE_DIR/src/scotch-v6.1.0

# 3. METIS and ParMETIS:
cd $SOFTWARE_DIR/src
wget http://glaros.dtc.umn.edu/gkhome/fetch/sw/parmetis/parmetis-4.0.3.tar.gz
tar -zxvf parmetis-4.0.3.tar.gz
cd parmetis-4.0.3
line1='#define IDXTYPEWIDTH 32'
line1new='#define IDXTYPEWIDTH 64'
line2='#define REALTYPEWIDTH 32'
line2new='#define REALTYPEWIDTH 64'
module load cmake/3.18.1

sed "s|$line1|$line1new|g;s|$line2|$line2new|g" metis/include/metis.h > metis/include/metis.h.tmp
mv metis/include/metis.h.tmp metis/include/metis.h

make config openmp=-qopenmp cc=mpicc cxx=mpicxx prefix=$SOFTWARE_DIR
make -j10
make install

#build metis:
cd metis
make config openmp=-qopenmp cc=mpicc prefix=$SOFTWARE_DIR
make -j10
make install

# 3. install MUMPS:
cd $SOFTWARE_DIR/src
wget http://mumps.enseeiht.fr/MUMPS_5.0.2.tar.gz
tar -zxvf MUMPS_5.0.2.tar.gz
cd MUMPS_5.0.2
#ln -s Make.inc/Makefile.INTEL.PAR Makefile.inc
cp $SOFTWARE_DIR/Makefile_MUMPS.inc .
make -j10

export MUMPSDIR=$SOFTWARE_DIR/src/MUMPS_5.0.2

# 4. install OPENSEES:
cd $SOFTWARE_DIR
## Change according to the version you need - this clones master:
git clone https://github.com/OpenSees/OpenSees.git
cd $SOFTWARE_DIR/OpenSees
mkdir -p bin lib
cp $SOFTWARE_DIR/Makefile_OPENSEES.def Makefile.def
make wipeall
make -j10 2>&1 | tee make.log
