## Problem 

You need to process the files in a directory, grouping them by pairs. 

## Solution 

Use the [Channel.fromFilePairs](https://www.nextflow.io/docs/latest/channel.html#fromfilepairs) method to create a channel that emits file pairs matching a glob pattern. The pattern must match a common prefix in the paired file names.

The matching files are emitted as tuples in which the first element is the grouping key of the matching files and the second element is the file pair itself. 

## Code

```groovy
process foo {
  debug true

  input:
  tuple val(sampleId), file(reads)

  script:
  """
  echo your_command --sample $sampleId --reads $reads
  """
}

workflow {
  Channel.fromFilePairs("$baseDir/data/reads/*_{1,2}.fq.gz", checkIfExists:true) \
    | foo
}
```

## Run it 

```bash
nextflow run patterns/process-per-file-pairs.nf
```

## Custom grouping strategy

When necessary, it is possible to define a custom grouping strategy. A common use case is for alignment BAM files (`sample1.bam`) that come along with their index file. The difficulty is that the index is sometimes called `sample1.bai` and sometimes `sample1.bam.bai` depending on the software used. The following example can accommodate both cases. 

```groovy
process foo {
  debug true
  tag "$sampleId"
  
  input:
  tuple val(sampleId), file(bam)

  script:
  """
  echo your_command --sample ${sampleId} --bam ${sampleId}.bam
  """
}

workflow {
  Channel.fromFilePairs("$baseDir/data/alignment/*.{bam,bai}", checkIfExists:true) { file -> file.name.replaceAll(/.bam|.bai$/,'') } \
    | foo
}
```

## Run it 

```bash
nextflow run patterns/process-per-file-pairs-custom.nf
```
