# FastAPI Demo

This is a small FastAPI wrapper around the MailAtlas parsing and storage API. It is intended for
local exploration, not production deployment.

## Setup

```bash
python3.12 -m venv .venv
source .venv/bin/activate
python -m pip install --upgrade pip
python -m pip install mailatlas fastapi uvicorn python-dotenv
```

## Run

```bash
uvicorn app:api --reload
```

The demo writes to `.mailatlas/` by default. Override `db_path` and `workspace_path` in request
payloads when you want a different local workspace.
