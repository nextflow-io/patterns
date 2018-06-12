SHELL=/bin/bash
all:
	nextflow run . 

test:
	nextflow run . > stdout 
	[[ `< stdout grep -c 'Submitted process'` == 3 ]] || false 
	nextflow run . --filter foo.txt > stdout
	[[ `< stdout grep -c 'filter'` == 3 ]] || false 

clean:
	rm -rf .nextflow* work stdout
