#!/bin/bash

for i in `seq 1 240`
do
#    qsub -l nodes=1:ppn=2 -l walltime=200:00:00 fuzzConDyninst.pbs
#    qsub -l nodes=1:ppn=2 -l walltime=200:00:00 fuzzConQemu.pbs
#    qsub -l nodes=1:ppn=2 -l walltime=200:00:00 fuzzConWB.pbs
    qsub -l nodes=1:ppn=2 -l walltime=200:00:00 fuzzConBaseline.pbs
done
