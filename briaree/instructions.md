# Mammouth cluster instructions

## General Information

The server is briaree.calculquebec.ca
The maximum number of cores per node is 24  
By default the memory allocated for a job is 256M asking for more memory will result in more waiting time before the job starts. Same thing with node count and duration of the job.  
The group name for the cocolab if you registered with karim is 'def-kjerbi'

## Documentation

Documentation can be found [here][mammoth doc] and is up to date.

### How to set up your python environment

First, decide which version of python you are going to use (if you don't know what version to use go for python 3.7.0, it is retrocompatible with all python3 versions). List all python version available by running the command:

```
module spider python
```

Load the chosen python version with:

```
module load python/x.y.z  
```
(x, y and z corresponding to your python version eg. 3.7.0)

Create a new python environment with the command:

```
python -m venv "python_env"
```

Activate the environment with:

```
source $HOME/python_env/bin/activate
```

Install desired packages with:

```
pip install package1 package2 package3
```
eg. pip install sklearn brainpipe

That's it your python environment is now set up. You can test it by entering the python command prompt and importing your packages. To deactivate the environment simply enter the "deactivate" command.

### How to write a submission job

Use the example_submission as a basis and change the python version, the path to the environment and the path to the script accordingly.  
You can also specify the number of nodes to use with --nodes and --ntasks-per-node  
For exemple i want to use 48 threads for my script, I add to my file:  
```
#SBATCH --nodes=2  
#SBATCH --ntasks-per-node=24  
```
More info on the options can be found [here][mammoth jobs]

### How to submit a job

You have to prepare a submission bash script with all the parameters and the modules and then run it with:

```
sbatch example_submission.sh
```

Parameters inside the submission script can be overwritten with the command :

```
sbatch --time=00:30:00 example_submission.sh
```

### How to check on my jobs

With the following command:
```
squeue -u username
```

[mammoth doc]: http://wiki.ccs.usherbrooke.ca/Mammouth-Mp2b#Documentation
[mammoth jobs]: https://docs.computecanada.ca/wiki/Running_jobs
