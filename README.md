# Nextflow Patterns

A curated collection of Nextflow implementation patterns  

![Build Status](https://github.com/nextflow-io/patterns/actions/workflows/test.yml/badge.svg)

## Basic patterns

* [Channel duplication](docs/channel-duplication.md)

## Scatter executions

* [Process per file path](docs/process-per-file-path.md)
* [Process per file chunk](docs/process-per-file-chunk.md)
* [Process per file pairs](docs/process-per-file-pairs.md)
* [Process per file range](docs/process-per-file-range.md)
* [Process per CSV record](docs/process-per-csv-record.md)
* [Process per file output](docs/process-per-file-output.md)

## Gather results

* [Process all outputs altogether](docs/process-collect.md)
* [Process outputs into groups](docs/process-into-groups.md)
* [Collect outputs into a file](docs/collect-into-file.md)

## Organize outputs

* [Store process outputs](docs/publish-process-outputs.md)
* [Store outputs matching a glob pattern](docs/publish-matching-glob.md)
* [Store outputs renaming files](docs/publish-rename-outputs.md)

## Other

* [Get process work directory](docs/process-get-workdir.md)
* [Ignore failing process](docs/ignore-failing-process.md)
* [State dependency](docs/state-dependency.md)

## Advanced patterns

* [Conditional process resources](docs/conditional-resources.md)
* [Conditional process executions](docs/conditional-process.md)
* [Skip process execution](docs/skip-process-execution.md)
* [Feedback loop](docs/feedback-loop.md)
* [Optional input](docs/optional-input.md)
* [Optional output](docs/optional-output.md)
* [Process when empty](docs/process-when-empty.md)
