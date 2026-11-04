## Problem 

A task is expected to fail in some cases. You want to ignore the failure and continue the execution of the remaining tasks in the workflow. 

## Solution

Use the process [directive](https://www.nextflow.io/docs/latest/process.html#errorstrategy) `errorStrategy 'ignore'` to ignore the error condition. 

## Code 

```groovy
process foo {
  errorStrategy 'ignore'
  script:
  '''
  echo This is going to fail!
  exit 1
  '''
}  

process bar {
  script:
  '''
  echo OK
  '''
}

workflow {
  foo()
  bar()
}
```

## Run it 

Run the script with the following command: 

```bash
nextflow run nextflow-io/patterns/ignore-failing-process.nf 
```
