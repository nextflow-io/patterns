## Problem 

You need to save the outputs of a process to a directory, giving each file a name of your choice.

## Solution 

The [publishDir](https://www.nextflow.io/docs/latest/process.html#publishdir) allows you to save the process outputs in a directory of your choice. 

Use the `saveAs` option to give each file a name of your choice, providing a custom rule as a [closure](https://www.nextflow.io/docs/latest/script.html#closures). 

## Code 

```groovy
process foo {
  publishDir 'results', saveAs: { filename -> "foo_$filename" }

  output: 
  path '*.txt'

  '''
  touch this.txt
  touch that.txt
  '''
}

workflow {
  foo()
}
```

## Run it 

```bash
nextflow run nextflow-io/patterns/publish-rename-outputs.nf
```

## Save outputs in a sub-directory

The same pattern can be used to store specific files in separate directories depending on the actual name. 

```groovy
process foo {
  publishDir 'results', saveAs: { filename -> filename.endsWith(".zip") ? "zips/$filename" : filename }

  output: 
  path '*'

  '''
  touch this.txt
  touch that.zip
  '''
}

workflow {
  foo()
}
```

!!! tip
    Relative paths are resolved against the `publishDir` store path. Use an absolute path to store files in a directory outside the `publishDir` store path. 

## Run it 

```bash
nextflow run nextflow-io/patterns/publish-rename-outputs-subdirs.nf
```
