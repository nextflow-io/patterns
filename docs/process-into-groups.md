## Problem 

You need to process in the same batch all files that have a matching key in the file name.

## Solution 

Use the [map](https://www.nextflow.io/docs/latest/operator.html#map) operator to associate each file with a key extracted from the file name. Then chain the resulting channel with the [groupTuple](https://www.nextflow.io/docs/latest/operator.html#grouptuple) operator to group together all files that have a matching key. Finally, use the resulting channel as input for the process.

## Code

```nextflow
params.reads = "$baseDir/data/reads/*"

process foo {
  debug true
  input:
  tuple val(key), file(samples)

  script:
  """
  echo your_command --batch $key --input $samples 
  """
} 

workflow {
  Channel.fromPath(params.reads, checkIfExists:true) \
    | map { file -> 
      def key = file.name.toString().tokenize('_').get(0)
      return tuple(key, file)
    } \
    | groupTuple() \
    | foo
}
```

## Run it 

```bash
nextflow run patterns/process-into-groups.nf
```
