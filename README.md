# Nextflow examples

This repository contains a collection of scripts introducing Nextflow basic features. 


## Dependencies 

* Unix-like operating system (Linux, Solaris, OS X, etc)
* Java 7 or 8 


## Get started

Install Nextflow by copying and pasting the following snippet in your shell terminal: 

    curl -fsSL get.nextflow.io | bash

It will download the `nextflow` application launcher in your working directory. 
You may want to complete the installation moving the `nextflow` executable into a 
directory on your `$PATH`. 

Clone this repository in folder of your choice with the following command: 

	git clone https://github.com/nextflow-io/examples.git 
 
Then, change in root directory of the repository just cloned.  


## Content 

#### 1. Hello world!  

The classic Hello world! example. You can run it entering the following command: 

    nextflow run helloworld.nf 


#### 2. Basic file operations

Shows basic file read and write operations. 

Run the example using entering the following command: 

	nextflow run basic_read_write.nf
 
 
#### 3. Environment variables

This example shows how environment variables can be accessed directly in the script context.

Run the example with this command: 

	nextflow run env_vars.nf
  
 
#### 4. Read FASTA files   
 
Basic example showing how to read a multi FASTA file 10 sequences at time.
 
Run the example with this command: 

	nextflow run read_fasta.nf
	
 
#### 5. Parse FASTA file into records

This example shows how parse a multi fasta file into records and access sequence attributes
by using the `splitFasta` operator.

Run the example with this command: 

	nextflow run fasta_record.nf
	
	
Read more about [splitFasta](http://www.nextflow.io/docs/latest/operator.html#splitfasta) operator. 	


#### 6. Execute an external process (*)       

This example executes a BLAST search given an input protein sequence file.

Run the example with this command:  

	nextflow run process_input.nf	
	

#### 7. Execute a process and capture output (*)

This example executes a BLAST search and it shows how capture and print the result output.

Run the example with this command: 

	nextflow run process_output.nf	
	
Run the same example providing your own proteins query file adding the
`--query` command line option. For example:

	nextflow run process_output.nf	--query <your fasta query file>
 	
	

#### 8. Parallel process execution (*)

This example shows how splits a multi FASTA file in chunks and execute a BLAST query 
for each of them in parallel.  

Run the example with this command:  

	nextflow run split_fasta.nf	

By default the script split the multi FASTA file in chunks containing 10 sequences. 
Try to execute the same example specifying a lower number of sequences in each chunk.
For example: 

	nextflow run split_fasta.nf --chunkSize 5	


#### 9. Gather output files (*)

Shows how splits a multi FASTA file, execute a BLAST query for ach chunk and create a result file

Run the example with this command: 

	nextflow run split_and_collect.nf
	
Read more about the [collectFile](http://www.nextflow.io/docs/latest/operator.html#collectfile) operator.	
	

#### 10. Parallel execution with multiple inputs

Shows how to process multiple input files

Run the example with this command: 

	nextflow run multiple_inputs.nf 
	
By default the script executes a BLAST job against a single query file (`data/sample.fa`). 

Try to run this example by entering the following command line: 

	nextflow run multiple_inputs.nf --query data/prot_\*.fa

It will execute a blast search for each file that matches the 
the wildcard path matcher. 
 

#### 11. Tuple of values 

Shows how handle tuple of values over the same channel  


Run the example with this command:  

	nextflow run set_in_out.nf 



#### 12. Using operators

An example showing the `map` operator

Run the example with this command:  

	nextflow run basic_map.nf 

Read more about the [map](http://www.nextflow.io/docs/latest/operator.html#map) operator.


#### 13. Filter operator

Example showing the `filter` operator 

Run the example with this command: 

	nextflow run filter_operator.nf 

Read more about the [filter](http://www.nextflow.io/docs/latest/operator.html#filter) operator.


#### 14. FlatMap operator 

An example showing the `flatMap` operator 


Run the example with this command:  

	nextflow run flat_map.nf 
	
Read more about the [flatMap](http://www.nextflow.io/docs/latest/operator.html#flatmap) operator	

#### 15. Phase operator

An example showing the `phase` operator to synchronise two channels.
 
Run the example with this command: 

	nextflow run phase_operator.nf 
    
    
Read more about the [phase](http://www.nextflow.io/docs/latest/operator.html#phase) operator.    
    
## Other examples 

More comprehensive examples are avaible in the following repositories: 

* [RNA-toy](https://github.com/nextflow-io/rnatoy) - A basic RNA-Seq pipeline
* [Piper-nf](https://github.com/cbcrg/piper-nf) - A RNA mapping pipeline 
* [MTA-nf](https://github.com/cbcrg/mta-nf) - A method for best alignment of evaluation trees
* [Ampa-nf](https://github.com/cbcrg/ampa-nf) - An automated prediction of protein antimicrobial regions
* [Grape-nf](https://github.com/cbcrg/grape-nf) - Yet another RNA-Seq pipeline
    
 
 


