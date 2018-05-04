echo end time is `date`

rm -rf /tmp/outDIR_$PBS_JOBID
mv /tmp/res_*_$PBS_JOBID.txt .
