#!/usr/bin/env nextflow

process download {

output:
file 'pinus_rubisco.json' into dataFile
file 'log.txt' into logFile

"""
curl -L "http://www.uniprot.org/uniprot/?sort=score&desc=&compress=no&query=pinus%20sylvestris%20rubisco&fil=&format=json" >pinus_rubisco.json 2>log.txt
"""

}

process download_other {

output:
file 'bio_pathways.tab' into otherFile

"""
curl -L "http://downloads.yeastgenome.org/curation/literature/biochemical_pathways.tab" > bio_pathways.tab
"""

}



c = Channel.create()

dataFile.merge(logFile,otherFile) {d, l, o -> [d,l,o]}
.view {d, l, o -> "data,log,other\n$d,$l,$o\n" }
