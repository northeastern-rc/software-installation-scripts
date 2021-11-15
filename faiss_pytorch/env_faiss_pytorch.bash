#!/bin/bash

#====================================================================================
#title           :env_faiss_pytorch.bash
#description     :This script will source Pytorch (v. 1.10.0) and faiss (v.1.7.1 git). 
#author          :Mariana Levi
#date            :Nov. 2021
#version         :0.1    
#usage           :source env_faiss_pytorch.bash
#notes           :Source the shell environment variables in order to build and run Pytorch (v. 1.10.0) and faiss (v.1.7.1 git). Loads compilers, anaconda3, MKL and GNU 10.1.0 compilers, sets environment variables and compilation flags.  
#bash_version    :4.2.46(2)-release (x86_64-redhat-linux-gnu)
#====================================================================================

#### CHANGE THIS IF NEEDED ###############
# root directory installation for faiss:
export software_dir=$HOME/faiss_pytorch
## virtual conda environment settings:
export envname=faiss_pytorch   ## conda environment name
export envpath=$HOME/.conda/envs/$envname  ## conda environment location ( is set by default, don't change unless you use: `conda create -n $envname --prefix=$envpath` which isn't used here as default.
##### END OF CHANGES #####################

export PYTHON=`which python`
export VERSION=1.7.1

module load anaconda3/2021.11 cuda/11.3
module load intel/mkl-2021.3.0 
module load gcc/10.1.0

export CC=`which gcc`
export CXX=`which g++`
export FC=`which gfortran`
#export FLAGS="-allow-unsupported-compiler -std=c++11 -g -static-intel -O3"
export FLAGS="-std=c++11 -O3"

## (seems to not be necessary if using only the python bindings) Set up environment variables for faiss:
#export install_dir=$software_dir/faiss-$VERSION
#export PATH=$envpath/bin:$install_dir/bin:$PATH
#export LD_LIBRARY_PATH=$envpath/lib:$install_dir/lib:$LD_LIBRARY_PATH
#export CPATH=$envpath/include:$install_dir/include:$CPATH
#export LIBRARY_PATH=$envpath/lib:$install_dir/lib:$LIBRARY_PATH
