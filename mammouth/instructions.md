# Instrucions pour Mammouth

## Documentation

Documentation can be found [here][mammoth doc] and is up to date.

### How to set up your python environment

First, decide which version of python you are going to use (if you don't know what version to use go for python 3.7.0, it is retrocompatible with all python3 versions). List all python version available by running the command:

module spider python

Load the chosen python version with:

module load python/x.y.z
(x, y and z corresponding to your python version eg. 3.7.0)

Create a new python environment with the command:

python -m venv "python_env"

Activate the environment with:

source $HOME/python_env/bin/activate

Install desired packages with:

pip install package1 package2 package3
eg. pip install sklearn brainpipe

That's it your python environment is now set up. You can test it by entering the python command prompt and importing your packages. To deactivate the environment simply enter the "deactivate" command.

### How to write a submission job

Use the example_submission as a basis and change the python version, the path to the environment and the path to the script accordingly.
More info on the options can be found [here][mammoth doc]

### How to submit a job

You have to prepare a submission bash script with all the parameters and the modules and then run it with:

sbatch example_submission.sh

Parameters inside the submission script can be overwritten with the command :

sbatch --time=00:30:00 example_submission.sh

[mammoth doc]: http://wiki.ccs.usherbrooke.ca/Mammouth-Mp2b#Documentation
