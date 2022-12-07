## Problem 

You have many tuples with a sample name that works as an identifier and you want to sort by the sample name.

## Solution

Use the [toSortedList](https://www.nextflow.io/docs/latest/operator.html#tosortedlist) and the [flatMap](https://www.nextflow.io/docs/latest/operator.html#flatmap) operators to convert the channel to a sorted list, and then convert back to the original structure you get from the [fromFilePairs](https://www.nextflow.io/docs/latest/channel.html?highlight=fromfilepairs#fromfilepairs) channel factory.

## Code

```groovy
Channel
  .fromFilePairs('/my/path/data/*_{1,2}.fastq')
  .toSortedList( { a, b -> a[0] <=> b[0] } )
  .flatMap()
  .view()
```

## Run it

Run the example using this command:

```bash
nextflow run nextflow-io/patterns/vim sort-filepairs-by-samplename.nf
```
