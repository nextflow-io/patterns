#!/bin/bash 
set -e 

for x in $(find . -maxdepth 1 -type d); do 
  (
      cd $x
      if [[ -f Makefile ]]; then
        printf "\n\n== Testing > $(basename $x) ==\n\n" 
        make test
      elif [[ -f main.nf ]]; then
        printf "\n\n== Testing > $(basename $x) ==\n\n"  
        nextflow run main.nf 
      fi 
  )
done