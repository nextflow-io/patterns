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
 * - `from` creates a channel emitting two (or more) strings
 * - `map` transforms each string to a list of words
 * - `flatMap` will emits each entry in the list as a sole emission
 * - `map` will transform each word to a pair containing the word itself and its length  
 * - `subscribe` finally will print the result (note the argument expansion)
 */

Channel
    .from( "Hello world", "it's a beautiful day" )
    .map { it.tokenize() }
    .flatMap()
    .map { [ it, it.size() ] }
    .println { word, size -> "word '$word' contains $size characters" }
    