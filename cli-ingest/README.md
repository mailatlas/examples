# CLI Ingest Example

This example ingests a synthetic `.eml` fixture, lists the stored document, and exports JSON, HTML,
and PDF artifacts.

## Run

```bash
./demo_cli.sh
```

By default, the script expects the sample data repository at `../sample-data`.
Each run writes to a new temporary directory. Pass a second argument to choose a new output path;
the script refuses to overwrite an existing path.

Override the fixture path directly:

```bash
./demo_cli.sh /path/to/atlas-inline-chart.eml
```

Choose the output path explicitly:

```bash
./demo_cli.sh /path/to/atlas-inline-chart.eml /tmp/mailatlas-cli-example-output
```

Or set the sample data directory:

```bash
export MAILATLAS_SAMPLE_DATA_DIR=/path/to/sample-data
./demo_cli.sh
```
