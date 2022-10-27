## Problem 

A task in your workflow produces two or more files at time. A downstream task needs to process each
of these files independently.

## Solution

Use the [flatten](https://www.nextflow.io/docs/latest/operator.html#flatten) operator to 
transform the outputs of the upstream process to a channel that emits each file separately. 
Then use this channel as input for the downstream process. 

## Code 

```groovy
process foo {
  output:
  path '*.txt'

  script:
  '''
  echo Hello there! > file1.txt
  echo What a beautiful day > file2.txt
  echo I hope you are having fun! > file3.txt 
  ''' 
}

process bar {
  debug true
  input: 
  path x

  script:
  """
  cat $x
  """
}

workflow {
  foo | flatten | bar
}
```

## Run it

Use the the following command to execute the example:

```bash
nextflow run patterns/process-per-file-output.nf
```
