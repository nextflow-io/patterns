## Problem 

You need to store the outputs of one or more processes into a directory structure of your choice.

## Solution 

Use the [publishDir](https://www.nextflow.io/docs/latest/process.html#publishdir) directive to define a custom directory where the process outputs should be saved.

## Code 

```groovy
params.reads = "$baseDir/data/reads/*{1,2}.fq.gz"
params.outdir = 'my-results'

process foo {
  publishDir "$params.outdir/$sampleId"
  input:
  tuple val(sampleId), file(samples)
  output:
  path '*.fq'

  script:
  """
  < ${samples[0]} zcat > sample_1.fq 
  < ${samples[1]} zcat > sample_2.fq 
  """
} 

workflow {
  Channel.fromFilePairs(params.reads, checkIfExists: true) \
    | foo
}
```

## Run it 

Run the script with the following command: 

```bash
nextflow run nextflow-io/patterns/publish-process-outputs.nf 
```
