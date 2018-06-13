# Process per chunk  

## Problem 

Split one or more input files in chunks and execute a process 
for each of them.

## Solution

Use the the [splitText](https://www.nextflow.io/docs/latest/operator.html#splittext) operator to split a file in chunk of a given size. Use 
the resulting channel a input of the process. 

Caveat: By default chunks are kept in memory. When splitting big files specify the parameter `file: true` to save the chunks into files. See the [documentation](https://www.nextflow.io/docs/latest/operator.html#splittext) for details.

Splitter for specific file formats are available, eg [splitFasta](https://www.nextflow.io/docs/latest/operator.html#splitfasta) and [splitFastq](https://www.nextflow.io/docs/latest/operator.html#splitfastq).
 

## Code 

```nextflow

Channel
    .fromPath('poem.txt')
    .splitText(by: 5)
    .set{ chunks_ch }

process foo {
  echo true
  input: 
  file x from chunks_ch

  script:
  """
  rev $x | rev
  """
} 
```

## Run it 

Use the the following command to execute the example:

    nextflow run main.nf
