# FoRTE-Research's AFL
This repository contains several modified versions of AFL components which we utilize in our experiments.

**DISCLAIMER:** This software is strictly a research prototype.

## Table of contents:
* [Installation](#installation)
* [afl-fuzz-saveinputs](#afl-fuzz-saveinputs)
* [testtrace](#testtrace)
* [FoRTE-afl-cc](#forte-afl-cc)

#### Installation
AFL:
```
git clone https://github.com/FoRTE-Research/afl
cd afl
make all
```
AFL's QEMU:
```
sudo apt-get install libtool-bin libglib2.0-dev automake flex bison
cd afl/qemu_mode
sudo ./build_qemu_support.sh
chmod +x ../afl-qemu-trace
```
Note that the build may finish with an error even though `afl-qemu-trace` was built correctly.  Read a few build status message back in the log to determine if the build was successful.



## afl-fuzz-saveinputs
afl-fuzz-saveinputs is a modified version of afl-fuzz for dumping generated inputs to file.

Syntax:
```
afl-fuzz-saveinputs -i [/path/to/seed_dir] -o [/path/to/out_dir] -e [time budget (# minutes)] [optional_args] -Q -- [/path/to/target] [target_args]
```
Input dump and sizes will be stored in `out_dir/_INPUT_DUMP` and `out_dir/_INPUT_SIZES`, respectively.  
 * **Note:** QEMU mode is recommended, otherwise dumps may be explosively large in size (depending on fuzzing speed).



## testtrace
testtrace is another afl-fuzz modification for logging each fuzzed input's tracing time. Given an input dump and corresponding sizes file produced by afl-fuzz-saveinputs, `testtrace` recreates each input and logs its execution (function `run_target()`) time. 

Syntax:`
```
testrace -i [/path/to/input/data/dump] -s [/path/to/input/sizes/dump] -o [/path/to/outdir] -f [/path/to/outfile] -c [max execs | skip for full dump] -t [exec timeout | skip for default (100ms)] -- [/path/to/target] [target_args]
```
 * **Note:** only non-position-independent target binaries are supported. Compile all target binaries with the `-no-pie` compiler flag.


## FoRTE-afl-cc
We extend afl-cc's assembly-time with a forkserver-only instrumentation mode for use in fuzzing performance experiments. 

To invoke this mode, simply append `-Wa,-F` to your afl-cc compiler flags and compile as usual.

Example:
```
./configure --disable-shared CC=afl-clang CXX=afl-clang++ CFLAGS="-g -O2 -no-pie -Wa,F" CXXFLAGS="-g -O2 -no-pie -Wa,-F"
make all
```
