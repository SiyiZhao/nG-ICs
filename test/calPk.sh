#!/bin/bash
#PBS -N calPk
#PBS -lselect=1:ncpus=32:mem=256gb 
#PBS -j oe
#PBS -o LOG/testPk_1Gpc.log

echo -e "\n\n======$PBS_JOBID - start `date`======\n"

source ~/miniconda3/etc/profile.d/conda.sh
conda activate libanus
cd $PBS_O_WORKDIR

# config_path="/home/siyizhao/nG-ICs/run/powspec.conf"

# /home/siyizhao/lib/powspec-master/POWSPEC --conf "$config_path"

snapshot="/hscratch/siyizhao/ICs/L1000N512fNL0/ics_localPNG"
# snapshot="/hscratch/siyizhao/ICs/fastpm/ics/test_0.0200"
# outputpk="/hscratch/siyizhao/ICs/L1000N512fNL0/Pk"

python3 Pk.py --snapshot "$snapshot" --grid 512 --BoxSize 1000 --threads 32 --output "LOG/Pk.npz"
# python3 Pk.py --snapshot "$snapshot" --format "bigfile" --grid 512 --BoxSize 1000 --threads 32 --output "LOG/Pk_fastpm.npz"

echo -e "\n\n======finish $PBS_JOBID -  `date`======\n"
