## Problem 

You have many tuples with a sample name that works as an identifier and you want to sort the channel by the sample name.

## Solution

Use the [toSortedList](https://www.nextflow.io/docs/latest/operator.html#tosortedlist) and the [flatMap](https://www.nextflow.io/docs/latest/operator.html#flatmap) operators to convert the channel to a sorted list, and then convert back to the original structure you get from the [fromFilePairs](https://www.nextflow.io/docs/latest/channel.html?highlight=fromfilepairs#fromfilepairs) channel factory.

It's worth mentioning that the [toSortedList](https://www.nextflow.io/docs/latest/operator.html#tosortedlist) operator is not scalable as it introduces a blocking point in the pipeline execution since to sort the elements of a channel, it needs to collect all of them first.

The [fromFilePairs](https://www.nextflow.io/docs/latest/channel.html#fromfilepairs) channel factory in the code below will create a channel with tuple elements on the following format:

```groovy
[
  [samplec, [/path/to/my/files/samplec_1.fastq, /path/to/my/files/samplec_2.fastq]]
  [sampleb, [/path/to/my/files/sampleb_1.fastq, /path/to/my/files/sampleb_2.fastq]]
  [samplea, [/path/to/my/files/samplea_1.fastq, /path/to/my/files/samplea_2.fastq]]
  [sampled, [/path/to/my/files/sampled_1.fastq, /path/to/my/files/sampled_2.fastq]]
  [samplee, [/path/to/my/files/samplee_1.fastq, /path/to/my/files/samplee_2.fastq]]
]
```
## Code

```groovy
Channel
  .fromFilePairs('/path/to/my/files/*_{1,2}.fastq')
  // Sort the channel elements based on the first object of each tuple,
  // that is, the sample name, and convert to a channel with a single
  // element which is a list of tuples
  .toSortedList( { a, b -> a[0] <=> b[0] } ) // <=> is an operator for comparison
  // flatten the single-element channel to a channel with as many elements
  // as there are samples, which is the original structure provided by
  // fromFilePairs
  .flatMap()
  // View the channel elements by printing it to the screen
  .view()
```

## Run it

Run the example using this command:

```bash
nextflow run nextflow-io/patterns/vim sort-filepairs-by-samplename.nf
```
