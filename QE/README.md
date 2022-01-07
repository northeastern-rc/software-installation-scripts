# Quantum Espersso Installation on Discovery

Here are the steps to install Quantum Espresso (V.7.0) on the Discovery cluster.
Currently, configured to build on the Cascadelake nodes.

1. Login to Discovery and download the scripts repository:

```bash
git clone https://github.com/northeastern-rc/software-installation-scripts.git
```

2. Create a directory where you'd like to build Quantum Espresso. For example:

```bash
mkdir $HOME/q-e
```

3. Copy the QE scripts over to the build directory:

```bash
cp env_qe.sh  install_qe.sh  sample_script.sh $HOME/q-e 
```

4. Enter the directory, and submit the installation script: 

```bash
cd $HOME/q-e
sbatch install_qe.sh  
```
By default, the script will build the programs inside directory: `$HOME/q-e/7.0-cascadelake/bin`. If you'd like to change the installation location, edit the file: `env_qe.sh` (change the value of the variable `SOFTWARE_DIR` in line 17).

5. Wait until the job completes, and check the slurm output and error files for any warning or errors. If all goes well, you can proceed to test it.

5. The script `sample_script.sh` is an example of a possible run using your build. To run it:

```bash
sbatch sample_script.sh
```

Note that there's a wide veriety of sample input files provided in the QE `test-suite` directory. Please refer to the [QE official manual](http://www.quantum-espresso.org/) for specific instructions on how to run those.


