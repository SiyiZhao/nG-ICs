#!/bin/bash
#PBS -N 2lpt-1Gpc
#PBS -V
#PBS -lselect=1:ncpus=96:mpiprocs=96:mem=600gb
#PBS -j oe
#PBS -o LOG/1Gpc.log
export OMP_NUM_THREADS=1

echo -e "\n\n======$PBS_JOBID - start `date`======\n"

module load gnu9
module load mpich 
cd $PBS_O_WORKDIR

export LD_LIBRARY_PATH=/opt/ohpc/pub/libs/gnu9/gsl/2.7/lib/:$LD_LIBRARY_PATH

param_path="2lpt_1Gpc.param"

outputDir=$(awk '/OutputDir/{print $2}' "$param_path")
mkdir -p "$outputDir"

mpirun -n 96 ../2LPT_PNG/2LPTnonlocal "$param_path" 

echo -e "\n\n======finish $PBS_JOBID -  `date`======\n"
