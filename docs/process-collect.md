## Problem 

You need to process all the outputs of an upstream task altogether. 

## Solution

Use the [collect](https://www.nextflow.io/docs/latest/operator.html#collect) operator to gather 
all the outputs produced by the upstream task and emit them as a single output. 
Then use the resulting channel as input for the downstream task.

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

process bar {
  debug true   
  input:
  path '*.fq'
  script:
  """
  cat *.fq | head -n 50
  """
}

workflow {
  Channel.fromPath("$baseDir/data/reads/*_1.fq.gz", checkIfExists: true) \
    | foo \
    | collect \
    | bar
}
```

## Run it

Use the the following command to execute the example:

```bash
nextflow run patterns/process-collect.nf
```
