Before running the evaluation scripts in this folder, you need to build the required target binaries:
  QEMU: Completely uninstrumented binary
  AFL-gcc: Binary with forkserver and basic block callbacks baked-in at compile time
  Baseline: Binary instrumented with init forkserver
  AFL-Dyninst: Binary instrumented with init forkserver and basic block callbacks
 
Download and build the uninstrumented target binary:
  wget http://www.ijg.org/files/jpegsrc.v9a.tar.gz
  tar -xzf jpegsrc.v9a.tar.gz
  rm jpegsrc.v9a.tar.gz
  cd jpeg-9a
  ./configure --disable-shared
  make
  cp djpeg /path/to/afl/cluster_eval/.
  
Download and build AFL: https://github.com/FoRTE-Research/afl
  export PATH=$PATH:/path/to/afl

Create the AFL-gcc instrumented binary:
  cd /path/to/jpeg-9a
  ./configure CC="afl-gcc" CXX="afl-g++" --disable-shared
  make
  cp djpeg /path/to/afl/cluster_eval/djpegWB
  
Download and build Dyninst: https://github.com/FoRTE-Research/UnTracer-Fuzzing

Download and build the init-only forkserver instrumentor: https://github.com/FoRTE-Research/forkserver-baseline
  update `DYN_ROOT` in `Makefile` to the path where you built Dyninst
  export LD_LIBRARY_PATH=/path/to/dyninst_install/lib
  export DYNINSTAPI_RT_LIB=/path/to/dyninst_install/lib/libdyninstAPI_RT.so
  cp /path/to/afl/cluster_eval/djpeg .
  make
  cp djpegInst /path/to/afl/cluster_eval/djpegBaseline

Download, build, and instrument with AFL-Dyninst: https://github.com/FoRTE-Research/afl-dyninst
  update `DYN_ROOT` in `Makefile` to the path where you built Dyninst
  export LD_LIBRARY_PATH=/path/to/dyninst_install/lib
  export DYNINSTAPI_RT_LIB=/path/to/dyninst_install/lib/libdyninstAPI_RT.so
  cp /path/to/afl/cluster_eval/djpeg .
  make
  cp djpegInst /path/to/afl/cluster_eval/djpegInst
  
