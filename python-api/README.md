# Python API Parse Example

This example parses a synthetic `.eml` fixture through the MailAtlas Python API and writes a JSON
document snapshot to a temporary directory.

## Run

```bash
./demo_parser_api.sh
```

By default, the script expects the sample data repository at `../sample-data`.
Each run writes to a new temporary directory. Pass a second argument to choose a new output path;
the script refuses to overwrite an existing path.

Override the fixture path directly:

```bash
./demo_parser_api.sh /path/to/atlas-inline-chart.eml
```

Choose the output path explicitly:

```bash
./demo_parser_api.sh /path/to/atlas-inline-chart.eml /tmp/mailatlas-python-example-output
```

Or set the sample data directory:

```bash
export MAILATLAS_SAMPLE_DATA_DIR=/path/to/sample-data
./demo_parser_api.sh
```
