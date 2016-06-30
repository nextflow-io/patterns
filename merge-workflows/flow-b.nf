#!/usr/bin/env nextflow

inch = Channel.from(System.in.text)
       .splitCsv(header: true)


process princh  {
echo true

input:
val e from inch

"""
printf "I can process data: $e.data\n"
printf "I can process log: $e.log\n"
printf "I can process other: $e.other\n"
"""

}
