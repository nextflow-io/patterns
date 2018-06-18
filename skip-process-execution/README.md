# Skip process execution 

## Problem 

You have two sequential tasks in your workflow. When an optional flag is specified 
the first task should not be executed and its input(s) is processed by the second task.

## Solution

Use an empty channel, created in a conditional expression, to skip the 
first process execution when an optional parameter is specified. 

Then, define the second process input as a [mix](https://www.nextflow.io/docs/latest/operator.html#mix) 
of the first process output (when executed) and the input channel.

## Code 

```nextflow

params.skip = false
params.input = "$baseDir/reads/110101_I315_FC816RLABXX_L1_HUMrutRGXDIAAPE_1.fq.gz" 

Channel.fromPath(params.input).set{ input_ch }

(foo_ch, bar_ch) = ( params.skip 
                 ? [Channel.empty(), input_ch] 
                 : [input_ch, Channel.empty()] ) 

process foo {
  input:
  file x from foo_ch

  output:
  file('*.fastq') into optional_ch

  script:
  """
  < $x zcat > ${x.simpleName}.fastq
  """
}

process bar {
  echo true
  input: 
  file x from bar_ch.mix(optional_ch)
  """
  echo your_command --input $x
  """
}

```

## Run it

Use the the following command to execute the example:

    nextflow run patterns/conditional-process

The processes `foo` and `bar` are executed. Run the same command 
with the `--skip` command line option. 

    nextflow run nextflow run patterns/conditional-process --skip

This time only processes `bar` is executed.
