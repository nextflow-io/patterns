# Nextflow Patterns

A curated collections of Nextflow implementation patterns  

[![Build Status](https://travis-ci.org/nextflow-io/patterns.svg?branch=master)](https://travis-ci.org/nextflow-io/patterns)

## Basic patterns

* [Channel duplication](channel-duplication)

### Scatter executions

* [Process per file path](process-per-file-path)
* [Process per file chunk](process-per-file-chunk)
* [Process per file pairs](process-per-file-pairs)
* [Process per CSV record](process-per-csv-record)
* [Process per file output](process-per-file-output)

### Gather results

* [Process all outputs altogether](process-collect)
* [Process outputs into groups](process-into-groups)
* [Collect outputs into a file](collect-into-file)

### Organize outputs

* [Store process outputs](publish-process-outputs)
* [Store outputs matching a glob pattern](publish-matching-glob)

## Other
* [Get process work directory](process-get-workdir)
* [Ignore failing process](ignore-failing-process)


## Advanced patterns
* [Conditional process executions](conditional-process)
* [Skip process execution](skip-process-execution)
* [Feedback loop](feedback-loop)
* [Optional input](optional-input)
* [Optional output](optional-output)
* [Process when empty](process-when-empty)
