# Nextflow examples

This repository contains a collection of scripts introducing Nextflow basic features. 

![CircleCI status](https://circleci.com/gh/nextflow-io/examples.png?style=shield)

## Dependencies 

* Unix-like operating system (Linux, Solaris, OS X, etc)
* Java 7 or 8 

The examples marked with `*` require also the following pieces of software:  

* [BLAST+](http://ftp.ncbi.nlm.nih.gov/blast/executables/blast+/LATEST/) 
* [T-Coffee](http://www.tcoffee.org/Packages/Stable/Latest/linux/) 

The above tools are also shipped with a Docker container 
available [at this link](https://registry.hub.docker.com/u/nextflow/examples/). 

You can choose either to install them in your computer or pull the container with this 
command: 

    docker pull nextflow/examples
    
In the latter case the examples below marked with a `*` character need to be run adding 
the `-with-docker` command line option.
    


## Get started

Install Nextflow by copying and pasting the following snippet in your shell terminal: 

    curl -fsSL get.nextflow.io | bash

It will download the `nextflow` application launcher in your working directory. 
When done, you may want to complete the installation moving the `nextflow` executable 
into a directory in your `$PATH` variable. 

Clone this repository in folder of your choice with the following command: 

	git clone https://github.com/nextflow-io/examples.git 
 
Then, change in the root directory of the repository just cloned.  


## Content 

#### 1. Hello world!  

The classic *Hello world!* example. You can run it entering the following command: 

    nextflow run helloworld.nf 



#### 2. Basic file operations

Shows basic file read and write operations. 

Run the example entering the following command: 

	nextflow run basic_read_write.nf

 
 
#### 3. Environment variables

This example shows how environment variables can be accessed directly in the script context.

Run the example with this command: 

	nextflow run env_vars.nf
  
  
 
#### 4. Read FASTA files   
 
Basic example showing how to read a multi FASTA file, splitting it 
into chunks containing 10 sequences.
 
Run the example with this command: 

	nextflow run read_fasta.nf
	

Read more about [splitFasta](http://www.nextflow.io/docs/latest/operator.html#splitfasta) operator. 	
	
 
#### 5. Parse FASTA file into records

This example shows how parse a multi fasta file into records and access each sequence properties
by using the `splitFasta` operator.

Run the example with this command: 

	nextflow run fasta_record.nf
	
	
Read more about [splitFasta](http://www.nextflow.io/docs/latest/operator.html#splitfasta) operator. 	



#### 6. Execute an external process (*)       

This example executes a BLAST search given an input protein sequence file.

Run the example with this command:  

	nextflow run process_input.nf	
	
	

#### 7. Execute a process and capture output (*)

This example executes a BLAST search and shows how capture and print the result output.

Run the example with this command: 

	nextflow run process_output.nf	
	
	
Run the same example providing your own query file using the
`--query` command line option. For example:

	nextflow run process_output.nf	--query <your fasta query file>
 	
	

#### 8. Scatter input data (*)

This example shows how splits a multi FASTA file in chunks and execute a BLAST query 
for each of them in parallel.  

Run the example with this command:  

	nextflow run split_fasta.nf	

By default the script split the multi FASTA file in chunks containing 10 sequences, since the 
query file is very small it will execute just one BLAST job.
 
Try to run the same example specifying a lower number of sequences in each chunk.
For example: 

	nextflow run split_fasta.nf --chunkSize 2	



#### 9. Gather output files (*)

Shows how splits a multi FASTA file, execute a BLAST query for ach chunk and create a result file

Run the example with this command: 

	nextflow run split_and_collect.nf
	
Read more about the [collectFile](http://www.nextflow.io/docs/latest/operator.html#collectfile) operator.	
	

#### 10. Process multiple input file in parallel (*)

This example shows how process multiple input files in a parallel manner. For each given 
query FASTA file, it will execute a BLAST job.

Run the example with this command: 

	nextflow run multiple_inputs.nf 
	
	
By default the script process a single input file (`data/sample.fa`).
 

Try to run this example by specifying more than one input file as shown in the example below: 

	nextflow run multiple_inputs.nf --query data/prot_\*.fa

It will execute a BLAST search for each file that matches the 
the wildcard path matcher. 
 

#### 11. Tuple of values (*)

This example shows how process can receive as input and produce as output 
tuple of values, which is useful to keep together related meta data. 


Run the example with this command:  

	nextflow run set_in_out.nf 



#### 12. Transform channel content 

Simple example showing how the items emitted by a channel can be transformed 
by using the `map` operator.

Run the example with this command:  

	nextflow run basic_map.nf 

Read more about the [map](http://www.nextflow.io/docs/latest/operator.html#map) operator.



#### 13. Filtering a channel 

This example shows how a channel content can be filtered using an arbitrary condition
and how operators can be chained to create a more complex processing behaviour.  

Run the example with this command: 

	nextflow run filter_operator.nf 

Read more about the [filter](http://www.nextflow.io/docs/latest/operator.html#filter) operator.



#### 14. FlatMap operator 

This example shows the usage of the`flatMap` operator. 


Run the example with this command:  

	nextflow run flat_map.nf 
	
Read more about the [flatMap](http://www.nextflow.io/docs/latest/operator.html#flatmap) operator	



#### 15. Join two channels

An example showing the usage of the `phase` operator to synchronise the items emitted by two channels.
 
Run the example with this command: 

	nextflow run phase_operator.nf 
    
    
Read more about the [phase](http://www.nextflow.io/docs/latest/operator.html#phase) operator.    

#### 16. Join two workflows

Inside:

   merge-workflows/

This example shows how two workflows might be joined using a shell pipeline `|` operator of STDOUT/IN streams.
Option `-q` is necessary because additional information produced by nextflow might disrupt CSV parser.

Run the exmaple with this command:

    nextflow -q run flow-a.nf | nextflow -q run flow-b.nf
	
Or using shell script:

   run.sh

    
## Other examples 

For a catalog of pipelines using nextflow see [Awesome-nextflow](https://github.com/nextflow-io/awesome-nextflow) list.

    
 
 


