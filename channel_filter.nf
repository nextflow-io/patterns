#!/usr/bin/env nextflow

/*
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
 * This example shows how concatenate operators
 * 
 * - `fromPath` creates a channel emitting the files matching 
 *   the path matcher specified with `params.in`
 * - `splitFasta` parse them as FASTA files a creates a record 
 *   for each sequence
 * - `filter` excludes all the ones whose ID does not match the `ENSP0` prefix 
 * - `count` return the number of sequences matching the filter 
 * - `subscribe` will print the count value      
 */


Channel
     .fromPath("$baseDir/data/Homo.prot.250.fa")
     .splitFasta( record: [id: true, seqString: true ])
     .filter { record ->  record.id =~ /^ENSP0.*/ }
     .count()
     .println()
