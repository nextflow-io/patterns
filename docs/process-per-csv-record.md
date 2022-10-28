## Problem 

You need to execute a task for each record in one or more CSV files.

## Solution 

Read the CSV file line-by-line using the [splitCsv](https://www.nextflow.io/docs/latest/operator.html#splitcsv) operator, then use the [map](https://www.nextflow.io/docs/latest/operator.html#map) operator to return a tuple with the required field for each line and convert any string path to a file path object using the `file` function. Finally, use the resulting channel as input for the process. 

## Code

Given the file `index.csv` with the following content: 

| sampleId    | read1                                                    | read2
| --------    | -----                                                    | ----- |
| FC816RLABXX | reads/110101_I315_FC816RLABXX_L1_HUMrutRGXDIAAPE_1.fq.gz | reads/110101_I315_FC816RLABXX_L1_HUMrutRGXDIAAPE_2.fq.gz |
| FC812MWABXX | reads/110105_I186_FC812MWABXX_L8_HUMrutRGVDIABPE_1.fq.gz | reads/110105_I186_FC812MWABXX_L8_HUMrutRGVDIABPE_2.fq.gz |
| FC81DE8ABXX | reads/110121_I288_FC81DE8ABXX_L3_HUMrutRGXDIAAPE_1.fq.gz | reads/110121_I288_FC81DE8ABXX_L3_HUMrutRGXDIAAPE_2.fq.gz |
| FC81DB5ABXX | reads/110122_I329_FC81DB5ABXX_L6_HUMrutRGVDIAAPE_1.fq.gz | reads/110122_I329_FC81DB5ABXX_L6_HUMrutRGVDIAAPE_2.fq.gz |
| FC819P0ABXX | reads/110128_I481_FC819P0ABXX_L5_HUMrutRGWDIAAPE_1.fq.gz | reads/110128_I481_FC819P0ABXX_L5_HUMrutRGWDIAAPE_2.fq.gz |

This workflow parses the file and executes a process for each line:

```groovy
params.index = "$baseDir/data/index.csv"

process foo {
    debug true
    input:
    tuple val(sampleId), file(read1), file(read2)

    script:
    """
    echo your_command --sample $sampleId --reads $read1 $read2
    """
}

workflow {
    Channel.fromPath(params.index) \
        | splitCsv(header:true) \
        | map { row-> tuple(row.sampleId, file(row.read1), file(row.read2)) } \
        | foo
}
```

!!! note
    Relative paths are resolved by the `file` function against the execution directory. In practice, it is preferable to use absolute file paths.

## Run it

Use the the following command to execute the example:

```bash
nextflow run nextflow-io/patterns/process-per-csv-record.nf
```
