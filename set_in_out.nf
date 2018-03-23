#!/usr/bin/env nextflow

/*
 *
 * Copyright (c) 2013-2018, Centre for Genomic Regulation (CRG).
 * Copyright (c) 2013-2018, Paolo Di Tommaso and the respective authors.
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
 * This example shows how multiple values can be emitted over the same 
 * channel by using the `set` qualifer   
 */ 
 
 
/* 
 * defines the scripts parameters that can be overriden on the command line 
 */ 
 
params.in = "$baseDir/data/sample.fa"
params.db = "$baseDir/blast-db/pdb/tiny"


/* 
 * defines the path to the blast db  
 */ 
db_name = file(params.db).name
db_path = file(params.db).parent

/* 
 * creates a channel emitting pair of values, the first entry is the 
 * fasta sequence ID, and the second the sequence string
 */
 
Channel
     .fromPath(params.in)
     .splitFasta( record: [id: true, seqString: true ])
     .set { seq }
     
/*
 * Executes a blast search for each sequence. The process outputs 
 * a pair containing the sequence ID, and the Blast result file 
 */  
    
process blast {
    tag "seq: $id"  

    input:
    set id, file('seq.fa') from seq
    file db_path 
    
    output:
    set id, file('out.txt') into blast_result

    """
    blastp -db $db_path/$db_name -query seq.fa -outfmt 6 | head -n 10 > out.txt
    """
}     

/* 
 * For each emitted result print the sequence ID and the Blast query result.
 * 
 * Note: since the `blast_result` channel emits an *pair* object, the single 
 * entries can be expanded on the invocation of the `subscribe` operator.
 */
 
blast_result.println { id, result -> 
    
    "Blast result for query >> $id\n${result.text}"
    
}