## Problem 

You have two sequential tasks in your workflow. When an optional flag is specified, the first task should be skipped and its input(s) should be processed by the second task.

## Solution

Use an empty channel, created in a conditional expression, to skip the first process execution when an optional parameter is specified. Then, define the second process input as a [mix](https://www.nextflow.io/docs/latest/operator.html#mix) of the first process output (when executed) and the input channel.

## Code 

```groovy
params.skip = false
params.input = "$baseDir/data/reads/sample.fq.gz" 

process foo {
  input:
  path x

  output:
  file('*.fastq')

  script:
  """
  < $x zcat > ${x.simpleName}.fastq
  """
}

process bar {
  debug true

  input: 
  path x

  script:
  """
  echo your_command --input $x
  """
}

workflow {
  input_ch = Channel.fromPath(params.input)

  (foo_ch, bar_ch) = params.skip
    ? [Channel.empty(), input_ch] 
    : [input_ch, Channel.empty()]

  foo_ch | foo | mix(bar_ch) | bar
}
```

## Run it

Use the the following command to execute the example:

```bash
nextflow run nextflow-io/patterns/skip-process-execution.nf
```

The processes `foo` and `bar` are executed. Run the same command with the `--skip` command line option:

```bash
nextflow run nextflow-io/patterns/skip-process-execution.nf --skip
```

This time only the `bar` process is executed.
