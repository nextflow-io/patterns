## Problem 

A tool needs the explicit path of the current task work directory.

## Solution 

Use the `$PWD` Bash variable or the `pwd` command to retrieve the task working directory path.

!!! note
    Make sure to escape the `$` variable placeholder when the command script is enclosed in double quote characters.

## Example 

```groovy
process foo {
  debug true
  script:
  """
  echo foo task path: \$PWD
  """ 
}

process bar {
  debug true
  script:
  '''
  echo bar task path: $PWD
  ''' 
}

workflow {
  foo()
  bar()
}
```

## Run it 

The command run the script with an empty channel: 

```bash
nextflow run patterns/process-get-workdir.nf
```

Use the following command to provide the same script
some input files, that prevents the process from being executed: 

```bash
nextflow run patterns/process-get-workdir.nf --inputs ../data/prots/\*
```
