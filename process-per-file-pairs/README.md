# Process per file pairs 

## Problem 

You need to process the files into a directory grouping them by pairs. 

## Solution 

Use the [Channel.fromFilePairs](https://www.nextflow.io/docs/latest/channel.html#fromfilepairs) method to create a channel emitting the file pairs matching a glob pattern. The pattern must match a common prefix in the paired file names.

The matching files are emitted as tuples in which the first element is the grouping key of the matching files and the second element is the file pair itself. 


## Code

```nextflow 

Channel
    .fromFilePairs('reads/*_{1,2}.fq.gz')
    .set { samples_ch }

process foo {
  input:
  set sampleId, file(reads) from samples_ch

  script:
  """
  your_command --sample $sampleId --reads $reads
  """
}

```    