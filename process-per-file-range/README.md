# Process per file range 

## Problem 

You need to execute a task over two or more series of files having a common index range. 

## Solution 

Use a the [from](https://www.nextflow.io/docs/latest/channel.html#from) method 
define the range over which repeat the task execution, 
then chain it with a [map](https://www.nextflow.io/docs/latest/operator.html#map) operator 
to associate the each index the corresponding input files. Finally use the resulting channel as input for the process.

## Code 

```nextflow

Channel
  .from(1..23)
  .map { chr -> tuple("sample$chr", file("/some/path/foo.${chr}.indels.vcf"), file("/other/path/foo.snvs.${chr}.vcf")) }
  .set { pairs_ch }
  
  
process foo {
  tag "$sampleId"
  
  input: 
  set sampleId, file(indels), file(snps) from pairs_ch
  
  """
  echo foo_command --this $indels --that $snps
  """
} 
```
