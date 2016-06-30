#!/bin/bash

nextflow -q run flow-a.nf | nextflow -q run flow-b.nf
