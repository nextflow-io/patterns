## Problem 

You need to you use the same channel as input in two or more processes.

## Solution

In DSL2, you can just do it! The [into](https://www.nextflow.io/docs/latest/operator.html#into) operator is no longer needed.

## Code 

```groovy
process foo {
  input: path x
  script: 
  """
  echo your_command --input $x
  """
}    

process bar {
  input: path x
  script: 
  """
  echo your_command --input $x
  """
}    

workflow {
  input_ch = Channel.fromPath("$baseDir/data/prots/*_?.fa")

  foo(input_ch)
  bar(input_ch)
}
```

## Run it

Use the the following command to execute the example:

```bash
nextflow run patterns/channel-duplication.nf
```
