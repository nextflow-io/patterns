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


params.query = "$baseDir/data/sample.fa"
params.db = "$baseDir/blast-db/pdb/tiny"

db_name = file(params.db).name
db_path = file(params.db).parent

query = file(params.query)

process blastSearch {
    input:
    file query
    file db_path

    output:
    file top_hits

    """
    blastp -db $db_path/$db_name -query $query -outfmt 6 > blast_result
    cat blast_result | head -n 10 | cut -f 2 > top_hits
    """
}


process extractTopHits {
    input:
    file top_hits
    file db_path

    output:
    file sequences

    """
    blastdbcmd -db $db_path/$db_name -entry_batch $top_hits > sequences
    """
}

sequences.subscribe {  println it.text }
