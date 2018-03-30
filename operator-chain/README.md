# Operator chaining  

This example shows how chain operators

## Synopsis 

Operators can be chained together to implement custom functions. 

This tutorial shows how use the `splitFasta` operator to split a FASTA file 
in multiple records, then filter out all record not matching a regular expression,
then it counts all matching record and finally prints the resulting value.

To run the example use the following command: 

```
nextflow run filter-op.nf
```
