#!/bin/bash 
set -e 

for x in *.nf; do 
  (
        printf "\n\n== Testing > $(basename $x) ==\n\n"  
        nextflow run $x 
  )
done