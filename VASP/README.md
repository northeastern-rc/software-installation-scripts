## Installation instructions of VASP 6.1.3 on Discovery:

Step 1 - clone the scripts to the directory where VASP was located dir:
```bash
cd $HOME
git clone https://github.com/northeastern-rc/software-installation-scripts.git
cd software-installation-scripts/VASP
cp *.bash makefile.include $HOME/VASP
sbatch install_vasp.bash
```

In the file env_vasp.bash edit the SOFTWARE_DIR to the directory where VASP was located
copy the scripts to the VASP folder and run sbatch



