## Problem 

You need to repeat a process or workflow multiple times, using the output
from the previous iteration as the input to the next iteration.

## Solution

!!! warning
    This feature is experimental and may change in the future.

Use the `recurse` method on a process or workflow to execute it iteratively.
In order to use this feature, the process or workflow must have identical input
and output definitions, and any initial values must be Groovy values or
value channels -- queue channels are not supported (yet).

You can use the `times` operator to perform a fixed number of iterations, or the
[until](https://www.nextflow.io/docs/latest/operator.html#until) operator to iterate until
some condition is satisfied.

## Code 

For an iterative process:

```groovy
nextflow.preview.recursion=true

params.data = "$baseDir/data/hello.txt"

process foo {
  input:
    path 'input.txt'
  output:
    path 'result.txt'
  script:
    """
    cat input.txt > result.txt
    echo "Task ${task.index} was here" >> result.txt
    """
}

workflow {
  // perform a fixed number of iterations
  foo
    .recurse(file(params.data))
    .times(10)

  // iterate until some condition is satisfied
  foo
    .recurse(file(params.data))
    .until { it -> it.size() > 100 }

  foo
    .out
    .view(it -> it.text)
}
```

For an iterative workflow:

```groovy
nextflow.preview.recursion=true

params.input = "$baseDir/data/hello.txt"

process tick {
  input:
    path 'input.txt'
  output:
    path 'result.txt'
  script:
    """
    cat input.txt > result.txt
    echo "Task ${task.index} : tick" >> result.txt
    """
}

process tock {
  input:
    path 'input.txt'
  output:
    path 'result.txt'
  script:
    """
    cat input.txt > result.txt
    echo "Task ${task.index} : tock" >> result.txt
    """
}

workflow clock {
  take: infile
  main:
    infile | tick | tock
  emit:
    tock.out
}

workflow {
  clock
    .recurse(file(params.input))
    .until { it -> it.size() > 100 }

  clock
    .out
    .view(it -> it.text)
}
```

## Run it

Use the the following command to execute the example:

```
# iterative process
nextflow run nextflow-io/patterns/feedback-loop-process.nf

# iterative workflow
nextflow run nextflow-io/patterns/feedback-loop-workflow.nf
```
