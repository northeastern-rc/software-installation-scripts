#!/bin/bash
#SBATCH --nodes=1
#SBATCH --partition=multigpu 
#SBATCH --time=02:00:00
#SBATCH --cpus-per-task=24
#SBATCH --mem=10GB
#SBATCH --ntasks=1
#SBATCH --gres=gpu:p100:4
#SBATCH --job-name=install_gromacs2022

source env_gromacs.bash

cd ${HOME}
GROMACS_DIR=${HOME}/gromacs-2022
wget https://ftp.gromacs.org/gromacs/gromacs-2022.tar.gz
tar -zxvf gromacs-2022.tar.gz
cd ${GROMACS_DIR}
mkdir build
cd build/

echo "cmake..."
cmake .. -DGMX_BUILD_OWN_FFTW=ON -DREGRESSIONTEST_DOWNLOAD=ON -DGMX_GPU=CUDA -DCMAKE_C_COMPILER=mpicc -DCMAKE_CXX_COMPILER=mpicxx -DCUDA_TOOLKIT_ROOT_DIR=/shared/centos7/cuda/11.4/bin -DGMX_MPI=ON -DCMAKE_INSTALL_PREFIX=${GROMACS_DIR}

make clean
echo "make..."
make -j 24

echo "make check..."
make check
echo "make install..."
make install
echo "Deleting tar files..."
rm -rf ${HOME}/gromacs-2022.tar.gz 
echo "Installation completed!!"
