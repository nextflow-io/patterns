# Rename process outputs 

## Problem 

You need to store the outputs of a process to a directory 
giving files a name of your choice.

## Solution 

The [publishDir](https://www.nextflow.io/docs/latest/process.html#publishdir) 
allows you to store the process outputs in a directory of your choice. 

Specify the `saveAs` parameter to give each file a name of your choice proving 
a custom rule as a [closure](https://www.nextflow.io/docs/latest/script.html#closures). 

## Code 

```nextflow 

process foo {
 publishDir 'results', saveAs: { filename -> "foo_$filename" }

 output: 
 file '*.txt'

 '''
 touch this.txt
 touch that.txt
 '''
}
```


## Save outputs in a sub-directory

The same pattern can be used to store specific files in separate directories 
depending the actual name. 


```nextflow 

process foo {
 publishDir 'results', saveAs: { filename -> filename.endsWith(".zip") ? "zips/$filename" : filename }

 output: 
 file '*'

 '''
 touch this.txt
 touch that.zip
 '''
}
```


Note: relative paths are resolved against the `publishDir` store path. Use an absolute path 
to store files in a directory outside the `publishDir` store path. 
