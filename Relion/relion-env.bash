#!/bin/bash

## This script will set all of the necessary environment varibales to build RELION.
## Modify version as needed (note that installation steps may change accordingly:
RELION_VERSION=3.1.3
## Change the SOFTWARE_DIR path to where you'd like the software source code to be donwloaded:
SOFTWARE_DIR=${HOME}/relion/src
## Change the BUILD_DIR to where you'd like the software build file placed:
BUILD_DIR=${HOME}/relion/build-${RELION_VERSION}
## Change the INSTALL_DIR to where you'd like the software binaries and libraries to be installed (should ideally be differnt than SOFTWARE_DIR.
INSTALL_DIR=${HOME}/relion/install-${RELION_VERSION}

## Load necessary modules which contain libraries and packages needed for the installation:
module load intel/compilers-2021.2.0 openmpi/4.1.0-amd-intel2021 intel/mkl-2021.2.0 cuda/11.3 cmake/3.18.1

## Set paths to binaries and libraries of the software (once built):
export PATH=${INSTALL_DIR}/bin:$PATH
export LD_LIBRARY_PATH=${INSTALL_DIR}/lib:$LD_LIBRARY_PATH
