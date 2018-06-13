# Process file pairs 

## Problem 

Process the files into a directory grouping them by pairs. 

## Solution 

Use the [Channel.fromFilePairs](https://www.nextflow.io/docs/latest/channel.html#fromfilepairs) function 
to create a channel emitting the file pairs matching a glob pattern. The pattern must match a common 
name prefix.

The matching files are emitted as tuples in which the first element is the grouping key of the matching pair and the second element is the list of files. 


## Code

```
Channel
    .fromFilePairs('reads/*_{1,2}.fq.gz')
    .set { samples_ch }

process foo {
  input:
  set sampleId, file(reads) from samples_ch

  script:
  """
  echo your_command --sample $sampleId --reads $reads
  """
}

```    