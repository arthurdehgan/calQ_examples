# Mammouth cluster instructions

## General Information

The server is mp2.calculquebec.ca or mp2b.calculquebec.ca (same connexion, different route, just choose whichever you prefer).  
The maximum number of cores per node is 24.  
Storage in your home folder is limited to 50GB.  
By default the memory allocated for a job is 256M asking for more memory will result in more waiting time before the job starts. Same thing with node count and duration of the job.  

## Documentation

Documentation can be found [here][mammoth doc] and is up to date.

### How to connect to the login nodes

Use ssh to connect to the login nodes (do *not* run code on the login nodes), use bash.
```bash
ssh username@mp2b.calculquebec.ca
```
_Note: you can use puTTY on windows to access the login nodes_

### How to send data to the server

Use ssh to transfer data on the server (see information about storage to know where to put your data).
_Note: Use winSCP or firezilla or any ssh file transfer utility to transfer files from a windows machine._
```bash
scp my_file username@mp2b.calculquebec.ca:/path/to/desired/folder/
```

To transfer from the server to your local machine:
```bash
scp username@mp2b.calculquebec.ca:/path/to/file path/to/destination/folder/
```

examples:
```bash
scp username@mp2b.calculquebec.ca:script/classif.py .
# Will transfer the file classif.py from $HOME/script to the local folder.

scp -r data/* username@mp2b.calculquebec.ca:/home/username/data/ 
# Will transfer all the files in the local data folder to my remote $HOME/data folder
```

More info on the [official doc][mammoth doc]

### How to set up your python environment

First, decide which version of python you are going to use (if you don't know what version to use go for python 3.7.0, it is retrocompatible with all python3 versions). List all python version available:
```bash
module spider python
```

Load the chosen python version:
```bash
module load python/x.y.z  
```
(x, y and z corresponding to your python version eg. 3.7.0)

Create a new python environment:
```bash
python -m venv "python_env"
```

Activate the environment:
```bash
source $HOME/python_env/bin/activate
```

Update pip (optional):
```bash
pip install pip -U
```

Install desired packages:
```bash
pip install package1 package2 package3
```
eg. pip install sklearn brainpipe

That's it your python environment is now set up. You can test it by entering the python command prompt and importing your packages. To deactivate the environment simply enter the "deactivate" command.

### How to write a submission job

Use the example_submission as a basis and change the python version, the path to the environment and the path to the script accordingly.  
You can also specify the number of nodes to use with --nodes and --ntasks-per-node  
For exemple i want to use 48 threads for my script, I add to my file:  
```bash
#SBATCH --nodes=2  
#SBATCH --ntasks-per-node=24  
```
More info on the options can be found [here][mammoth jobs]

### How to submit a job

You have to prepare a submission bash script with all the parameters and the modules and then run it with:

```bash
sbatch example_submission.sh
```

### How to check on my jobs

With the following command:
```bash
squeue -u username
```

### Other usefull commands

To check the list of available modules:
```bash
module avail
```

To check currently loaded modules.
```bash
module list 
```

Looking for a specific module ? use:
```bash
module spider module_name
```

### Information about storage

| Filesystem	| Default Quota	| Lustre-based?	| Backed up?	| Purged?	| Available by Default?	| Mounted on Compute Nodes?|
|:---		|:--:					| :--:	| :--:	| :--:	| :--:|:--:|
| Home Space	| 50 GB and 500K files per user[1]	| Yes	| Yes	| No	| Yes	| Yes|
| Scratch Space	| 20 TB and 1M files per user		| Yes	| No	| Files older than 60 days are purged.	| Yes	| Yes|
| Project Space	| 1 TB and 500k files per group[3]	| Yes	| Yes	| No	| Yes	| Yes|

[mammoth status]: http://serveurscq.computecanada.ca/services/mammoth
[mammoth doc]: http://wiki.ccs.usherbrooke.ca/Mammouth-Mp2b#Documentation
[mammoth transfer]: https://docs.computecanada.ca/wiki/Transferring_data
[mammoth jobs]: https://docs.computecanada.ca/wiki/Running_jobs
[mammoth modules]: https://docs.computecanada.ca/wiki/Utiliser_des_modules/en
[mammoth storage]: https://docs.computecanada.ca/wiki/Storage_and_file_management
