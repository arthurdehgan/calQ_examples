# Mammouth cluster instructions

## General Information

The server is mp2b.calculquebec.ca.  
The maximum number of cores per node is 24.  
Storage in your home folder is limited to 50GB.  
The maximum (RAM) memory per node you can ask for is 31GB.  
By default the memory allocated for a job is 256M asking for more memory will result in more waiting time before the job starts. Same thing with node count and duration of the job.  

## Documentation

Documentation can be found [here][mammoth doc] and is up to date.

## Tutorials 

### How to connect to the login nodes

Use ssh to connect to the login nodes (do *not* run code on the login nodes), use bash.  
Replace _username_ by your CalculQuebec login. Give your calcul Canada password when prompted.
```bash
# Run locally
ssh username@mp2b.calculquebec.ca
```
_Note: you can use puTTY on windows to access the login nodes_

Once you entered the command, answered yes to the question and entered your password, you are connected on the remote server and any command entered after this one will be executed on the remote server.  
**When _"Run on remote server"_ or _"Run locally:_ is indicated before a command check twice you are in the right terminal because some commands may cause problems.**

### How to send data to the server

#### Option 1: Tranfer files from and to the server

With this option you will have to write commands to everytime you want to make changes to your code or want to take some data from the server.

Use ssh to transfer data on the server (see information about storage to know where to put your data).
_Note: Use winSCP or firezilla or any ssh file transfer utility to transfer files from a windows machine._
```bash
# Run locally
rsync -v my_file username@mp2b.calculquebec.ca:/path/to/desired/folder/
```

To transfer from the server to your local machine:
```bash
# Run locally
rsync -v username@mp2b.calculquebec.ca:/path/to/file path/to/destination/folder/
```

examples:
```bash
rsync -v username@mp2b.calculquebec.ca:script/classif.py .
# Will transfer the file classif.py from $HOME/script to the local folder.

rsync -vr data/* username@mp2b.calculquebec.ca:/home/username/data/
# Will transfer all the files in the local data folder to my remote $HOME/data folder
```

_Note: You can use scp instead of rsync for transfers but rsync is generally faster and more reliable than scp._

#### Option 2: Mount a remote filesystem locally

With this option you can create a folder that is connected to the a remote folder from the mammoth server. You can edit files locally with your editor and copy/paste files from your file explorer directly to the remote server.

First you will need to create a folder that will be the one conected to the server:
```bash
# Run locally
cd $HOME
mkdir mammoth
```

Then connect the local folder to the remote folder of your choice:
```bash
# Run locally
sshfs username@mp2b.calculquebec.ca:/path/to/folder mammoth
```

example to set your remote $HOME folder to a mammoth folder in your locam $HOME folder:
```bash
# Run locally
cd && mkdir mammoth
sshfs username@mp2b.calculquebec.ca:./ mammoth
```

Note: You will have to run the command again if you see your mp2 folder is empty (which can happen if connexion to the server is lost.  
That's it, now every file or folder you add/modify/remove in this local mammoth folder will be added/modified/removed from your remote folder on the mammoth server.

More info on the [official doc][mammoth transfer]

### How to set up your python environment

First, decide which version of python you are going to use (if you don't know what version to use go for python 3.7.0, it is retrocompatible with all python3 versions). List all python version available:
```bash
# Run on remote server
module spider python
```

Load the chosen python version:
```bash
# Run on remote server
module load python/x.y.z
```
(x, y and z corresponding to your python version eg. 3.7.0)

Create a new python environment:
```bash
# Run on remote server
python -m venv "python_env"
```

Activate the environment:
```bash
# Run on remote server
source $HOME/python_env/bin/activate
```

Update pip (optional):
```bash
# Run on remote server
pip install pip -U
```

Install desired packages:
```bash
# Run on remote server
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
# Run on remote server
sbatch example_submission.sh
```

### How to delete/cancel a job

```bash
# Run on remote server
scancel <jobid>
```
The jobid of your jobs can be found by listing them (see How to check on my jobs)

### How to check on my jobs

With the following command:
```bash
# Run on remote server
squeue -u username
```

### Other usefull commands

To check the list of available modules:
```bash
# Run on remote server
module avail
```

To check currently loaded modules.
```bash
# Run on remote server
module list
```

Looking for a specific module ? use:
```bash
# Run on remote server
module spider module_name
```

More info [here][mammoth modules]

### Information about storage

| Filesystem	| Default Quota	| Lustre-based?	| Backed up?	| Purged?	| Available by Default?	| Mounted on Compute Nodes?|
|:---		|:--:					| :--:	| :--:	| :--:	| :--:|:--:|
| Home Space	| 50 GB and 500K files per user[1]	| Yes	| Yes	| No	| Yes	| Yes|
| Scratch Space	| 20 TB and 1M files per user		| Yes	| No	| Files older than 60 days are purged.	| Yes	| Yes|
| Project Space	| 1 TB and 500k files per group[3]	| Yes	| Yes	| No	| Yes	| Yes|

More info [here][mammoth storage]

[mammoth doc]: http://wiki.ccs.usherbrooke.ca/Mammouth-Mp2b#Documentation
[mammoth transfer]: https://docs.computecanada.ca/wiki/Transferring_data
[mammoth jobs]: https://docs.computecanada.ca/wiki/Running_jobs
[mammoth modules]: https://docs.computecanada.ca/wiki/Utiliser_des_modules/en
[mammoth storage]: https://docs.computecanada.ca/wiki/Storage_and_file_management
