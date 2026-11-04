#!/usr/bin/env nextflow

/*
 * Copyright (c) 2022, Seqera Labs.
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
  * author Marcel Ribeiro-Dantas <mribeirodantas@seqera.io>
  */

Channel
  .of('demux.Clontech_5p--bc1003_3p.flnc_clustered.sorted.sam',
      'demux.Clontech_5p--bc1001_3p.flnc_clustered.sorted.sam',
      'demux.Clontech_5p--bc1002_3p.flnc_clustered.sorted.sam')
  .set { ch_alignment }

Channel
  .of('demux.Clontech_5p--bc1001_3p.flnc_clustered.fasta',
      'demux.Clontech_5p--bc1002_3p.flnc_clustered.fasta',
      'demux.Clontech_5p--bc1003_3p.flnc_clustered.fasta')
  .set { ch_clustered }

ch_alignment
  .map { [it.toString().split("--")[1].split("_3p")[0],
          it] }.
  set { ch_alignment }
ch_clustered
  .map { [it.toString().split("--")[1].split("_3p")[0],
          it] }.
  set { ch_clustered }

ch_alignment
  .combine(ch_clustered, by: 0)
  .map { id, sam, fasta -> [sam, fasta] }
  .view()