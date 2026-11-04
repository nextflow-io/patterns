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
  * author Mike Smoot <msmoot@syntheticgenomics.com> 
  */

params.flag = false

process foo {
  input:
  val x

  output:
  path 'x.txt'

  script:
  """
  echo $x > x.txt
  """
}

process bar {
  input:
  val(b)

  output:
  path 'x.txt'

  script:
  """
  echo $b > x.txt
  """
}

process omega {
  debug true
  input:
  path x

  script:
  """
  cat $x
  """
}

workflow {
  (foo_ch, bar_ch) = params.flag
    ? [ Channel.empty(), Channel.from(1,2,3) ]
    : [ Channel.from(4,5,6), Channel.empty() ]

  foo(foo_ch)
  bar(bar_ch)

  foo.out | mix(bar.out) | omega
}
