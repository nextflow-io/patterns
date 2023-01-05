## Problem 

You need to execute a process if a channel is empty. 

## Solution 

Use the [ifEmpty](https://www.nextflow.io/docs/latest/operator.html#ifempty) operator to emit a _marker_ value to trigger the execution of the process. 

## Example 

```groovy
params.inputs = ''

process foo {
  debug true  
  input:
  val x
  when:
  x == 'EMPTY'

  script:
  '''
  echo hello
  ''' 
}

workflow {
  reads_ch = params.inputs
    ? Channel.fromPath(params.inputs, checkIfExists:true)
    : Channel.empty()

  reads_ch \
    | ifEmpty { 'EMPTY' } \
    | foo
}
```

## Run it 

Use the following command to run the script with an empty channel: 

```bash
nextflow run nextflow-io/patterns/process-when-empty.nf
```

Use the following command to provide the same script some input files, which prevents the process from being executed: 

```bash
nextflow run nextflow-io/patterns/process-when-empty.nf --inputs ../data/prots/\*
```
