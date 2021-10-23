#! /bin/bash
#SBATCH --account=def-kjerbi
#SBATCH --cpus-per-task=6
#SBATCH --gres=gpu:1
#SBATCH --mem=8G
#SBATCH --time=0-02:00
#SBATCH --job-name=example
#SBATCH --output=%j-example.out

module load python/3.7.0

cd /home/username/project/username
env/bin/python -u script.py


