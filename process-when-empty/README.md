# Execute when empty 

## Problem 

You need to execute a process if a channel is empty. 

## Solution 

Use the [ifEmpty](https://www.nextflow.io/docs/latest/operator.html#ifempty) operator to emit 
a *marker* value to trigger the execution of the process. 

## Example 

```nextflow

process foo {
  input:
  val x from ch.ifEmpty { 'EMPTY' } 
  when:
  x == 'EMPTY'

  script:
  '''
  your_command
  ''' 
}
```

## Run it 

The command run the script with an empty channel: 

    nextflow run main.nf

Use the following command to provide the same script
some input files, that prevents the process to be executed: 

    nextflow run main.nf --inputs ../data/prots/\*
