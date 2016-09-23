#!/usr/bin/env nextflow

/*
vim: syntax=groovy
-*- mode: groovy;-*-
 *
 * Copyright (c) 2013-2016, Centre for Genomic Regulation (CRG).
 * Copyright (c) 2013-2016, Paolo Di Tommaso and the respective authors.
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
 *   nextflow run multiple_inputs.nf --query data/prot_\*.fa
 * 
 * It will execute a blast search for each file that matches the 
 * the wildcard path matcher 
 * 
 */
 
/* 
 * Define the pipeline default parameters. 
 */  
params.query = "$baseDir/data/sample.fa"
params.db = "$baseDir/blast-db/pdb/tiny"
params.out = 'blast_result.txt'

/* 
 * the path where the BLAST DB is located 
 */
 
db_name = file(params.db).name
db_path = file(params.db).parent

/* 
 * A channel emitting the fasta files specified as parameter
 */
seq = Channel.fromPath(params.query)

/*
 * Execute a BLAST job for each chunk for the provided sequences
 */

process blast {
    tag { x.baseName }

    input:
    file x from seq
    file db_path

    output:
    file 'out' into blast_result

    """
    blastp -db $db_path/$db_name -query $x -outfmt 6 > out
    """
}

/* 
 * Collect all the outputs produced by the `blast` process
 * executions to a single file, whose name is defined by  
 * the `params.out` parameters
 */
 
blast_result
  .collectFile(name: file(params.out))
  .println { "Result saved to file: $it" }
