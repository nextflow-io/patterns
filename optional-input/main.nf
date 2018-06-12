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
  
params.inputs = '../data/prots/*{1,2,3}.fa'
params.filter = 'NO_FILE'

prots_ch = Channel.fromPath(params.inputs)
opt_file = file(params.filter)

process foo {
  echo true   
  input:
  file seq from prots_ch
  file opt from opt_file 

  script:
  filter = opt.name != 'NO_FILE' ? "--filter $opt" : ''
  """
  echo your_commad --input $seq $filter
  """
}
