test:
	nextflow -q run . > stdout
	[[ `< stdout grep -c foo` == 1 ]] || false
	nextflow -q run . --flag > stdout 
	[[ `< stdout grep -c bar` == 1 ]] || false