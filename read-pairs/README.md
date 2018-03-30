# File pairs 

How manage file pairs

## Synopsis 

This tutorial show how to handle file pairs that's a very common pattern in genomic applications. 

Nextflow provides the [Channel.fromFilePairs](https://www.nextflow.io/docs/latest/channel.html#fromfilepairs) 
that is able to create a channel handling n-tuples of files.

To run the example use the following command: 

```
nextflow run read-pairs.nf
```
