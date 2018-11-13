#!/bin/bash
#PBS -A kif-392-aa
#PBS -l walltime=12:00:00
#PBS -l nodes=1:ppn=12
#PBS -q soumet
#PBS -N example_script

module load python/3.5.1

/home/username/path/to/python /home/username/path/to/script.py
