SHELL=/bin/bash

test:
	nextflow -q run . > stdout
	[[ `< stdout grep -c 6` == 1 ]] || false
	nextflow -q run . --flag > stdout 
	[[ `< stdout grep -c 3` == 1 ]] || false
