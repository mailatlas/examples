# Python API Parse Example

This example parses a synthetic `.eml` fixture through the MailAtlas Python API and writes a JSON
document snapshot to a temporary directory.

## Run

```bash
./demo_parser_api.sh
```

By default, the script expects the sample data repository at `../sample-data`.

Override the fixture path directly:

```bash
./demo_parser_api.sh /path/to/atlas-inline-chart.eml
```

Or set the sample data directory:

```bash
export MAILATLAS_SAMPLE_DATA_DIR=/path/to/sample-data
./demo_parser_api.sh
```
