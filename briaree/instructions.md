# Briaree cluster instructions

## General Information

The server is briaree.calculquebec.ca  
The maximum number of cores per node is 12.  
The memory per core varies from 2GB up to 8GB per core.  
Asking for more memory and more nodes will generally result in more wait time before the job is run.  

## Documentation

Documentation can be found [here][briaree doc].

### How to connect to the login nodes

Use ssh to connect to the login nodes (do *not* run code on the login nodes), use bash.
```bash
ssh username@briaree.calculquebec.ca
```
_Note: you can use puTTY on windows to access the login nodes_

### How to send data to the server

Use ssh to transfer data on the server (see information about storage to know where to put your data).
_Note: Use winSCP or firezilla or any ssh file transfer utility to transfer files from a windows machine._
```bash
scp my_file username@briaree.calculquebec.ca:/path/to/desired/folder/
```

To transfer from the server to your local machine:
```bash
scp username@briaree.calculquebec.ca:/path/to/file path/to/destination/folder/
```

examples:
```bash
scp username@briaree.calculquebec.ca:script/classif.py .
# Will transfer the file classif.py from $HOME/script to the local folder.

scp -r data/* username@briaree.calculquebec.ca:/RQusagers/username/data/ 
# Will transfer all the files in the local data folder to my remote $HOME/data folder
```

More info on the [official doc][briaree ssh]

### How to set up your python environment

First, decide which version of python you are going to use (if you don't know what version to use go for python 3.5.1, the latest version of python available on the cluster).

Load the chosen python version:
```bash
module load python/x.y.z  
```
(x, y and z corresponding to your python version eg. 3.5.1)

Create a new python environment with the command:

```bash
python3 -m venv "python_env"
```
_Note that python3 is used, because when you load python the default version is the system's python 2.6.6 version._

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

Use the default queue that will redirect your job to the correct queue according to the job duration:
```bash
#PBS -q soumet
```

Or Select the right queue according to your parameters:  

| Queue | Maximum execution time | Minimum number of nodes per job | Maximum number of nodes per job | Maximum number of cores per user | Maximum number of jobs per user | Maximum number of cores for all jobs |  
| :------------ | :-------------------: | :---: | :---: | :---: | :---: | :---: |  
| test		| 1 h			| 1	| 1	| 1416	| n/a	| n/a	|  
| courte	| 48 h			| 1	| 4	| n/a	| 72	| n/a	|  
| normale	| 168 h (7 days)	| 1	| 4	| 1416	| 36	| n/a	|  
| longue	| 336 h (14 days)	| 1	| 4	| 180	| 24	| 720	|  
| hpcourte	| 48 h			| 5	| 171	| n/a	| n/a	| n/a	|  
| hp		| 168 h (7 days)	| 5	| 171	| 2052	| 8	| n/a	|  

longue, hpcourte and hp are limited access queues (you need to contact Calul Quebec to have access)

To view available ressources, enter the command:
```bash
pbs_free :normal
```
You also specify the number of nodes to use with --nodes and --ntasks-per-node  
For exemple i want to use 24 threads for my script, I change the node parameter:
```bash
#PBS -l nodes=2:ppn=12
```

If you need a large amount of memory, add the option:
```bash
#PBS -l nodes=10:m48G:ppn=12
```
Here, 10 nodes with each 48GB memory will be reserved (a total of 480GB of memory).

More info on the options can be found [here][briaree jobs]

### How to submit a job

You have to prepare a submission bash script with all the parameters and the modules and then run it with:

```bash
qsub example_submission.sh
```

### How to check on my jobs

With the following command:
```bash
qstat -u username
```

### Other usefull commands

To check the list of available modules:
```bash
module available
```

To check currently loaded modules.
```bash
module list 
```

### Information about storage

Most of the time only HOME storage will be enough, but in some cases you might want to load very large files, SCRATCH is the storage to use. 

* Only use text format for files that are smaller than a few MB.
* As far as possible, use local storage for temporary files.
* If your program must search within a file, it is fastest to do it by reading it in completely before searching, or to use a RAM disk ($RAMDISK or /dev/shm).
* Regularly clean up parallel file systems, because those systems are used for huge data collections.
* If you no longer use certain files, compress them (you should group them before) and back them up (if possible).
* If your needs are not well served by the available storage options please contact Calcul Québec's user support team

Here is the list of available storage solutions on the server:  

* $HOME (/RQusagers/username)
>Individual space, different for each user.
Read- and write-accessible for all nodes, by the user only (by default).
Shared file system GPFS of 7.3 TB.
Data persists.
Regular backups.
* $SCRATCH (/RQexec/kikuko)
>Individual space, different for each user.
Read- and write-accessible for all nodes by the user.
Read-only access by group members.
Shared file system GPFS of 219 TB.
4 to 16 times faster than $HOME
Data persists.
No backups.
* $LSCRATCH (/tmp)
>Local storage space for each node a job uses.
Temporary directory created for the job at the job's start, erased at the end.
Local ext4 file system of 182 GB.
No backups, please copy your results elsewhere before the job ends.
* $PARALLEL_LSCRATCH
>Distributed local storage shared between the nodes associated to a given job (uses local disks).
Parallel filesystem between those nodes (FhGFS)
The space available is the sum of all $LSCRATCH of those nodes.
Available upon request. Add ENABLE_PARALLEL_LSCRATCH=1 in your submit script.
Temporary files for the duration of the job. You must copy files to your $HOME or $SCRATCH before the job is over.
* $RAMDISK
>Local storage space for each node, in memory.
Very fast.
Size smaller than one half of the node's memory.
Temporary directory created for the job at the job's start, erased at the end.
No backups, please copy your results elsewhere before the job ends.
* $PARALLEL_RAMDISK
>Distributed local storage shared between the nodes associated to a given job (uses local disks).
Parallel filesystem between those nodes (FhGFS)
The space available is the sum of all $RAMDISK of those nodes.
Available upon request. Add ENABLE_PARALLEL_RAMDISK=1 in your submit script.
Temporary files for the duration of the job. You must copy files to your $HOME or $SCRATCH before the job is over.

### Usefull Links

[Server Status][briaree status]
[Storage Information][briaree storage]

[briaree status]: http://serveurscq.computecanada.ca/services/briaree
[briaree doc]: https://wiki.calculquebec.ca/
[briaree jobs]: https://wiki.calculquebec.ca/w/Ex%C3%A9cuter_une_t%C3%A2che/en
[briaree storage]: https://wiki.calculquebec.ca/w/Utiliser_l%27espace_de_stockage/en
[briaree ssh]: https://wiki.calculquebec.ca/w/Se_connecter_et_transf%C3%A9rer_des_fichiers/en
