# FoRTE-Research's AFL
This repository contains several modified versions of AFL for input collection, trace speed evaluation, and instrumentation.  
**NOTE:** This software is strictly a research prototype. 

## Table of contents:
* [Getting Started](#getting-started)
  * [1. Download and install AFL and AFL's QEMU](#1-download-and-install-afl-and-afls-qemu)
  * [2. Download and install Dyninst, AFL-Dyninst, and UnTracer](#2-download-and-install-dyninst-afl-dyninst-and-untracer)
  * [3. Configure environment variables](#3-configure-environment-variables)
* [afl-fuzz-saveinputs - modified afl-fuzz for input saving](#afl-fuzz-saveinputs---modified-afl-fuzz-for-input-saving)
* [testtrace - modified afl-fuzz for trace time evaluation](#testtrace---modified-afl-fuzz-for-trace-time-evaluation)
  * [Supported tracing schemes:](#supported-tracing-schemes)
    * [afl-gcc/g++/clang/clang++ - compiler-instrumented white-box](#afl-gccgclangclang-compiler-instrumented-white-box)
    * [afl-gcc/g++/clang/clang++ - compiler-instrumented white-box baseline (forkserver-only)](#afl-gccgclangclang-compiler-instrumented-white-box-baseline-forkserver-only)
    * [afl-dyninst - static-instrumented black-box](#afl-dyninst-static-instrumented-black-box)
    * [UnTracerInst+Dyninst - static-instrumented black-box baseline (forkserver-only)](#untracerinstdyninst-static-instrumented-black-box-baseline-forkserver-only)
    * [QEMU - dynamic-instrumented black-box](#qemu-dynamic-instrumented-black-box)

## Getting Started

#### 1. Download and install AFL and AFL's QEMU
AFL:
```
git clone https://github.com/FoRTE-Research/afl
cd afl
make all
```
QEMU:
```
sudo apt-get install libtool-bin libglib2.0-dev automake flex bison
cd afl/qemu_mode
sudo ./build_qemu_support.sh
chmod +x ../afl-qemu-trace
```
Note that the build may finish with an error even though `afl-qemu-trace` was built correctly.  Read a few build status message back in the log to determine if the build was successful.

#### 2. Download and install Dyninst, AFL-Dyninst, and UnTracer
* Dyninst: https://github.com/FoRTE-Research/UnTracer-Fuzzing#1-installing-dyninst
* AFL-Dyninst: https://github.com/FoRTE-Research/afl-dyninst
* UnTracer: https://github.com/FoRTE-Research/untracer

#### 3. Configure environment variables
```
export AFL_PATH=
export DYNINST_INSTALL=
export AFLDYNINST_PATH=
export UNTRACER_PATH=
export LD_LIBRARY_PATH=$DYNINST_INSTALL/lib:$AFLDYNINST_PATH:$UNTRACER_PATH
export DYNINSTAPI_RT_LIB=$DYNINST_INSTALL/lib/libdyninstAPI_RT.so
export PATH=$PATH:$AFL_PATH:$AFLDYNINST_PATH:$UNTRACER_PATH
export AFL_SKIP_CPUFREQ=1
export AFL_SKIP_BIN_CHECK=1
export AFL_DONT_OPTIMIZE=1
```


## afl-fuzz-saveinputs - modified afl-fuzz for input saving
Syntax:
```
afl-fuzz-saveinputs -i [/path/to/seed_dir] -o [/path/to/out_dir] -e [time budget (# minutes)] [optional_args] -Q -- [/path/to/target] [target_args]
```
Input dump and sizes will be stored in `out_dir/_INPUT_DUMP` and `out_dir/_INPUT_SIZES`, respectively.  
**Note:** QEMU mode is recommended, otherwise dumps may be explosively large in size.

## testtrace - modified afl-fuzz for trace time evaluation
Syntax:
```
testrace -i [/path/to/input/data/dump] -s [/path/to/input/sizes/dump] -o [/path/to/outdir] -f [/path/to/outfile] -c [max execs | skip for full dump] -t [exec timeout | skip for default (100ms)] -- [/path/to/target] [target_args]
```
**Note:** only non-position-independent target binaries are supported. Compile all target binaries with the `-no-pie` compiler flag.

### Supported tracing schemes:

#### [afl-gcc/g++/clang/clang++] compiler-instrumented white-box
Compile target using any of the aforementioned afl compilers:
```
$ CC=/path/to/afl/afl-gcc ./configure --disable-shared
$ make clean all
```

#### [afl-gcc/g++/clang/clang++] compiler-instrumented white-box baseline (forkserver-only)
Compile target using any of the aforementioned afl compilers, but with additional compiler flag `-Wa,-F`.  
**Note:** assigning CFLAG's via commandline will override any default values. You must instead modify the target's `Makefile` to append `-Wa,-F` before compiling.

#### [afl-dyninst] static-instrumented black-box
Instrument target using `afl-dyninst`:
```
afl-dyninst -i [path/to/target] -o [path/to/instrumented/target] -v
```

#### [UnTracerInst+Dyninst] static-instrumented black-box baseline (forkserver-only)
Instrument target using `UnTracerInst`:
```
UnTracerInst -i [path/to/target] -o [path/to/instrumented/target] -f -v
```

#### [QEMU] dynamic-instrumented black-box
This mode requires no instrumentation. Simply run `testtrace` with the additional `-Q` parameter:
```
testrace [args] -Q -- [/path/to/instrumented/target] [target_args]
```
