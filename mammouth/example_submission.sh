#!/bin/bash
#SBATCH --account=def-kjerbi
#SBATCH --time=12:00:00
#SBATCH --job-name=example
#SBATCH --mem=31G

module load python/3.7.0

$HOME/python_env/bin/python $HOME/example.py
