# Installation instructions for RELION 4.0 on NU HPC
These scripts provide the installation instructions of [RELION](https://relion.readthedocs.io/en/release-4.0/Installation.html) version 3.1.3. For detailed instructions of the different installation options, please visit the developer website and adjust scripts accordingly. Current build made with Intel compilers, MPI support, MKL support and GPU V100 support.

## Steps to build the software:
1. Login to the HPC system shell or use the [OnDemand interface](https://rc-docs.northeastern.edu/en/latest/first_steps/connect_ood.html).

2. Enter your desired directory and download the software repository. For example:
```bash
cd $HOME
git clone git@github.com:northeastern-rc/software-installation-scripts.git
cd software-installation-scripts
```

3. Navigate to the Relion directory:
```bash
cd Relion
```

4. Modify source code verion and installation paths inside the script `relion-env.bash` as needed. Then, source the environment script:
```bash
source relion-env.bash
```

5. Submit the installation script to the scheduler:
```bash
sbatch install_relion.bash
```

6. If successfully built, the software should now be avialable in the installation path. 
  
