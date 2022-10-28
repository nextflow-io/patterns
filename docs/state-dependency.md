## Problem 

You need to synchronize the execution of two processes for which there isn't a data dependency, so that process `bar` is executed after the completion of process `foo`.  

## Solution

Add an output channel to process `foo` that produces a _ready_ signal. Then pass this channel as input to process `bar` in order to trigger its execution when `foo` completes.

## Code 

```groovy
process foo {
    output: 
    val true
    script:
    """
    echo your_command_here
    """
}

process bar {
    input: 
    val ready
    path fq
    script:
    """
    echo other_commad_here --reads $fq
    """
}

workflow {
    reads_ch = Channel.fromPath("$baseDir/data/reads/11010*.fq.gz", checkIfExists:true)

    foo()
    bar(foo.out, reads_ch)
}
```

## Run it

Run the example using this command:

```bash
nextflow run nextflow-io/patterns/state-dependency.nf
```
