#!/bin/bash
#SBATCH -N 1
#SBATCH -n 64
#SBATCH -p short
#SBATCH -t 02:00:00
#SBATCH -J install_cp2k
#SBATCH --constraint=zen2

#====================================================================================
#title           :install_cp2k_zen2.bash
#description     :This script will the dependencies and program CP2K 9.1 for
#                 zen2 AMD microarchitecture.
#author          :Mariana Levi
#date            :April 2022
#version         :0.1    
#usage           :sbatch install_cp2k_zen2
#notes           :Installs CP2K 9.1 and its dependencies using GNU 11.1.0, OpenMPI 4.1.2 and 
#                 Intel 2022.0.1 MKL. No Sirius or libxsmm (not compatible with zen2).
#                 Support for SSMP and PSMP.
#bash_version    :4.2.46(2)-release (x86_64-redhat-linux-gnu)
#====================================================================================

set -e

mkdir -p $SOFTWARE_DIR
cd $SOFTWARE_DIR

## Download software:
wget https://github.com/cp2k/cp2k/releases/download/v$VERSION.0/cp2k-$VERSION.tar.bz2
tar -xvf cp2k-$VERSION.tar.bz2
mv $SOFTWARE_DIR/cp2k-$VERSION $INSTALL_DIR
cd $INSTALL_DIR/tools/toolchain

## Install toolchain:
./install_cp2k_toolchain.sh --no-check-certificate -j 64 --with-gcc=system --with-cmake=system --with-openmpi=system --with-mkl=system --with-libsmm=install --with-libxsmm=no --with-spla=no --with-sirius=no 

cp $INSTALL_DIR/tools/toolchain/install/arch/* $INSTALL_DIR/arch/. 

## source toolchain:
source $INSTALL_DIR/tools/toolchain/install/setup  

## build cp2k:
cd $INSTALL_DIR
make -j 64 ARCH=local VERSION="ssmp sdbg psmp pdbg"
