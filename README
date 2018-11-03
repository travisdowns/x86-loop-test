Tests for loop performance, based on [this stackoverflow question](http://stackoverflow.com/questions/39311872/is-performance-reduced-when-executing-loops-whose-uop-count-is-not-a-multiple-of) about how loop performance varies with the uop count.

To build:

    make

To run:

    ./run-all.sh

This produces various *.csv files which have alternating lines of results for instruction, cycle and dsb.uop counts. I just use 
grep and xsel to copy a column out at a time and paste them into a spreadsheet:

    grep ',,cycles' short_nop_aligned.csv | xsel -b

The above will copy all the lines values for the _cycles_ metric out of the given csv file.
