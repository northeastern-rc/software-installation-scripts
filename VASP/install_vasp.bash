#!/bin/bash

#SBATCH -N 1
#SBATCH --cpus-per-task=20
#SBATCH -p short
#SBATCH --mem=10G
#SBATCH -t 04:00:00
#SBATCH --constraint=cascadelake
#SBATCH --constraint=ib
#SBATCH -J install_vasp


#====================================================================================
#title           :install_vasp.bash
#description     :This script will install the Vasp with Intel Compilers 2021.1 and OpenMPI.
#author          :Prasanth Dwadasi
#date            :June. 2022
#version         :6.3.1   
#usage           :sbatch install_vasp.bash
#notes           :Installs Vasp with Intel Compilers and OpenMPI
#bash_version    :4.2.46(2)-release (x86_64-redhat-linux-gnu)
#====================================================================================

source env_vasp.bash

mkdir -p $SOFTWARE_BUILD_PATH 

cd $SOFTWARE_DIR

make veryclean
make DEPS=1 -j20
