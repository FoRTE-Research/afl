export PBS_JOBID=1

home=`pwd`

cat bsdtar.sh > benchmark.sh
cat bsdtar.sh > ../../UnTracer/benchmark.sh
sh fuzzConBaseline.pbs
sh fuzzConDyninst.pbs
sh fuzzConWB.pbs
sh fuzzConQemu.pbs
cd ../../UnTracer
sh fuzzConUntracer.pbs
cd $home

cat cert-basic.sh > benchmark.sh
cat cert-basic.sh > ../../UnTracer/benchmark.sh
sh fuzzConBaseline.pbs
sh fuzzConDyninst.pbs
sh fuzzConWB.pbs
sh fuzzConQemu.pbs
cd ../../UnTracer
sh fuzzConUntracer.pbs
cd $home

cat cjson.sh > benchmark.sh
cat cjson.sh > ../../UnTracer/benchmark.sh
sh fuzzConBaseline.pbs
sh fuzzConDyninst.pbs
sh fuzzConWB.pbs
sh fuzzConQemu.pbs
cd ../../UnTracer
sh fuzzConUntracer.pbs
cd $home

cat djpeg.sh > benchmark.sh
cat djpeg.sh > ../../UnTracer/benchmark.sh
sh fuzzConBaseline.pbs
sh fuzzConDyninst.pbs
sh fuzzConWB.pbs
sh fuzzConQemu.pbs
cd ../../UnTracer
sh fuzzConUntracer.pbs
cd $home

cat pdftohtml.sh > benchmark.sh
cat pdftohtml.sh > ../../UnTracer/benchmark.sh
sh fuzzConBaseline.pbs
sh fuzzConDyninst.pbs
sh fuzzConWB.pbs
sh fuzzConQemu.pbs
cd ../../UnTracer
sh fuzzConUntracer.pbs
cd $home

cat readelf.sh > benchmark.sh
cat readelf.sh > ../../UnTracer/benchmark.sh
sh fuzzConBaseline.pbs
sh fuzzConDyninst.pbs
sh fuzzConWB.pbs
sh fuzzConQemu.pbs
cd ../../UnTracer
sh fuzzConUntracer.pbs
cd $home

cat sfconvert.sh > benchmark.sh
cat sfconvert.sh > ../../UnTracer/benchmark.sh
sh fuzzConBaseline.pbs
sh fuzzConDyninst.pbs
sh fuzzConWB.pbs
sh fuzzConQemu.pbs
cd ../../UnTracer
sh fuzzConUntracer.pbs
cd $home

cat tcpdump.sh > benchmark.sh
cat tcpdump.sh > ../../UnTracer/benchmark.sh
sh fuzzConBaseline.pbs
sh fuzzConDyninst.pbs
sh fuzzConWB.pbs
sh fuzzConQemu.pbs
cd ../../UnTracer
sh fuzzConUntracer.pbs
cd $home
