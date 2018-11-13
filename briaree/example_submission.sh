#!/bin/bash
#PBS -A kif-392-aa
#PBS -l walltime=12:00:00
#PBS -l nodes=1:ppn=12
#PBS -q courte
#PBS -N example_script

module load foss/2015b
module load Python/3.5.2

/home/username/path/to/python /home/username/path/to/script.py
