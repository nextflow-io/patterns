## Problem 

A task in your workflow needs to use some amount of computing 
resources (e.g. memory) that depends on the size or the name of one 
or more input files. 

## Solution 

Declare the resource requirements (`memory`, `cpus`, etc.)
in a dynamic manner using a closure. 

The closure computes the required amount of resources using the file 
attributes (e.g. `size`) of the inputs declared in the process
definition.

## Code 

```groovy
process foo {
    memory { reads.size() < 70.KB ? 1.GB : 5.GB }

    input:
    path reads

    """
    echo your_command_here --in ${reads} --mem=${task.memory.giga}
    """
}

workflow {
    Channel.fromPath("$baseDir/data/reads/*_1.fq.gz", checkIfExists:true) \
        | foo
}
```

## Run it 

```bash
nextflow run nextflow-io/patterns/conditional-resources.nf
```
