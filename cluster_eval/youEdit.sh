export FSF_NUM_INPUTS=F
export FSF_EVAL_DIR=/home/mdhicks2/fuzzing/afl/cluster_eval
export FSF_AFL_DYNINST=/home/mdhicks2/fuzzing/afl-dyninst
export FSF_BASELINE_DYNINST=/home/mdhicks2/fuzzing/UnTracer
export FSF_DYNINST_INSTALL=/home/mdhicks2/dynInstall
export FSF_DUMP=/home/mdhicks2/fuzzing/_ins-dump_50000ish
export FSF_SIZES=/home/mdhicks2/fuzzing/_ins-sizes_50000ish
export LD_LIBRARY_PATH=$FSF_DYNINST_INSTALL/lib:$FSF_BASELINE_DYNINST:$FSF_AFL_DYNINST
export DYNINSTAPI_RT_LIB=$FSF_DYNINST_INSTALL/lib/libdyninstAPI_RT.so

echo PBS default server is $PBS_DEFAULT

cd $FSF_EVAL_DIR

echo Running on host `hostname`
echo Start time is `date`
echo Current directory is `pwd`

export AFL_SKIP_BIN_CHECK=1

