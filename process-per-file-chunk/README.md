# Process per file chunk  

## Problem 

You need to split one or more input files into chunks and execute a task for each of them.

## Solution

Use the the [splitText](https://www.nextflow.io/docs/latest/operator.html#splittext) operator to split a file in chunks of a given size. Then use the resulting channel as input for the process implementing your task. 

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
