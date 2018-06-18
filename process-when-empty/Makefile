SHELL=/bin/bash
all:
	nextflow run . 

test:
	nextflow run main.nf > stdout 
	[[ `< stdout grep -c 'Submitted process'` == 1 ]] || false 
	nextflow run main.nf --inputs prots/\* > stdout
	[[ `< stdout grep -c 'Submitted process'` == 0 ]] || false 

clean:
	rm -rf .nextflow* work stdout
