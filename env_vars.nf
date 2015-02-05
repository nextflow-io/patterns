#!/usr/bin/env nextflow

/*
 * Copyright (c) 2013-2014, Centre for Genomic Regulation (CRG).
 * Copyright (c) 2013-2014, Paolo Di Tommaso and the respective authors.
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
 * Environment variables can be accessed directly in the script context 
 */
 
println "Current home: $HOME"
println "Current user: $USER"
println "Current path: $PWD"

/* 
 * In the script are defined implicitly the following variables: 
 * - baseDir: path of the directly where the main script is defined
 * - workDir: path of nextflow scratch directory where intermediate 
 *            result files are stored 
 */ 
 
println "Script dir: $baseDir"
println "Working dir: $workDir"