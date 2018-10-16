# Conditional resources definition 

## Problem 

A task in your workflow requires to use an amount of computing 
resources eg. memory that depends on the size or the name of one 
or more input files. 

## Solution 

Declare the resource requirements e.g. `memory`, `cpus`, etc.
in a dynamic manner using a closure. 

The closure computes the required amount of resources using the file 
attributes, such as `size`, etc., of the inputs declared in the process
definition.

## Code 

```nextflow 

Channel
    .fromPath('reads/*_1.fq.gz')
    .set { reads_ch }

process foo {
    memory { reads.size() < 70.KB ? 1.GB : 5.GB }

    input:
    file reads from reads_ch 

    """
    your_command_here --in $reads
    """
}
```


Note: requires version 0.32.0 or later.
