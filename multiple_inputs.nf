#!/usr/bin/env nextflow

/*
 * Copyright (c) 2013-2014, Centre for Genomic Regulation (CRG).
 * Copyright (c) 2013-2014, Paolo Di Tommaso and the respective authors.
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
 * 
 * 
 * Try to run this example by entering the following command line: 
 * 
 *   nextflow run --query data/prot_\*.fa
 * 
 * It will execute a blast search for each file that matches the 
 * the wildcard path matcher 
 * 
 */
 
/* 
 * Define the pipeline default parameters. 
 */  
params.query = "$baseDir/data/sample.fa"
params.chunkSize = 10
params.db = "$baseDir/blast-db/pdb/tiny"
params.out = 'blast_result.txt'

/* 
 * the path where the BLAST DB is located 
 */
 
db = file(params.db)

/* 
 * A channel emitting fasta chunks
 */

seq = Channel
        .fromPath(params.query)
        .splitFasta(by: params.chunkSize)


/*
 * Execute a BLAST job for each chunk for the provided sequences
 */

process blast {
    input:
    file 'seq.fa' from seq

    output:
    file 'out' into blast_result

    """
    blastp -db $db -query seq.fa -outfmt 6 > out
    """
}

/* 
 * Collect all the outputs produced by the `blast` process
 * executions to a single file, whose name is defined by  
 * the `params.out` parameters
 */
 
blast_result
  .collectFile(name: params.out)
  .subscribe {  
     println "Result saved to file: $it"
   }
