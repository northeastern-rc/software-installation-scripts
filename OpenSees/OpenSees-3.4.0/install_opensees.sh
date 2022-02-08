#!/bin/bash
#SBATCH -N 1
#SBATCH -n 16
#SBATCH -p short
#SBATCH -t 03:00:00
#SBATCH --constraint=ib
#SBATCH -J install_OpenSees

#====================================================================================
#title           :install_opensees.sh
#description     :This script will install the parallel (MP) OpenSees 3.4.0 with dependencies.
#author          :Mariana Levi
#date            :Feb 2022
#version         :0.3    
#usage           :sbatch install_opensees.sh
#notes           :Installs OpenSeesMP 3.4.0 and dependencies using Intel compilers, MKL and MPICH.
#bash_version    :4.2.46(2)-release (x86_64-redhat-linux-gnu)
#====================================================================================

## Set up the environment, load modules and define Shell environment variables. Note - change the script setenv_opensees.sh to indicate your desired build path.
source setenv_opensees.sh

## Create initial directories:
mkdir -p $LIBSDIR $BINSDIR $SRCDIR $INCLUDEDIR

# 1. install PT SCOTCH:
cd $SOFTWARE_DIR/src
wget https://gitlab.inria.fr/scotch/scotch/-/archive/v6.1.0/scotch-v6.1.0.tar.gz
tar -zxvf scotch-v6.1.0.tar.gz
cd scotch-v6.1.0/src
cp $SOFTWARE_DIR/Makefile_SCOTCH Makefile.inc
make -j10 ptesmumps

# 2. METIS and ParMETIS:
cd $SOFTWARE_DIR/src
wget http://glaros.dtc.umn.edu/gkhome/fetch/sw/parmetis/parmetis-4.0.3.tar.gz
tar -zxvf parmetis-4.0.3.tar.gz
cd parmetis-4.0.3
yes | cp -rf $SOFTWARE_DIR/metis_64bit.h metis/include/metis.h
module load cmake/3.18.1

make config openmp=-qopenmp cc=mpicc cxx=mpicxx prefix=$SOFTWARE_DIR
make -j10
make install

#build metis:
cd metis
make config openmp=-qopenmp cc=mpicc cxx=mpicxx prefix=$SOFTWARE_DIR
make -j10
make install


# 3. install MUMPS:
cd $SOFTWARE_DIR/src
wget http://mumps.enseeiht.fr/MUMPS_5.0.2.tar.gz
tar -zxvf MUMPS_5.0.2.tar.gz
cd MUMPS_5.0.2
cp $SOFTWARE_DIR/Makefile_MUMPS Makefile.inc
make -j10 alllib

# 4. Install OpenSees:
cd $SOFTWARE_DIR/src
wget https://github.com/OpenSees/OpenSees/archive/refs/tags/v3.4.0.tar.gz
tar -zxvf v3.4.0.tar.gz
mv OpenSees-3.4.0 ../OpenSees
cd ../OpenSees
mkdir -p bin lib
cp $SOFTWARE_DIR/Makefile_OPENSEES Makefile.def
make -j10 2>&1 | tee make.log

