# publishDir with a pattern

## Problem

You need to use a pattern to save only select files from a process into a directory.

## Solution

Use the [publishDir](https://www.nextflow.io/docs/latest/process.html#publishdir) directive
with the `pattern` parameter to publish only those files matching the specified pattern.

## Code

```nextflow

process foo{
  publishDir './foo', mode: 'copy', pattern: "*.*[!bam,bai]"

  output:
  file "*.*"

  """
  touch test.bam
  touch test.bai
  touch test.txt
  """
}

process footwo{
  publishDir './footwo', mode: 'copy', pattern: "*_1_*"

  output:
  file "*.*"

  """
  touch test_1_sample.bam
  touch test_1_result.txt
  touch test_2_sample.bam
  """
}

```

## Run it

Run the script with the following command:

`nextflow run main.nf`
