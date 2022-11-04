#!/bin/bash
#SBATCH --nodes=1
#SBATCH --ntasks=8
#SBATCH --cpus-per-task=8
#SBATCH --constraint=zen2
#SBATCH --time=24:00:00
#SBATCH --job-name=test
#SBATCH --partition=short
#SBATCH --mem=200GB
#SBATCH --output=%j.o.slurm
#SBATCH --error=%j.e.slurm
 
## to have the best performance the CP2K team recommends a mix between OpenMP threads and MPI. 
## Note the this is just an example, please benchmark your own system with differnet OpenMP+MPI combinations. 

module load gcc/11.1.0
module load openmpi/4.1.2-gcc11.1
module load cp2k/9.1-zen2
 
source /shared/centos7/cp2k/cp2k-9.1-zen2/tools/toolchain/install/setup

export OMP_NUM_THREADS=8
srun --ntasks=8 --cpus-per-task=8 --mem=200GB cp2k.psmp qm-mm-npt.inp > qm-mm-npt.out
