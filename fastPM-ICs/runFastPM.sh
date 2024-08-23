#!/bin/bash
#PBS -N fastpm_test
#PBS -V
#PBS -lselect=1:ncpus=32:mem=256gb 
#PBS -j oe
#PBS -o test.log

echo -e "\n\n======$PBS_JOBID - start `date`======\n"

source ~/miniconda3/etc/profile.d/conda.sh
conda activate cfastpm
cd $PBS_O_WORKDIR

fastpm fastpm_test.lua 

echo -e "\n\n======finish $PBS_JOBID -  `date`======\n"
