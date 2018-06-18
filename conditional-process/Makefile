SHELL=/bin/bash

test:
	nextflow -q run main.nf > stdout
	[[ `< stdout grep -c foo` == 1 ]] || false
	nextflow -q run main.nf --flag > stdout 
	[[ `< stdout grep -c bar` == 1 ]] || false

	nextflow -q run main2.nf > stdout
	[[ `< stdout awk '{sum+=$$1} END {print sum}'` == 15 ]] || false
	nextflow -q run main2.nf --flag > stdout
	[[ `< stdout awk '{sum+=$$1} END {print sum}'` == 6 ]] || false