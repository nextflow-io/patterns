# Optional input 

## Problem 

One or more processes have an optional input file. 

## Solution 

Use a mock file name to simulate the absence of the file parameter. 

## Run it 

Run the script with the following command: 

    nextflow run main.nf 

Run the same script providing an optional file input:

    nextflow run main.nf --filter foo.txt




