# CLI Ingest Example

This example ingests a synthetic `.eml` fixture, lists the stored document, and exports JSON, HTML,
and PDF artifacts.

## Run

```bash
./demo_cli.sh
```

By default, the script expects the sample data repository at `../sample-data`.

Override the fixture path directly:

```bash
./demo_cli.sh /path/to/atlas-inline-chart.eml
```

Or set the sample data directory:

```bash
export MAILATLAS_SAMPLE_DATA_DIR=/path/to/sample-data
./demo_cli.sh
```
