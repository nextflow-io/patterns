#!/usr/bin/env nextflow

/*
vim: syntax=groovy
-*- mode: groovy;-*-
 *
 * Copyright (c) 2013-2017, Centre for Genomic Regulation (CRG).
 * Copyright (c) 2013-2017, Paolo Di Tommaso and the respective authors.
 *
 *   This file is part of 'Nextflow'.
 *
 *   Nextflow is free software: you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation, either version 3 of the License, or
 *   (at your option) any later version.
 *
 *   Nextflow is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details.
 *
 *   You should have received a copy of the GNU General Public License
 *   along with Nextflow.  If not, see <http://www.gnu.org/licenses/>.
 */

/* 
 * Define the pipeline parameters
 */
 
params.chunkSize = 2 
params.query = "$baseDir/data/sample.fa"
params.db = "$baseDir/blast-db/pdb/tiny"
params.out = 'blast_result.txt'

db_name = file(params.db).name
db_path = file(params.db).parent

fasta = file(params.query)
seq = Channel.from(fasta).splitFasta(by: params.chunkSize)


/*
 * Execute a BLAST job for each chunk for the provided sequences
 */
 
process blast {
    input:
    file 'seq.fa' from seq
    file db_path

    output:
    file 'out' into blast_result

    """
    blastp -db $db_path/$db_name -query seq.fa -outfmt 6 > out
    """
}

process gather {
    publishDir 'results'

    input: 
    file 'hits_*' from blast_result.collect()
    
    output:
    file 'result.txt'
    
    """
    cat hits_* > result.txt
    """ 
}

