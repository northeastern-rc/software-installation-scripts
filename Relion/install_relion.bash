#!/bin/bash
#SBATCH -N 1
#SBATCH -n 12
#SBATCH -p gpu
#SBATCH --gres=gpu:v100-sxm2:1
#SBATCH --mem=10G
#SBATCH -t 02:00:00
#SBATCH -J install_relion

## This script installs the RELION software version on Discovery, with GPU support.
## Usage: sbatch install_relion.bash 
## Note - make sure the file relion-env.bash is in the same location as this script.
set -e 

## Source environment variables and modules to install RELION:
source relion-env.bash 

## Download software:
cd ${SOFTWARE_DIR}
git clone https://github.com/3dem/relion.git
cd relion
## Switch to the desired branch:
git checkout ${RELION_VERSION}
## Create a build directory:
mkdir build-${RELION_VERSION}
cd build-${RELION_VERSION}
## Configure the build - using V100 GPU 70 ARCH, MKL support and MPI support:
CC=icc CXX=icpc cmake .. -DCUDA_ARCH=70 -DCMAKE_INSTALL_PREFIX=${INSTALL_DIR} -DMKLFFT=ON -DTIFF_LIBRARY=/shared/centos7/tiff/4.0.9/lib/libtiff.so -DTIFF_INCLUDE_DIR=/shared/centos7/tiff/4.0.9/include -DCUDA=ON -DCUDA_NVCC_FLAGS="-allow-unsupported-compiler"
## Build the software:
make -j12
## Install it to the desired location:
make install
