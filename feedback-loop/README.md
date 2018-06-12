# Feedback loop  

## Problem 

Iterate the execution of one or more processes until  a condition
is reached. 

## Solution

Use the output of the process to iterate over as the input of the same or an upstream process. 

To do so, explicitly create the output channel using [Channel.create](https://www.nextflow.io/docs/latest/channel.html#create) function. 

Then define the process input as a mix of of the initial input and the
process output to which is applied an [until]() operator defining the 
termination condition. 

## Code 

```nextflow 

params.input = 'hello.txt'

condition = { it.readLines().size()>3 }
feedback_ch = Channel.create()
input_ch = Channel.fromPath(params.input).mix( feedback_ch.until(condition) )

process foo {
    input: 
    file x from input_ch
    output: 
    file 'foo.txt' into foo_ch
    script:
    """
    cat $x > foo.txt 
    """
}

process bar {
    input:
    file x from foo_ch 
    output:
    file 'bar.txt' into feedback_ch
    file 'bar.txt' into result_ch
    script:
    """
    cat $x > bar.txt
    echo World >> bar.txt 
    """
}

result_ch.last().println { "Result:\n${it.text.indent(' ')}" }
```

## Run it

Use the the following command to execute the example:

    nextflow run main.nf

