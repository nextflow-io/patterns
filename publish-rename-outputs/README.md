# Rename process outputs 

## Problem 

You need to store the outputs of one or more processes into a 
directory directory giving to the files a name of your choice.

## Solution 

Use the [publishDir](https://www.nextflow.io/docs/latest/process.html#publishdir) directive
to define the directory where the outputs need to be stored. Moreover use the `saveAs` parameter 
to provide a custom rule to give to each file a name of your choice. 

# Code 