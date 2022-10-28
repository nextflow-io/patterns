## Problem 

You have many small tasks that you would like to process in batches to reduce job submission overhead.

## Solution

Use the [buffer](https://www.nextflow.io/docs/latest/operator.html#buffer) operator to collect your input channel into batches, then refactor the process to accept a list of inputs instead of one input. One job will be created for each batch instead of each task.

## Code 

```groovy
process foo {
    input:
    val indices

    script:
    """
    for INDEX in ${indices.join(' ')}; do
        echo "Hello from task \${INDEX}!"
    done
    """
}

workflow {
    Channel.of(1..1000)
        | buffer(size: 10, remainder: true)
        | foo
}
```

## Run it

Run the example using this command:

```bash
nextflow run nextflow-io/patterns/task-batching.nf
```
