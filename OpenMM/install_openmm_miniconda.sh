#!/bin/bash
#SBATCH -N 1 
#SBATCH -n 10
#SBATCH -p gpu
#SBATCH --gres=gpu:v100-sxm2:1
#SBATCH --constraint=skylake_avx512
#SBATCH -t 04:00:00
#SBATCH --output=openmm_install.out
#SBATCH --error=openmm_install.err

#====================================================================================
#title           :install_openmm_miniconda.sh
#description     :This script will install the parallel OpenMM - version 7.7. With GPU support and Miniconda. Build script for the Skylake AVX512 arch.
#author          :Mariana Levi
#date            :March 2022
#version         :0.1    
#usage           :sbatch install_openmm_miniconda.sh
#notes           :Installs OpenMM after dependencies were installed. Uses Miniconda + CUDA. Will install for v100-sxm2 GPU types.
#bash_version    :4.2.46(2)-release (x86_64-redhat-linux-gnu)
#====================================================================================

set -e

## Set the software environment:
source "$( dirname $0 )/env_openmm_miniconda.sh"


## set up miniconda3 virtual environment for openmm:
conda update conda -y ##comment this line out if using a module instead of your own miniconda3.
conda create --name openmm python=3.8 -y
conda activate openmm
conda install -c anaconda numpy cython -y
conda install cmake -y
export PYTHON=`which python3.8`

mkdir -p $OPEMMDIR/src
cd $OPEMMDIR/src

## swig 3 dependency installation:
export SWIGDIR=$OPEMMDIR/swig-3.0.5
wget https://prdownloads.sourceforge.net/swig/swig-3.0.5.tar.gz
tar xvzf swig-3.0.5.tar.gz
cd swig-3.0.5
./configure	--prefix=$SWIGDIR \
	--with-perl5=/usr/bin/perl \
	--with-python=$PYTHON \
	--with-ruby=/usr/bin/ruby
make -j
make install

export PATH=$SWIGDIR/bin:$PATH

## Install OpenMM7.7:
cd $OPEMMDIR/src
wget https://github.com/openmm/openmm/archive/refs/tags/7.7.0.tar.gz
wget -O openmm-7.7.0.tar.gz https://github.com/openmm/openmm/archive/refs/tags/7.7.0.tar.gz
tar -zxf openmm-7.7.0.tar.gz
cd openmm-7.7.0
mkdir -p build_openmm
cd build_openmm

## Note - if building for another architecutre, make sure to modify this line:
#export MY_OPT_FLAGS="-03 -march=skylake-avx512"
export MY_OPT_FLAGS="-march=skylake-avx512"

cmake ../ -DOPENCL_LIBRARY=/shared/centos7/cuda/11.2/lib64/libOpenCL.so \
	-DOPENMM_BUILD_CUDA_LIB=ON \
	-DOPENMM_BUILD_OPENCL_LIB=OFF \
	-DCUDA_HOST_COMPILER=/shared/centos7/gcc/10.1.0/bin/gcc \
	-DCUDA_TOOLKIT_ROOT_DIR=/shared/centos7/cuda/11.2 \
	-DCMAKE_INSTALL_PREFIX=$PREFIXNAME \
	-DPYTHON_EXECUTABLE=$PYTHON \
	-DCMAKE_C_FLAGS=$MY_OPT_FLAGS \
	-DCMAKE_CXX_FLAGS=$MY_OPT_FLAGS \
	-DCMAKE_Fortran_FLAGS=$MY_OPT_FLAGS \
	-DMPI_INCLUDE_PATH=/shared/centos7/openmpi/4.1.0-gcc10.1-cuda11.2/include \
	-DMPI_LIBRARIES=/shared/centos7/openmpi/4.1.0-gcc10.1-cuda11.2/lib \
	-DCMAKE_INCLUDE_PATH=/shared/centos7/gcc/10.1.0/include:/shared/centos7/openmpi/4.1.0-gcc10.1-cuda11.2/include:/shared/centos7/cuda/11.2/include:$MYCONDA_DIR/include \
	-DCMAKE_LIBRARY_PATH=/shared/centos7/gcc/10.1.0/lib:/shared/centos7/openmpi/4.1.0-gcc10.1-cuda11.2/lib:/shared/centos7/cuda/11.2/lib:$MYCONDA_DIR/lib:/shared/centos7/cuda/11.2/lib64

make -j
make install
make PythonInstall

## Deleting tar files
rm $OPEMMDIR/src/swig-3.0.5.tar.gz
rm $OPEMMDIR/src/openmm-7.7.0.tar.gz
