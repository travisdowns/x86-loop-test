#!/bin/bash
#
# runs all the tests, from 3 to 200 uops and saves the output to csv files
#

./run.sh 3 200 short_nop_aligned -x, 2>&1 | tee short_nop_aligned.csv
./run.sh 3 200 short_nop_misaligned -x, 2>&1 | tee short_nop_misaligned.csv
./run.sh 3 200 long_nop_aligned -x, 2>&1 | tee long_nop_aligned.csv
./run.sh 3 200 long_nop_mis30 -x, 2>&1 | tee long_nop_mis30.csv
./run.sh 3 200 long_nop_mis2 -x, 2>&1 | tee long_nop_mis2.csv

