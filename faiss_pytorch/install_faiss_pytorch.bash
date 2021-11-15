#!/bin/bash
#SBATCH -N 1
#SBATCH -n 32
#SBATCH --gres=gpu:a100:1
#SBATCH -p ai-jumpstart
#SBATCH -J install_faiss_pytorch
#SBATCH --time=04:00:00

#====================================================================================
#title           :install_faiss_pytorch.bash
#description     :This script will install Pytorch (v. )and faiss (v.1.7.1 git ver.) 
#author          :Mariana Levi
#date            :May 2021
#version         :0.1    
#usage           :sbatch install_faiss_pytorch.bash
#notes           :Installs with CUDA 11.3 support, A100 GPUs, with MKL support, AVX2 and GNU 10.1.0 compilers. 
#bash_version    :4.2.46(2)-release (x86_64-redhat-linux-gnu)
#====================================================================================

### NOTE: if the job fails with sbatch, please try to run the comamnds in this script manually using srun. i.e:
# srun -N 1 -n 32 --gres=gpu:a100:1 -p ai-jumpstart --time=04:00:00 --pty /bin/bash
# source env_faiss_pytorch.bash
# conda create -n $envname python=3.7 -y 
# ...

## Set up the shell environment for the build - set up the build root directory (change if necessary, otherwise will install inside $HOME/faiss_pytorch) and load compilers, MKL and CUDA. Will additionally set compilation environment variables and flags.
source env_faiss_pytorch.bash 

## Create a new virtual conda environment:
conda create -n $envname python=3.7 -y
source activate $envname

## Install Pytorch, swig and cmake to support needed versions for faiss:
conda install mamba -c conda-forge -y ## for parallel conda installations
mamba install pytorch torchvision torchaudio cudatoolkit=11.3 -c pytorch -y
export PYTHON=`which python`
mamba install -c conda-forge swig cmake -y

## Install faiss
## Source: https://github.com/facebookresearch/faiss/blob/main/INSTALL.md#building-from-source
mkdir -p $software_dir
cd $software_dir
git clone https://github.com/facebookresearch/faiss.git
cd faiss
mkdir -p build
cd build
## Configuration Step - makes sure to use the right compiler flags and compilers, CUDA, MKL and CUDA arch for A100, and AVX2 optimization support (change flags if needed, and re-buid):
FC=$FC CC=$CC CXX=$CXX CFLAGS=$FLAGS CXXFLAGS=$FLAGS cmake ../ -DFAISS_ENABLE_GPU=ON  -DFAISS_ENABLE_PYTHON=ON -DBUILD_SHARED_LIBS=ON -DFAISS_OPT_LEVEL=avx2 -DBLA_VENDOR="Intel10_64ilp_seq" -DMKL_LIBRARIES=$MKLROOT/lib/intel64/libmkl_intel_ilp64.so -DCUDAToolkit_ROOT=$CUDA_HOME -DCMAKE_CUDA_ARCHITECTURES="80" -DPython_EXECUTABLE=$PYTHON
## Building the faiss libraries:
make -j faiss
## Building the python bindings:
make -j swigfaiss
cd faiss/python
python setup.py install
## This step of make install is currently not needed:
#cd $software_dir/faiss/build
#make install
 
