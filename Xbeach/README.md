## Installation instructions of Xbeach + MPI + NetCDF on Discovery:

Step 1 - clone the scripts to your local directory:
```bash
cd $HOME
git clone https://github.com/northeastern-rc/software-installation-scripts.git
cd software-installation-scripts/Xbeach
sbatch install_xbeach.bash
```

In the file env_xbeach.bash edit the SOFTWARE_DIR to the directory where Xbeach was downloaded
and replace the SOFTWARE_INSTALL_PATH to the path where you would like to install

To run xbeach :
```
Using MPI: 
mpirun -n <number of process> xbeach
```



