# Installation instructions for CP2K on NU HPC:
These scripts provide the installation instructions of [CP2K](https://www.cp2k.org/) version 9.1. For detailed instructions of the different installation options, please visit the developer website and adjust scripts accordingly. Current build made with GNU compilers and MPI support for the AMD zen2 microarchitecutre.

## Steps to build the software:
1. Login to the HPC system shell or use the [OnDemand interface](https://rc-docs.northeastern.edu/en/latest/first_steps/connect_ood.html).

2. Enter your desired directory and download the software repository. For example:
```bash
cd $HOME
git clone git@github.com:northeastern-rc/software-installation-scripts.git
cd software-installation-scripts
```
3. Navigate to the CP2K directory:
```bash
cd CP2K
```

4. Modify source code verion and installation paths inside the script `env_cp2k_zen2.bash ` as needed. Then, source the environment script:
```bash
source env_cp2k_zen2.bash 
```

5. Submit the installation script to the scheduler:
```bash
sbatch install_cp2k_zen2.bash 
```

6. If successfully built, the software should now be avialable in the installation path.

7. You can test the software by using the provided sample script: `sample_cp2k.bash`. 
