# Process per file  

## Problem 

Execute a process for each file in a given path or matching a glob pattern. 

## Solution

Use the [Channel.fromPath]() method to create a channel emitting all files matching 
the specified glob pattern. Use the channel as process input. 


## Code 

```nextflow

Channel.fromPath('reads/*_1.fq.gz').set{ samples_ch }

process foo {
  input:
  file x from samples_ch
  
  script:
  """
  echo your_command --input $x
  """
}
```


## Run it 

Use the the following command to execute the example:

    nextflow run main.nf


