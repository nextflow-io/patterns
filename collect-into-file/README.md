# Collect into a file 

## Problem 

You need to concatenate into a single file all the outputs an upstream process. 

## Solution 

Use the [https://www.nextflow.io/docs/latest/operator.html#collectfile] to merge all
upstream output files into a single file. 

## Code

```nextflow 

Channel.fromPath('reads/*_1.fq.gz').set { samples_ch }

process foo {
  input:
  file x from samples_ch
  output:
  file 'file.fq' into unzipped_ch
  script:
  """
  < $x zcat > file.fq
  """
}

unzipped_ch
      .collectFile()
      .println{ it.text }
```

## Run it

Use the the following command to execute the example:

    nextflow run main.nf