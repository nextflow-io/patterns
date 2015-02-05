# Nextflow examples

This repository contains a collection of scripts introducing Nextflow basic features. 


## Dependencies 

* Unix-like operating system (Linux, Solaris, OS X, etc)
* Java 7 or 8 


## Get started

Install Nextflow by copying and pasting the following snippet in your shell terminal: 

    curl -fsSL get.nextflow.io | bash

It will download the `nextflow` application launcher in your working directory. 
 

## Content 

#### 1. Hello world!  

The classic Hello world! example. You can run it entering the following command: 

    nextflow run examples/helloworld.nf 


#### 2. Basic file operations

Shows basic file read and write operations. 

Run the example using entering the following command: 

	nextflow run examples/basic_read_write.nf
 
 
#### 3. Environment variables

This example shows how environment variables can be accessed directly in the script context.

Run the example using entering the following command: 

	nextflow run examples/env_vars.nf
  
 
#### 4. Read FASTA files   
 
Basic example showing how to read a multi FASTA file 10 sequences at time.
 
Run the example using entering the following command: 

	nextflow run examples/read_fasta.nf
	
 
#### 5. Parse FASTA file into records

This example shows how parse a multi fasta file into records and access sequence attributes
by using the `splitFasta` operator.

Run the example using entering the following command: 

	nextflow run examples/fasta_record.nf
	
	
Read more about [splitFasta](http://www.nextflow.io/docs/latest/operator.html#splitfasta) operator. 	


#### 6. Execute an external process (*)       

This example executes a BLAST search given an input protein sequence file.

Run the example using entering the following command: 

	nextflow run examples/process_input.nf	
	

#### 7. Execute a process and capture output (*)

This example executes a BLAST search and it shows how capture and print the result output.

Run the example using entering the following command: 

	nextflow run examples/process_output.nf	
	
Run the same example providing your own proteins query file adding the
`--query` command line option. For example:

	nextflow run examples/process_output.nf	--query <your fasta query file>
 	
	

#### 8. Parallel process execution (*)

This example shows how splits a multi FASTA file in chunks and execute a BLAST query 
for each of them in parallel.  

Run the example using entering the following command: 

	nextflow run examples/split_fasta.nf	

By default the script split the multi FASTA file in chunks containing 10 sequences. 
Try to execute the same example specifying a lower number of sequences in each chunk.
For example: 

	nextflow run examples/split_fasta.nf --chunkSize 5	


#### 9. Gather output files (*)

Shows how splits a multi FASTA file, execute a BLAST query for ach chunk and create a result file

Run the example using entering the following command: 

	nextflow run examples/split_and_collect.nf

#### 10. Parallel execution with multiple inputs

Shows how to process multiple input files

Run the example using entering the following command: 

	nextflow run examples/multiple_inputs.nf 

#### 11. Tuple of values 

Shows how handle tuple of values over the same channel  


Run the example using entering the following command: 

	nextflow run examples/set_in_out.nf 

#### 12. Using operators

An example showing the `map` operator


Run the example using entering the following command: 

	nextflow run examples/basic_map.nf 


#### 13. Filter operator

Example showing the `filter` operator 

Run the example using entering the following command: 

	nextflow run examples/filter_operator.nf 

#### 14. FlatMap operator 

An example showing the `flatMap` operator 


Run the example using entering the following command: 

	nextflow run examples/flat_map.nf 

#### 15. Phase operator

An example showing the `phase` operator to synchronise two channels.
 
Run the example using entering the following command: 

	nextflow run examples/phase_operator.nf 
    
    
## Other examples 

More comprehensive examples are avaible in the following repositories: 

* [RNA-toy](https://github.com/nextflow-io/rnatoy) - A basic RNA-Seq pipeline
* [Piper-nf](https://github.com/cbcrg/piper-nf) - A RNA mapping pipeline 
* [MTA-nf](https://github.com/cbcrg/mta-nf) - A method for best alignment of evaluation trees
* [Ampa-nf](https://github.com/cbcrg/ampa-nf) - An automated prediction of protein antimicrobial regions
* [Grape-nf](https://github.com/cbcrg/grape-nf) - Yet another RNA-Seq pipeline
    
 
 


