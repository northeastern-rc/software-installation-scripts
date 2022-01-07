#!/bin/bash
#SBATCH -N 2
#SBATCH -n 64
#SBATCH -p express
#SBATCH -t 01:00:00
#SBATCH --constraint=cascadelake
#SBATCH -J sample_run

source env_qe.sh

mkdir test
cd test
cp $qedir/test-suite/pw_scf/scf-2.in .
mpirun -np 64 pw.x < scf-2.in > scf-2.out
