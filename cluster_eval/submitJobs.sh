#!/bin/bash

for i in `seq 1 48`
do
    qsub -l nodes=sushi-01:ppn=1 -l walltime=200:00:00 -d `pwd` fuzzConDyninst.pbs
#    qsub -l nodes=1:ppn=12 -l walltime=200:00:00 -d `pwd` fuzzConQemu.pbs
#    qsub -l nodes=1:ppn=12 -l walltime=200:00:00 -d `pwd` fuzzConWB.pbs
    qsub -l nodes=sushi-02:ppn=1 -l walltime=200:00:00 -d `pwd` fuzzConBaseline.pbs
done
