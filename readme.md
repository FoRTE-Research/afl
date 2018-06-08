# FoRTE-Research's AFL

This repository contains several modified versions of AFL.

## Getting Started

### 1. Download and install AFL
```
git clone https://github.com/FoRTE-Research/afl
cd afl
make all
```


### 2. Install QEMU

```
sudo apt-get install libtool-bin libglib2.0-dev automake flex bison
cd afl/qemu_mode
sudo ./build_qemu_support.sh
chmod +x ../afl-qemu-trace
```
Note that the build may finish with an error even though `afl-qemu-trace` was built correctly.  Read a few build status message back in the log to determine if the build was successful.



### 3. Install Dyninst
See here: https://github.com/FoRTE-Research/UnTracer-Fuzzing#1-installing-dyninst



### 4. Download AFL-Dyninst and UnTracer
```
git clone https://github.com/FoRTE-Research/afl-dyninst
git clone https://github.com/FoRTE-Research/untracer
```



### 5. Configure environment variables
```
git clone https://github.com/FoRTE-Research/setup_envs
cd setup_envs
```

Edit setup.sh:
```
export DYNINST_INSTALL =[/path/to/dyninst/install/dir]
export AFL_DIR =[/path/to/afl/dir]
export AFLDYNINST_DIR =[/path/to/afl-dyninst/dir
export UNTRACER_DIR =[/path/to/untracer/dir]
```

Run setup.sh:
```
. ./setup.sh
```



### 6. Install AFL-Dyninst and UnTracer

Update `DYN_ROOT` in `afl-dyninst/Makefile` to Dyninst's install directory. Then, install AFL-Dyninst
```
make clean && make all
```
Likewise, update `DYN_ROOT` in `untracer/Makefile` to Dyninst's install directory. Then, install UnTracer:
```
make clean && make all
```


## AFL-Fuzz-SaveInputs
Syntax:
```
afl-fuzz-saveinputs -i [/path/to/seeddir] -o [/path/to/outdir] -e [time budget (# minutes)] [optional_args] -Q -- [/path/to/target] [target_args]
```
Input dump and sizes will be stored in `out_dir/_INPUT_DUMP` and `out_dir/_INPUT_SIZES`, respectively.

Note that QEMU mode is recommended (otherwise dumps will be explosively large in size).


## TestTrace
Given input data and sizes dumps, `testtrace` will set up the AFL forkserver and shared memory bitmap, and record the trace time for each input found in the provided dump.

Only non-position-independent target binaries are supported. Be sure to compile all target binaries with the `-no-pie` compiler flag.

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
testrace -i [/path/to/input/data/dump] -s [/path/to/input/sizes/dump] -o [/path/to/outdir] -f [/path/to/outfile] -c [max_execs | "F" for full dump] -- [/path/to/instrumented/target] [target_args]
```



### AFL-GCC tracing mode
Recompile the target binary using AFL-GCC instrumentation:
```
cd /path/to/target/source
./configure CC="afl-gcc" CXX="afl-g++" --disable-shared
# edit Makefile to add '-no-pie' to CFLAGS
make clean
make
```

Run as follows:
```
testrace -i [/path/to/input/data/dump] -s [/path/to/input/sizes/dump] -o [/path/to/outdir] -f [/path/to/outfile] -c [max_execs | "F" for full dump] -- [/path/to/instrumented/target] [target_args]
```



### AFL-Dyninst mode
Instrument the target binary using AFL-Dyninst:
```
afl-dyninst -i [/path/to/target] -o [/path/to/instrumented/target] -v
```

Run as follows:
```
testrace -i [/path/to/input/data/dump] -s [/path/to/input/sizes/dump] -o [/path/to/outdir] -f [/path/to/outfile] -c [max_execs | "F" for full dump] -- [/path/to/instrumented/target] [target_args]
```



### AFL-QEMU tracing mode

Skip instrumentation and run with the additional `-Q` directive as follows:
```
testrace -i [/path/to/input/data/dump] -s [/path/to/input/sizes/dump] -o [/path/to/outdir] -f [/path/to/outfile] -c [max_execs | "F" for full dump] -Q -- [/path/to/target] [target_args]
```



### Example usage:
```
testtrace -i _ins-dump -s _ins-sizes -f djpeg_out.txt -o djpeg_out -c 50000 -- ./djpeg @@
testtrace -i _ins-dump -s _ins-sizes -f djpeg_out.txt -o djpeg_out -c F -- ./djpeg @@
```
