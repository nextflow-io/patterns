# Nextflow Patterns

A curated collections of Nextflow implementation patterns  

[![Build Status](https://travis-ci.org/nextflow-io/patterns.svg?branch=master)](https://travis-ci.org/nextflow-io/patterns)

## Basic patterns

* [Channel duplication](docs/channel-duplication.adoc)

### Scatter executions

* [Process per file path](docs/process-per-file-path.adoc)
* [Process per file chunk](docs/process-per-file-chunk.adoc)
* [Process per file pairs](docs/process-per-file-pairs.adoc)
* [Process per file range](docs/process-per-file-range.adoc)
* [Process per CSV record](docs/process-per-csv-record.adoc)
* [Process per file output](docs/process-per-file-output.adoc)

### Gather results

* [Process all outputs altogether](docs/process-collect.adoc)
* [Process outputs into groups](docs/process-into-groups.adoc)
* [Collect outputs into a file](docs/collect-into-file.adoc)

### Organize outputs

* [Store process outputs](docs/publish-process-outputs.adoc)
* [Store outputs matching a glob pattern](docs/publish-matching-glob.adoc)
* [Store outputs renaming files](docs/publish-rename-outputs.adoc)

## Other
* [Get process work directory](docs/process-get-workdir.adoc)
* [Ignore failing process](docs/ignore-failing-process.adoc)
* [Mock dependency](docs/mock-dependency.adoc)

## Advanced patterns
* [Conditional process resources](docs/conditional-resources.adoc)
* [Conditional process executions](docs/conditional-process.adoc)
* [Skip process execution](docs/skip-process-execution.adoc)
* [Feedback loop](docs/feedback-loop.adoc)
* [Optional input](docs/optional-input.adoc)
* [Optional output](docs/optional-output.adoc)
* [Process when empty](docs/process-when-empty.adoc)
