SHELL=/bin/bash
test:
	nextflow run . > stdout
	[[ `< stdout grep -c 'Submitted process'` == 5 ]] || false
	[[ `ls -la my-results/110101_I315_FC816RLABXX_L1_HUMrutRGXDIAAPE/*.fq | grep -c ''` == 2 ]] || false 
	[[ `ls -la my-results/110101_I315_FC816RLABXX_L1_HUMrutRGXDIAAPE/counts/*.txt | grep -c ''` == 2 ]] || false 
	[[ `ls -la my-results/110101_I315_FC816RLABXX_L1_HUMrutRGXDIAAPE/outlooks/*.txt | grep -c ''` == 2 ]] || false 	
