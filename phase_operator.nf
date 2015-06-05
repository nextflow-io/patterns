#!/usr/bin/env nextflow

/*
 * Copyright (c) 2013-2015, Centre for Genomic Regulation (CRG).
 * Copyright (c) 2013-2015, Paolo Di Tommaso and the respective authors.
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
 * This example shows how join to channels
 * 
 * It creates two channels that emits a pairs. The first entry in the pair 
 * represent the language identifier and the second a word in that 
 * language. 
 * 
 * Then, the phase operator synchronise the emission of the channel creating a new pair 
 * containing the words having the same lang identifier (the first element) 
 */
 
foo = Channel.from( tuple('sv', 'värld'), tuple('es', 'mundo'), tuple('en', 'world') )
bar = Channel.from( tuple('en', 'Hello'), tuple('es', 'Hola'), tuple('sv', 'Hallå') )


bar.phase(foo)
   .subscribe { first, second -> 
                  println "lang: ${first[0]} -> ${first[1]} ${second[1]}" 
              }