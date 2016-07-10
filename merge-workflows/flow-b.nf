#!/usr/bin/env nextflow

// open communication file
params.communication = "$baseDir/comm-a.json"
commFile = file(params.communication)

// import groovy class 
import groovy.json.JsonSlurper

// instantiate the class
def jsonSlurper = new JsonSlurper()

// another working way
/*
inch = Channel.from(commFile.toFile())
       .map { jsonSlurper.parse(it) }
*/


// create an input channel (inch) from deserialised data structure
inch = Channel.from(jsonSlurper.parse(commFile.toFile()))

// strange name means print inch :-D 
process princh  {
echo true

input:
val e from inch

// proof it works
"""
printf "I can process data: $e.data\n"
printf "I can process log: $e.log\n"
printf "I can process other: $e.other\n"
"""

}

