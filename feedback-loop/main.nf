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
  * author Paolo Di Tommaso <paolo.ditommaso@gmail.com> 
  */

params.input = 'hello.txt'

condition = { it.readLines().size()>=3 }
feedback_ch = Channel.create()
input_ch = Channel.fromPath(params.input).mix( feedback_ch.until(condition) )

process foo {
    input: 
    file x from input_ch
    output: 
    file 'foo.txt' into foo_ch
    script:
    """
    cat $x > foo.txt 
    """
}

process bar {
    input:
    file x from foo_ch 
    output:
    file 'bar.txt' into feedback_ch
    file 'bar.txt' into result_ch
    script:
    """
    cat $x > bar.txt
    echo World >> bar.txt 
    """
}

result_ch.last().println { "Result:\n${it.text.indent(' ')}" }

