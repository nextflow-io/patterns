## Problem 

You need to execute a task over two or more series of files having a common index range. 

## Solution 

Use the [from](https://www.nextflow.io/docs/latest/channel.html#from) method to define the range over which to repeat the task execution, then chain it with the [map](https://www.nextflow.io/docs/latest/operator.html#map) operator to associate each index with the corresponding input files. Finally, use the resulting channel as input for the process.

## Code 

```groovy
process foo {
  debug true
  tag "$sampleId"
  
  input: 
  tuple val(sampleId), file(indels), file(snps)
  
  """
  echo foo_command --this $indels --that $snps
  """
}

workflow {
  Channel.from(1..23) \
    | map { chr -> ["sample${chr}", file("/some/path/foo.${chr}.indels.vcf"), file("/other/path/foo.snvs.${chr}.vcf")] } \
    | foo
}
```

## Run it 

```bash
nextflow run patterns/process-per-file-range.nf
```
