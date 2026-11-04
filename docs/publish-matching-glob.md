## Problem

A task in your workflow creates many output files that are required by a downstream task.  You want to store some of those files into separate directories depending on the file name.

## Solution

Use two or more [publishDir](https://www.nextflow.io/docs/latest/process.html#publishdir) directives to publish the output files into separate paths. For each directive specify a different glob pattern using the `pattern` option to store into each directory only the files that match the provided pattern.

## Code

```groovy
params.reads = "$baseDir/data/reads/*_{1,2}.fq.gz"
params.outdir = 'my-results'

process foo {
  publishDir "$params.outdir/$sampleId/counts", pattern: "*_counts.txt"
  publishDir "$params.outdir/$sampleId/outlooks", pattern: '*_outlook.txt'
  publishDir "$params.outdir/$sampleId/", pattern: '*.fq'

  input: 
    tuple val(sampleId), file('sample1.fq.gz'), file('sample2.fq.gz')
  output: 
    path "*"
  script:
    """
    < sample1.fq.gz zcat > sample1.fq
    < sample2.fq.gz zcat > sample2.fq

    awk '{s++}END{print s/4}' sample1.fq > sample1_counts.txt
    awk '{s++}END{print s/4}' sample2.fq > sample2_counts.txt

    head -n 50 sample1.fq > sample1_outlook.txt
    head -n 50 sample2.fq > sample2_outlook.txt
    """
}

workflow {
  Channel.fromFilePairs(params.reads, checkIfExists: true, flat: true) \
    | foo
}
```

## Run it

Run the script with the following command:

```bash
nextflow run nextflow-io/patterns/publish-matching-glob.nf
```
