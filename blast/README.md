# BLAST pipeline

Simple BLAST pipeline

## Synopsis

This script shows how to scatter the execution of multiple tasks (BLAST query)
against multiple query files or splitting the query into small chunks.


Run the tutorial using the following command:

```
nextflow run blast.nf
```

By default uses the `data/sample.fa` file as query protein sequences.


#### 1. Split the query file

Use the command line option `--chunk_size` to split the query file in chunks containing no more than 5 protein sequences. 

The script will execute a separate query job 
for each chunk. 

<details>
<summary>Solution</summary>

```
nextflow run blast.nf --chunk_size 5
```

Note to the use of single quote characters to preserve the `*` wildcard.
</details>

#### 2. Provide multiple query files

Use the `--query` command line option to specify multiple query files and execute multiple parallel
execute

<details>
<summary>Solution</summary>

```
nextflow run blast.nf --query 'data/prot*.fa'
```

Note to the use of single quote characters to preserve the `*` wildcard.
</details>
