## Problem 

One of two different tasks should be executed based on some condition, 
and a third task should process the results of the selected task.

## Solution

Simply execute either process using `if/else` statements on the condition.
Define a channel, e.g. `omega_ch`, which emits the output of the selected process 
in each case. Then, execute the third process with this output channel.

Or, use a ternary expression and a pipe to keep things short and sweet.

## Code 

```nextflow
params.flag = false 

process foo {
  output: 
  path 'x.txt'

  script:
  '''
  echo foo > x.txt
  '''
}

process bar {
  output: 
  path 'x.txt'

  script:
  '''
  echo bar > x.txt
  '''
}

process omega {
  debug true
  input:
  path x
  
  script:
  """
  cat $x 
  """
}

workflow {
  // the long way
  if ( params.flag ) {
    bar()
    omega_ch = bar.out
  }
  else {
    foo()
    omega_ch = foo.out
  }

  omega(omega_ch)

  // the short way
  (params.flag ? bar : foo) | omega
}
```

## Run it

Use the the following command to execute the example:

```bash
nextflow run patterns/conditional-process.nf
```

The processes `foo` and `omega` are executed. Run the same command 
with the `--flag` command line option. 

```bash
nextflow run patterns/conditional-process.nf --flag 
```

This time the processes `bar` and `omega` are executed.

## Alternative solution

Create an input channel for each process that is either populated with data or an
[empty](https://www.nextflow.io/docs/latest/channel.html#empty) channel.
Each process will execute only if its input channel has data.

Then use the [mix](https://www.nextflow.io/docs/latest/operator.html#mix) operator to create 
a new channel that emits the outputs produced by the two processes, and use it as the input
for the third process.

## Code 

```nextflow
params.flag = false

process foo {
  input:
  val x

  output:
  path 'x.txt'

  script:
  """
  echo $x > x.txt
  """
}

process bar {
  input:
  val(b)

  output:
  path 'x.txt'

  script:
  """
  echo $b > x.txt
  """
}

process omega {
  debug true
  input:
  path x

  script:
  """
  cat $x
  """
}

workflow {
  (foo_ch, bar_ch) = params.flag
    ? [ Channel.empty(), Channel.from(1,2,3) ]
    : [ Channel.from(4,5,6), Channel.empty() ]

  foo(foo_ch)
  bar(bar_ch)

  foo.out | mix(bar.out) | omega
}
```

## Run it 

```bash
nextflow run patterns/conditional-process2.nf
```
