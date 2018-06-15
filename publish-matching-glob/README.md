# Store outputs matching a glob pattern

## Problem

A task in your workflow creates many output files that are required by a downstream task. 
You want to store some of those files into separate directories depending the file name.

## Solution

Use two or more [publishDir](https://www.nextflow.io/docs/latest/process.html#publishdir) directives
to store the output files into separate storing paths. For each directive specify a different glob string 
using the option `pattern` to store into each directory only the files that match the provided pattern.   

## Code

```nextflow

params.reads = 'reads/*_{1,2}.fq.gz'
params.outdir = 'my-results'

Channel
    .fromFilePairs(params.reads, flat: true)
    .set{ samples_ch }

process foo {
  publishDir "$params.outdir/$sampleId/counts", pattern: "*_counts.txt"
  publishDir "$params.outdir/$sampleId/outlooks", pattern: '*_outlook.txt'
  publishDir "$params.outdir/$sampleId/", pattern: '*.fq'

  input: 
    set sampleId, file('sample1.fq.gz'), file('sample2.fq.gz') from samples_ch 
  output: 
    file "*"
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

```

## Run it

Run the script with the following command:

    nextflow run main.nf
