## Problem 

You need to concatenate into a single file all output files produced by an upstream process. 

## Solution 

Use the [collectFile](https://www.nextflow.io/docs/latest/operator.html#collectfile) operator to merge all
the output files into a single file. 

## Code

```groovy
process foo {
  input:
  path x
  output:
  path 'file.fq'
  script:
  """
  < $x zcat > file.fq
  """
}

workflow {
  Channel.fromPath("$baseDir/data/reads/*_1.fq.gz", checkIfExists: true) \
    | foo \
    | collectFile \
    | view
}
```

## Run it

Use the the following command to execute the example:

```bash
nextflow run patterns/collect-into-file.nf
```
