#!/usr/bin/env nextflow

/*
 * Copyright (c) 2018, Centre for Genomic Regulation (CRG).
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be included in all
 * copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

 /*
  * author Paolo Di Tommaso <paolo.ditommaso@gmail.com> 
  */

params.input = "$baseDir/data/hello.txt"

condition = { it.readLines().size()>3 }
feedback_ch = Channel.create()
input_ch = Channel.fromPath(params.input, checkIfExists:true).mix( feedback_ch.until(condition) )

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

