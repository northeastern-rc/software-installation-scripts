#!/bin/bash
## This script sources the OpenMM environemnt to install and run OpenMM.
## Usage: source env_openmm_miniconda.sh

## Define your OpenMM directory. The OpenMM install directory is set to: $OPEMMDIR/7.5.
export OPEMMDIR=$HOME/openmm
export VERSION=7.5
## Provide your miniconda3/anaconda3 local build:
export MYCONDA_DIR=$HOME/miniconda3

## Load libraries:
module load gcc/10.1.0 openmpi/4.1.0-gcc10.1-cuda11.2 cuda/11.2

##Activate Conda/python env:
source $MYCONDA_DIR/bin/activate
export PYTHON=`which python3.8`
export PREFIXNAME=$OPEMMDIR/$VERSION
export SWIGDIR=$OPEMMDIR/swig-3.0.5

export PATH=$SWIGDIR/bin:$PREFIXNAME/bin:$PATH
export LD_LIBRARY_PATH=$PREFIXNAME/lib:$LD_LIBRARY_PATH
export LIBRARY_PATH=$PREFIXNAME/lib:$LIBRARY_PATH
export CPATH=$PREFIXNAME/include:$CPATH
