# Get the task work directory 

## Problem 

A tool need the explicit path of the current task work directory.

## Solution 

Use the `$PWD` Bash variable or the `pwd` command to retrieve the task 
path working directory. 

Make sure use to escape the `$` variable placeholder 
when the command script is enclosed in double quote characters.


## Example 

```nextflow

process foo {
  echo true
  script:
  """
  echo foo task path: \$PWD
  """ 
}

process bar {
  echo true
  script:
  '''
  echo bar task path: $PWD
  ''' 
}
```

## Run it 

The command run the script with an empty channel: 

    nextflow run main.nf

Use the following command to provide the same script
some input files, that prevents the process to be executed: 

    nextflow run main.nf --inputs ../data/prots/\*
