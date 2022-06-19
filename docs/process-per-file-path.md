## Problem 

You need to execute a task for each file that matches a glob pattern. 

## Solution

Use the [Channel.fromPath](https://www.nextflow.io/docs/latest/channel.html#frompath) method to create a channel emitting all files matching the glob pattern. Then, use the channel as input of the process implementing your task. 

## Code 

```nextflow
process foo {
  debug true
  input:
  path x

  script:
  """
  echo your_command --input $x
  """
}

workflow {
  foo("$baseDir/data/reads/*_1.fq.gz")
}
```

## Run it 

Use the the following command to execute the example:

```bash
nextflow run patterns/process-per-file-path.nf
```
