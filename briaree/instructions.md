# Briaree cluster instructions

## General Information

The server is briaree.calculquebec.ca
The maximum number of cores per node is 12
The path for home folder is "/RQusagers/username"

## Documentation

Documentation can be found [here][briaree doc] but is not up to date.

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
For exemple i want to use 24 threads for my script, I change the node parameter:
```
#PBS -l nodes=2:ppn=12
```
More info on the options can be found [here][briaree doc]

### How to submit a job

You have to prepare a submission bash script with all the parameters and the modules and then run it with:

```
qsub example_submission.sh
```
Select the right queue according to your parameters:  
| Queue | Maximum execution time | Minimum number of nodes per job | Maximum number of nodes per job | Maximum number of cores per user | Maximum number of jobs per user | Maximum number of cores for all jobs |  
| :------------ | :-------------------: | :---: | :---: | :---: | :---: | :---: |  
| test		| 1 h			| 1	| 1	| 1416	| n/a	| n/a	|  
| courte	| 48 h			| 1	| 4	| n/a	| 72	| n/a	|  
| normale	| 168 h (7 days)	| 1	| 4	| 1416	| 36	| n/a	|  
| longue	| 336 h (14 days)	| 1	| 4	| 180	| 24	| 720	|  
| hpcourte	| 48 h			| 5	| 171	| n/a	| n/a	| n/a	|  
| hp		| 168 h (7 days)	| 5	| 171	| 2052	| 8	| n/a	|  

| First Header  | Second Headerssdkfjhajsdhgfiaueuhgfgjhsaklalkjdhflask |
| ------------- | ------------- |
| Ccontenteocujhsflkjhsdlkfjhsalkfdjhsontent Cell  | Content Cell  |
| Content Cell  | Content Cell  |

### How to check on my jobs

With the following command:
```
qstat -u username
```

### Usefull Links

[Server Status][briaree status]

[briaree status]: http://serveurscq.computecanada.ca/services/briaree
[briaree doc]: https://wiki.calculquebec.ca/w/Ex%C3%A9cuter_une_t%C3%A2che/en
