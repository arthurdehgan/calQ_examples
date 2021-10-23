# Cedar/Graham cluster instructions

## General Information

The server address is cedar.computecanada.ca or graham.computecanada.ca  
The maximum number of cores per node is 6 for cedar, 16 for graham.  
The memory per core varies from 32GB for cedar, 64 gor graham.  
Asking for more memory and more nodes will generally result in more wait time before the job is run.  

## Documentation

Documentation can be found [here][computecanada doc].

## Tutorials

### How to connect to the login nodes

Use ssh to connect to the login nodes (do *not* run code on the login nodes), use bash.  
Replace _username_ by your CalculQuebec login. Give your CalculQuebec when asked for your password.  
```bash
# Run locally
ssh username@cedar.computecanada.ca
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
rsync -v my_file username@cedar.computecanada.ca:/path/to/desired/folder/
```

To transfer from the server to your local machine:
```bash
# Run locally
rsync -v username@cedar.computecanada.ca:/path/to/file path/to/destination/folder/
```

examples:
```bash
rsync -v username@cedar.computecanada.ca:script/classif.py .
# Will transfer the file classif.py from $HOME/script to the local folder.

rsync -vr data/* username@cedar.computecanada.ca:/RQusagers/username/data/
# Will transfer all the files in the local data folder to my remote $HOME/data folder
```

_Note: You can use scp instead of rsync for transfers but rsync is generally faster and more reliable than scp._

#### Option 2: Mount a remote filesystem locally

With this option you can create a folder that is connected to the a remote folder from the cedar server. You can edit files locally with your editor and copy/paste files from your file explorer directly to the remote server.  

First you will need to create a folder that will be the one conected to the server:
```bash
# Run locally
cd $HOME
mkdir cedar
```

Then connect the local folder to the remote folder of your choice:
```bash
# Run locally
sshfs username@cedar.computecanada.ca:/path/to/folder cedar
```

example to set your remote $HOME folder to a cedar folder in your locam $HOME folder:
```bash
cd && mkdir cedar
sshfs username@cedar.computecanada.ca:./ cedar
```

That's it, now every file or folder you add/modify/remove in this local cedar folder will be added/modified/removed from your remote folder on the cedar server.  

### How to set up your python environment

First, decide which version of python you are going to use (if you don't know what version to use go for python 3.7.0, the latest version of python available on the cluster).

Load the chosen python version:
```bash
# Run on remote server
module load python/x.y.z
```
(x, y and z corresponding to your python version eg. 3.7.0)

Create a new python environment with the command:

```bash
# Run on remote server
python -m venv "env"
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
eg. pip install torch

That's it your python environment is now set up. You can test it by entering the python command prompt and importing your packages. To deactivate the environment simply enter the "deactivate" command.  

### How to write a submission job

Use the example_submission as a basis and change the python version, the path to the environment and the path to the script accordingly.  

The first thing you should change is your account parameter otherwise, the script will not be accepted. You can check your account group name on your computec canada profile page. It should be of the form _abc-name_.  
```bash
#SBATCH --account=abc-name
```

You need to specify the number of nodes to use with --cpus-per-task  
For exemple i want to use 6 threads for my script, I change the node parameter:
```bash
#SBATCH --cpus-per-tasks=6  # 16 for graham
```

Specify the amount of memory you will need, asking for large numbers will generally result in longer wait time.
```bash
#SBATCH --mem=8G  # max 32G for cedar, 64G for graham
```

If you need a GPU: 
```bash
#SBATCH --gres=gpu:1
```

### How to submit a job

You have to prepare a submission bash script with all the parameters and the modules and then run it with:

```bash
# Run on remote server
sbatch example_submission.sh
```

### How to check on my jobs

With the following command:
```bash
# Run on remote server
squeue -u username
```

### How to cancel a job

To delete a job you will have to know its ID, which can be obtained by checking your currently running jobs.

```bash
# Run on remote server
scancel <jobid>
```

example:
```bash
# Run on remote server
scancel 7935435
```

You can also cancel all jobs you have launched:
```bash
# Run on remote server
scancel -u username
```

### Other usefull commands

To check the list of available modules:
```bash
# Run on remote server
module available
```

To check currently loaded modules.
```bash
# Run on remote server
module list
```

### Information about storage

Most of the time only $HOME storage will be enough, but in some cases you might want to load very large files, $SCRATCH is the storage to use.

[computecanada doc]: https://docs.computecanada.ca/wiki/
