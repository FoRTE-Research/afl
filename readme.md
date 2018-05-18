# FoRTE-Research's AFL

This repository contains several modified versions of AFL.

## Getting Started

### 1. Download and install AFL
```
git clone https://github.com/FoRTE-Research/afl
cd afl
make all
```


### 2. Install QEMU:

```
sudo apt-get install libtool-bin libglib2.0-dev automake bison
cd afl/qemu_mode
sudo ./build_qemu_support.sh
chmod +x ../afl-qemu-trace
``
Note that the build may finish with an error even though `afl-qemu-trace` was built correctly.  Read a few build status message back in the log to determine if the build was successful.



### 2. Install Dyninst
See here: https://github.com/FoRTE-Research/UnTracer-Fuzzing#1-installing-dyninst



### 3. Download AFL-Dyninst and UnTracer
```
git clone https://github.com/FoRTE-Research/afl-dyninst
git clone https://github.com/FoRTE-Research/untracer
```



### 4. Configure environment variables
```
git clone https://github.com/FoRTE-Research/setup_envs
cd setup_envs
```

Edit setup.sh:
```
export DYNINST_INSTALL 	=[/path/to/dyninst/install/dir]

export AFL_DIR 			=[/path/to/afl/dir]
export AFLDYNINST_DIR	=[/path/to/afl-dyninst/dir
export UNTRACER_DIR		=[/path/to/untracer/dir]

export LD_LIBRARY_PATH=$DYNINST_INSTALL/lib:$AFLDYNINST_DIR:$UNTRACER_DIR

export DYNINSTAPI_RT_LIB=$DYNINST_INSTALL/lib/libdyninstAPI_RT.so

```

Run setup.sh:
```
. ./setup.sh
```



### 5. Install AFL-Dyninst and UnTracer

Update `DYN_ROOT` in `afl-dyninst/Makefile` to Dyninst's install directory. Then, install AFL-Dyninst
```
make clean && make all
```
Likewise, update `DYN_ROOT` in `untracer/Makefile` to Dyninst's install directory. Then, install UnTracer:

make clean && make all
```



## TestTrace
Given input data and sizes dumps, `testtrace` will set up the AFL forkserver and shared memory bitmap, and record the trace time for each input found in the provided dump.

First, launch the setup_envs script corresponding to the desired target. e.g.:
```
. setup_envs/setup_djpeg.sh
```



### Forkserver-only (baseline) tracing mode
Instrument the target binary using UnTracerInst's Dyninst-based forkserver-only mode:
```
UnTracerInst -i [path/to/target] -o [path/to/instrumented/target] -f -v
```

Run as follows:
```
testrace -i [/path/to/input/data/dump] -s [/path/to/input/sizes/dump] -o [/path/to/outdir] -f [/path/to/outfile] -c [max_execs] -- [/path/to/instrumented/target] [target_args]
```



### AFL-GCC tracing mode
Recompile the target binary using AFL-GCC instrumentation:
```
cd /path/to/target/source
./configure CC="afl-gcc" CXX="afl-g++" --disable-shared
make clean
make install
```

Run as follows:
```
testrace -i [/path/to/input/data/dump] -s [/path/to/input/sizes/dump] -o [/path/to/outdir] -f [/path/to/outfile] -c [max_execs] -- [/path/to/instrumented/target] [target_args]
```



### AFL-Dyninst mode
Instrument the target binary using AFL-Dyninst:
```
afl-dyninst -i [/path/to/target] -o [/path/to/instrumented/target] -v
```

Run as follows:
```
testrace -i [/path/to/input/data/dump] -s [/path/to/input/sizes/dump] -o [/path/to/outdir] -f [/path/to/outfile] -c [max_execs] -- [/path/to/instrumented/target] [target_args]
```



### AFL-QEMU tracing mode

Skip instrumentation and run with the additional `-Q` directive as follows:
```
testrace -i [/path/to/input/data/dump] -s [/path/to/input/sizes/dump] -o [/path/to/outdir] -f [/path/to/outfile] -c [max_execs] -Q -- [/path/to/target] [target_args]
```



### Example usage:
```
testtrace -i _ins-dump -s _ins-sizes -f djpeg_out.txt -o djpeg_out -c 50000 -- ./djpeg @@
```