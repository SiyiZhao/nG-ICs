#!/bin/bash
#PBS -N 2lpt
#PBS -V
#PBS -lselect=1:ncpus=4:mem=1024gb
#PBS -j oe
#PBS -o out.log


echo $(date)

module load gnu9
module load mpich 
cd $PBS_O_WORKDIR

export LD_LIBRARY_PATH=/opt/ohpc/pub/libs/gnu9/gsl/2.7/lib/:$LD_LIBRARY_PATH

mpirun -n 4 /home/siyizhao/nG-ICs/2LPT_PNG/2LPTnonlocal /home/siyizhao/nG-ICs/inputs/2lpt_nonlocal_test.param 