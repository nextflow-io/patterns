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

params.db = "$baseDir/blast-db/pdb/tiny"
params.query = "$baseDir/data/sample.fa"
params.chunk = 1 

db_name = file(params.db).name
db_path = file(params.db).parent

 Channel
        .fromPath(params.query)
        .splitFasta(by: params.chunk)
        .set { chunks }

/* 
 * Extends a BLAST query for each entry in the 'chunks' channel 
 */
process blast {
    input:
    file 'query.fa' from chunks
    file db_path

    output:
    file top_hits

    """
    blastp -db $db_path/$db_name -query query.fa -outfmt 6 > blast_result
    cat blast_result | head -n 10 | cut -f 2 > top_hits
    """
}

/*
 * Find out the top 10 matches returned by the BLAST query
 */ 
process extract {
    input:
    file top_hits
    file db_path

    output:
    file sequences

    """
    blastdbcmd -db $db_path/$db_name -entry_batch top_hits | head -n 10 > sequences
    """
}

/*
 * Collect all hits to a single file called  'all_seq'
 */ 
all_seq = sequences.collectFile(name:'all_seq')

/*
 * Aligns a T-Coffee MSA and print it 
 */
process align {
    echo true
    cache 'deep'

    input:
    file all_seq

    """
    t_coffee $all_seq 2>/dev/null | tee align_result
    """
}

