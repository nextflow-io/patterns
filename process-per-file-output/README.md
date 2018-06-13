# Process per output file 

## Problem 

A workflow process outputs two or more files for each execution. A downstream
process needs to be executed for each file produced.

## Solution

Use the [flatten](https://www.nextflow.io/docs/latest/operator.html#flatten) operator to 
transform the outputs of the upstream process to a channel emitting each file separately. 
Use this channel as the downstream process input. 


# Code 

```nextflow

process foo {
  output:
  file '*.txt' into foo_ch 
  script:
  '''
  echo Hello there! > file1.txt
  echo What a beautiful day > file2.txt
  echo I wish you are having fun1 > file3.txt 
  ''' 
}

process foo {
  input: 
  file x from foo_ch.flatten()
  script:
  """
  cat $x
  """
}
```

## Run it

Use the the following command to execute the example:

    nextflow run main.nf

