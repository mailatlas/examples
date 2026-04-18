# MailAtlas Examples

Runnable examples for the MailAtlas CLI, Python API, and application integrations.

- Core package: https://github.com/mailatlas/mailatlas
- Documentation: https://mailatlas.dev/docs
- Sample data: https://github.com/mailatlas/sample-data

## Setup

Install MailAtlas from PyPI:

```bash
python3.12 -m venv .venv
source .venv/bin/activate
python -m pip install --upgrade pip
python -m pip install mailatlas
```

Clone the sample data repository next to this repository:

```bash
git clone https://github.com/mailatlas/sample-data ../sample-data
```

If the sample data repository lives somewhere else, set:

```bash
export MAILATLAS_SAMPLE_DATA_DIR=/path/to/sample-data
```

## Examples

| Directory | Purpose |
| --- | --- |
| `cli-ingest/` | Ingest a synthetic `.eml` fixture and export JSON, HTML, and PDF artifacts. |
| `python-api/` | Parse a synthetic `.eml` fixture through the Python API. |
| `fastapi-demo/` | Minimal FastAPI wrapper around the MailAtlas parsing and storage API. |

## Local Package Override

To test examples against a local MailAtlas checkout, install the package from that checkout first:

```bash
python -m pip install -e /path/to/mailatlas
```

Then run the example normally.

The FastAPI demo also needs:

```bash
python -m pip install fastapi uvicorn python-dotenv
```
