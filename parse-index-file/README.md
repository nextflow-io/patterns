# Parse a CSV index table 

## Problem 

Workflow inputs are given by a CSV file, where each line represent one or more file to be processed along with some metadata. 

## Solution 

Read the CSV file line-by-line using the [sliptCsv](https://www.nextflow.io/docs/latest/operator.html#splitcsv) operator,
then use the [map](https://www.nextflow.io/docs/latest/operator.html#map) to return a tuple for each line 
holding the entry metadata along with the file object for each line in the given CSV.

## Code

Given the file `index.csv` with the following content: 

```
sampleId,read1,read2
FC816RLABXX,reads/110101_I315_FC816RLABXX_L1_HUMrutRGXDIAAPE_1.fq.gz,reads/110101_I315_FC816RLABXX_L1_HUMrutRGXDIAAPE_2.fq.gz
FC812MWABXX,reads/110105_I186_FC812MWABXX_L8_HUMrutRGVDIABPE_1.fq.gz,reads/110105_I186_FC812MWABXX_L8_HUMrutRGVDIABPE_2.fq.gz
FC81DE8ABXX,reads/110121_I288_FC81DE8ABXX_L3_HUMrutRGXDIAAPE_1.fq.gz,reads/110121_I288_FC81DE8ABXX_L3_HUMrutRGXDIAAPE_2.fq.gz
FC81DB5ABXX,reads/110122_I329_FC81DB5ABXX_L6_HUMrutRGVDIAAPE_1.fq.gz,reads/110122_I329_FC81DB5ABXX_L6_HUMrutRGVDIAAPE_2.fq.gz
FC819P0ABXX,reads/110128_I481_FC819P0ABXX_L5_HUMrutRGWDIAAPE_1.fq.gz,reads/110128_I481_FC819P0ABXX_L5_HUMrutRGWDIAAPE_2.fq.gz
```

This snippet parses the file and executes a process for each line:

```
params.index = 'index.csv'

Channel
    .fromPath(params.index)
    .splitCsv(header:true)
    .map{ row-> tuple(row.sampleId, file(row.read1), file(row.read2)) }
    .set { samples_ch }

process foo {
    input:
    set sampleId, file(read1), file(read2) from samples_ch

    script:
    """
    echo your_command --sample $sampleId --reads $read1 $read2
    """
}
```

Note: the relative paths are resolved by the `file` function against the launching directory. 
In a real use case prefer absolute file paths.

## Run it

Use the the following command to execute the example:

    nextflow run main.nf


