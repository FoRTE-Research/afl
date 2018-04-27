# FoRTE-Research's AFL

This repository contains several modified versions of AFL.

## Getting Started

### 1. Installation
```
git clone https://github.com/FoRTE-Research/afl
cd afl
make all
```

Add `/path/to/afl` to your system's `PATH` variable. 

### 2. Installing Dyninst
See here: https://github.com/FoRTE-Research/UnTracer-Fuzzing#1-installing-dyninst

### 3. Installing AFL-Dyninst

```
git clone https://github.com/FoRTE-Research/afl-dyninst
cd afl-dyninst
```

Update `DYN_ROOT` in `Makefile` to where you installed Dyninst.

```
make all
```

Add `/path/to/afl-dyninst` to your system's `PATH` variable.


### 4. Configuring AFL-Dyninst Environment Variables
```
export AFL_SKIP_BIN_CHECK=1
export LD_LIBRARY_PATH=/path/to/dyninst_install/lib:/path/to/afl-dyninst
export DYNINSTAPI_RT_LIB=/path/to/dyninst_install/lib/libdyninstAPI_RT.so
```

## TestTrace
Given input data and sizes dumps, `testtrace` will set up the AFL forkserver and shared memory bitmap, and record the trace time for each input found in the provided dump.

### Dyninst Mode
First, verify that you have configured the environment variables described above.

Next, instrument the target binary:
```
afl-dyninst -i [path/to/target] -o [path/to/dyninst/instrumented/target] -v
```

Then, run as follows:
```
testtrace -i [path/to/input/data/dump] -s [path/to/input/sizes/dump] -f [outfile] -o [afl/out/directory/] -- [path/to/dyninst/instrumented/target] [args]
```
NOTE: you made need to disable AFL's check for CPU frequency scaling

```
export AFL_SKIP_CPUFREQ=1
```

### QEMU Mode
First, make sure you've installed QEMU and AFL's QEMU patches:
```
sudo apt-get install libtool-bin libglib2.0-dev
cd qemu_mode
sudo ./build_qemu_support.sh
```

To run AFL with QEMU tracing, just skip pre-instrumenting the target and run with the `-Q` argument:
```
testtrace -i [path/to/input/data/dump] -s [path/to/input/sizes/dump] -f [outfile] -o [afl/out/directory/] -Q -- [path/to/target] [args]
```

### Example usage:
```
testtrace -i _ins-dump -s _ins-sizes -f djpeg_out.txt -o djpeg_afl_out -- ./djpeg @@
```



