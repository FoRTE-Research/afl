#!/bin/bash

home=`pwd`

for day in `seq 1 5`
do
    export FSF_DAY=$day
    export FSF_INPUTS_PATH=/media/sf_bigdata/day${FSF_DAY}
    export PBS_JOBID=1

    for bench in bsdtar cert-basic cjson djpeg pdftohtml readelf sfconvert tcpdump
    do
	
	cat ${bench}.sh > benchmark.sh
	cat ${bench}.sh > ../../UnTracer/benchmark.sh

	sh fuzzConBaseline.pbs
	sh fuzzConDyninst.pbs
	sh fuzzConWB.pbs
	sh fuzzConQemu.pbs
	#cd ../../UnTracer
	#sh fuzzConUntracer.pbs
	#cd $home
    done
done
