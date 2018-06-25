#!/bin/bash

cat bsdtar.sh > benchmark.sh
cat bsdtar.sh > ../../UnTracer/benchmark.sh

home=`pwd`

for trial in `seq 1 11`
do
    export PBS_JOBID=$trial
    
    for day in `seq 1 5`
    do
	export FSF_DAY=$day
	export FSF_INPUTS_PATH=/media/sf_hugeData/day${FSF_DAY}

	sh fuzzConBaseline.pbs
	#    sh fuzzConDyninst.pbs
	sh fuzzConWB.pbs
	sh fuzzConQemu.pbs
	#    cd ../../UnTracer
	#    sh fuzzConUntracer.pbs
	#    cd $home
    done
done
