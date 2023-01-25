## Problem 

You have a subworkflow, and you would like to limit the number of parallel subworkflow executions.

## Solution

For a single process, you could use the [maxForks](https://nextflow.io/docs/latest/process.html#maxforks) directive to limit the number of parallel process executions. For a subworkflow, you can achieve the same effect by merging the subworkflow's processes into a single process, and then using `maxForks` or the `executor.queueSize` config option.

The following example is based on a "diamond-shaped" subworkflow, in order to show how to implement parallel steps in a Bash script. View the [complete example](https://github.com/nextflow-io/patterns/blob/master/workflow-grouping.nf) to see the original subworkflow.

## Code 

```groovy
params.n_groups = 10
params.queue_size = 2

process diamond_merged {
    maxForks params.queue_size

    input: val(index)
    output: tuple val(index), path('d.txt')

    script:
    """
    sleep 1

    # process A
    echo "subworkflow ${index}, process A was here" >> a.txt

    # process B
    process_b() {
        cat a.txt >> b.txt
        echo "subworkflow ${index}, process B was here" >> b.txt
    }
    process_b &

    # process C
    process_c() {
        cat a.txt >> c.txt
        echo "subworkflow ${index}, process C was here" >> c.txt
    }
    process_c &

    wait

    # process D
    cat b.txt >> d.txt
    cat c.txt >> d.txt
    echo "subworkflow ${index}, process D was here" >> d.txt
    """
}

workflow {
    Channel.of(1..params.n_groups)
      | diamond_merged
}
```

## Run it

Run the example using this command:

```bash
nextflow run nextflow-io/patterns/workflow-grouping.nf
```
