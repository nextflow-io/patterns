# SplitFasta operator 

Split one or more FASTA file

## Synopsis

This tutorial shows how to split one 
or more FASTA file into multiple chunks using 
the [splitFasta](https://www.nextflow.io/docs/latest/operator.html#splitfasta) operator.


Run the tutorial using the following command: 

```
nextflow run splitfasta-op.nf
```

## What's next

#### 1. Define the number of entrie in each chunk 

By default the `splitFast` create chunks containg one sequence. 
Use the `by` option to define the number of entries in each chunk.

<details>
<summary>Solution</summary>

```
Channel.fromPath("$baseDir/data/sample.fa")
       .splitFasta(by: 5)
       .println() 
```       
</details>

#### 2. Split multiple files 

The `splitFasta` can operate on a single or multiple files. 
Modify the example to split all files matching the pattern `data/prot*.fa`. 

<details>
<summary>Solution</summary>

```
Channel.fromPath("$baseDir/data/prot*.fa")
       .splitFasta()
       .println() 
```       
</details>

#### 3. Save chunk to files

The `splitFasta` creates chunk a in-memory strings. This can easili consume all available memory
when working with big FASTA files. In such case use the `file:true` option to save the chunks 
in tempory files.

<details>
<summary>Solution</summary>

```
Channel.fromPath("$baseDir/data/sample.fa")
       .splitFasta(file: true)
       .println() 
```       
</details>

