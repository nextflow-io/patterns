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

  params.reads = 'reads/*{1,2}.fq.gz'
  params.outdir = 'my-results'

  Channel.fromFilePairs(params.reads).set{ samples_ch }

  process foo {
  publishDir "$params.outdir/$sampleId",
  saveAs: {
  filename ->
  if (filename.indexOf("readCounts.txt") > 0) "read_counts/$filename"
  else if (filename.indexOf("outlook.txt") > 0) "outlook/$filename"
  else "fq/$filename"
  }

  input:
  set sampleId, file(samples) from samples_ch
  output:
  file '.txt', '.fq'

  script:
  """
  < ${samples[0]} zcat > sample1.fq
  < ${samples[1]} zcat > sample2.fq

  awk '{s++}END{print s/4}' sample1.fq > sample1_readCounts.txt
  awk '{s++}END{print s/4}' sample2.fq > sample2_readCounts.txt

  head -n 50 sample1.fq > sample1_outlook.txt
  head -n 50 sample2.fq > sample2_outlook.txt

  """
  }
