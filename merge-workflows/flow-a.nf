#!/usr/bin/env nextflow

// open communication channal
params.communication = "$baseDir/comm-a.json"
commFile=file(params.communication)


// download some file ad collect some log data from curl
process download {

output:
file 'pinus_rubisco.json' into dataFile, testFile
file 'log.txt' into logFile

"""
curl -L "http://www.uniprot.org/uniprot/?sort=score&desc=&compress=no&query=pinus%20sylvestris%20rubisco&fil=&format=json" >pinus_rubisco.json 2>log.txt
"""

}

// download the other dataset
process download_other {

output:
file 'bio_pathways.tab' into otherFile

"""
curl -L "http://downloads.yeastgenome.org/curation/literature/biochemical_pathways.tab" > bio_pathways.tab
"""

}



// another working way
/* dataFile.merge(logFile,otherFile) {d, l, o -> [d,l,o]}
.view {d, l, o -> "data,log,other\n$d,$l,$o\n" } */


// import JSON converter
import groovy.json.JsonOutput

// build a map data structure with paths to collected files and save it as json 
dataFile.merge(logFile,otherFile) {d, l, o -> [data: d.toString() ,log: l.toString() ,other: o.toString()]}
.flatMap { it -> JsonOutput.toJson(it) } // collect JSON string
.subscribe { commFile.write(it)}         // which is saved in file
