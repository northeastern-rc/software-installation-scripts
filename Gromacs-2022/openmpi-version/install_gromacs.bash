#!/bin/bash
#SBATCH --nodes=1
#SBATCH --partition=gpu
#SBATCH --time=02:00:00
#SBATCH --cpus-per-task=12
#SBATCH --mem=10GB
#SBATCH --ntasks=1
#SBATCH --gres=gpu:1
#SBATCH --job-name=install_gromacs2022

source env_gromacs.bash

cd ${INSTALL_DIR}
## Download Gromacs-2022 software source code ##
wget https://ftp.gromacs.org/gromacs/gromacs-2022.tar.gz
tar -zxvf gromacs-2022.tar.gz
cd ${GROMACS_DIR}

mkdir build
cd build/

## Configure ##
cmake .. -DGMX_BUILD_OWN_FFTW=ON \
	-DREGRESSIONTEST_DOWNLOAD=ON \
	-DGMX_GPU=CUDA \
	-DCMAKE_C_COMPILER=mpicc \
	-DCMAKE_CXX_COMPILER=mpicxx \
	-DCUDA_TOOLKIT_ROOT_DIR=/shared/centos7/cuda/11.4/bin \
	-DGMX_MPI=ON \
	-DCMAKE_INSTALL_PREFIX=${GROMACS_DIR}

make clean

## Build ##
make -j 

## Verify the build ##
make check

## Install to path ${GROMACS_DIR}/bin ##
make install

## Delete tar file ##
rm -rf ${INSTALL_DIR}/gromacs-2022.tar.gz
