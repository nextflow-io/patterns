## Problem 

You need to split one or more input files into chunks and execute a task for each of them.

## Solution

Use the [splitText](https://www.nextflow.io/docs/latest/operator.html#splittext) operator to split a file into chunks of a given size. Then use the resulting channel as input for the process implementing your task. 

!!! warning
    Chunks are kept in memory by default. When splitting big files, specify the parameter `file: true` to save the chunks into files. See the [documentation](https://www.nextflow.io/docs/latest/operator.html#splittext) for details.

Splitter for specific file formats are available, e.g. [splitFasta](https://www.nextflow.io/docs/latest/operator.html#splitfasta) and [splitFastq](https://www.nextflow.io/docs/latest/operator.html#splitfastq).
 
## Code 

```groovy
params.infile = "$baseDir/data/poem.txt"
params.size = 5

process foo {
  debug true
  input: 
  file x

  script:
  """
  rev $x | rev
  """
}

workflow {
  Channel.fromPath(params.infile) \
    | splitText(by: params.size) \
    | foo
}
```

## Run it 

Use the the following command to execute the example:

```bash
nextflow run nextflow-io/patterns/process-per-file-chunk.nf
```
