# Store process outputs in subfolders

## Problem

You need to store different types of outputs of one or more processes into a directory structure of your choice.

## Solution

Use the [saveAs](https://www.nextflow.io/docs/latest/process.html#publishdir) parameter to set custom directories where the process outputs need to be made available.

## Code

```nextflow
params.reads = 'reads/*{1,2}.fq.gz'
params.outdir = 'my-results'

Channel.fromFilePairs(params.reads).set{ samples_ch }

process foo {
  publishDir "$params.outdir/$sampleId",
    saveAs: { filename ->
        if (filename.indexOf("readCounts.txt") > 0) "read_counts/$filename"
        else if (filename.indexOf("outlook.txt") > 0) "outlook/$filename"
        else "fq/$filename"
    }

  input:
  set sampleId, file(samples) from samples_ch

  output:
  set file('*.txt'), file('*.fq')

  script:
  """
  < ${samples[0]} zcat > sample1.fq
  < ${samples[1]} zcat > sample2.fq

  awk '{s++}END{print s/4}' sample1.fq > sample1_readCounts.txt
  awk '{s++}END{print s/4}' sample2.fq > sample2_readCounts.txt

  head -n 50 sample1.fq > sample1_outlook.txt
  head -n 50 sample2.fq > sample2_outlook.txt
  """
}
```

## Run it

Run the script with the following command:

    nextflow run main.nf
