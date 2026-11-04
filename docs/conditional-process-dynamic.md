## Problem 

One of two processes should be executed depending on the result of an upstream channel.

## Solution

Because the condition is a channel result, `if/else` cannot be used. Instead, use the `branch` operator to create a "true" channel and a "false" channel. The channel whose condition is true will receive a value, which will trigger its respective process.

## Code 

```groovy
process foo {
    input:
    val signal
    output: 
    path 'x.txt'

    script:
    '''
    echo foo > x.txt
    '''
}

process bar {
    input:
    val signal
    output: 
    path 'x.txt'

    script:
    '''
    echo bar > x.txt
    '''
}

workflow {
    ch_if = Channel.of( 1..100 )
      | randomSample(1)
      | branch { n ->
        TRUE: n > 50
        FALSE: n <= 50
      }

    ch_if.TRUE | foo
    ch_if.FALSE | bar
}
```

## Run it

Use the the following command to execute the example:

```bash
nextflow run nextflow-io/patterns/conditional-process3.nf
```

The workflow will execute `foo` or `bar` based on a random number. Execute it multiple times to observe the random behavior.
