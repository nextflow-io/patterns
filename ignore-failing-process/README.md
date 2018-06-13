# Ignore failing process 

## Problem 

A process is expected to fail in certain situation. It's required to ignore
the failing process and allows the remaining workflow to complete. 

## Solution

Use the `errorStrategy 'ignore'` [directive](https://www.nextflow.io/docs/latest/process.html#errorstrategy) to ignore the error condition. 


## Code 

```nextflow 

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
```

## Run it 

Run the script with the following command: 

    nextflow run main.nf 

