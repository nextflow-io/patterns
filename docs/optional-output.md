## Problem 

A task in your workflow is expected to not create an output file in some circumstances. 

## Solution

Declare such output as an `optional` file. 

## Code 

```groovy
process foo {
  output: 
  path 'foo.txt', optional: true

  script:
  '''
  touch foo.txt
  '''
}

workflow {
  foo()
}
```

## Run it

Use the the following command to execute the example:

```bash
nextflow run patterns/optional-output.nf
```
