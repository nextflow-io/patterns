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

params.query = "$baseDir/data/sample.fa"
params.db = "$baseDir/blast-db/pdb/tiny"

proteins = file(params.query)
db_name = file(params.db).name
db_path = file(params.db).parent

/*
 * Executes a Blast search with using the `protein` file.
 * The output is sent over the `result` channel 
 */

process blastJob {

  input:
  file 'query.fa' from proteins
  file db_path

  output: 
  file 'out.txt' into blast_result

   """ 
   blastp -query query.fa -db $db_path/$db_name -outfmt 6 > out.txt
   """

}

/* 
 * The `subscribe` operator is triggered when the `blast_result`
 * emits the output produced by the above process, printing 
 * the blast result
 */
blast_result.println { it.text }

