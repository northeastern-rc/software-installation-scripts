#!/bin/bash
set -e 
#SBATCH -N 1
#SBATCH -n 12
#SBATCH -p gpu
#SBATCH --gres=gpu:v100-sxm2:1
#SBATCH --mem=10G
#SBATCH -t 02:00:00
#SBATCH -J install_relion_3.1.3

source relion-env.bash 
SOFTWARE_DIR=${HOME}
INSTALLATION_DIR=${mypath}
cd ${SOFTWARE_DIR}
git clone https://github.com/3dem/relion.git
cd relion
git checkout master
#git checkout 3.1.3
mkdir build-3.1.3
cd build-3.1.3


CC=icc CXX=icpc cmake .. -DCUDA_ARCH=70 -DCMAKE_INSTALL_PREFIX=${INSTALLATION_DIR} -DMKLFFT=ON -DTIFF_LIBRARY=/shared/centos7/tiff/4.0.9/lib/libtiff.so -DTIFF_INCLUDE_DIR=/shared/centos7/tiff/4.0.9/include -DCUDA=ON -DCUDA_NVCC_FLAGS="-allow-unsupported-compiler"

make -j12
make install
