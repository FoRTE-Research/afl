echo end time is `date`

rm -rf outDIR_$PBS_JOBID
mv res_*_$PBS_JOBID.txt /media/sf_hugeData/.
