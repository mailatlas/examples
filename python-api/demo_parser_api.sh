#!/usr/bin/env bash

set -euo pipefail

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(cd -- "$script_dir/.." && pwd)"
sample_data_dir="${MAILATLAS_SAMPLE_DATA_DIR:-$ROOT/../sample-data}"
fixture="${1:-$sample_data_dir/fixtures/eml/atlas-inline-chart.eml}"
demo_root="${2:-}"
python_bin="${MAILATLAS_PYTHON:-}"

if [[ -z "$python_bin" && -x "$ROOT/.venv/bin/python" ]]; then
  python_bin="$ROOT/.venv/bin/python"
fi

if [[ -z "$python_bin" ]]; then
  python_bin="$(command -v python3 || true)"
fi

if [[ ! -x "$python_bin" ]]; then
  echo "Python executable not found. Set MAILATLAS_PYTHON or install Python 3." >&2
  exit 1
fi

if [[ ! -f "$fixture" ]]; then
  echo "Fixture not found: $fixture" >&2
  echo "Clone https://github.com/mailatlas/sample-data next to this repository or set MAILATLAS_SAMPLE_DATA_DIR." >&2
  exit 1
fi

if [[ -z "$demo_root" ]]; then
  demo_root="$(mktemp -d "${TMPDIR:-/tmp}/mailatlas-parser-demo.XXXXXX")"
elif [[ -e "$demo_root" ]]; then
  echo "Demo output path already exists; choose a new path: $demo_root" >&2
  exit 1
else
  mkdir -p "$demo_root"
fi

"$python_bin" -c '
import json
import sys
from pathlib import Path

from mailatlas import ParserConfig, parse_eml

fixture = Path(sys.argv[1])
demo_root = Path(sys.argv[2])
document = parse_eml(fixture, parser_config=ParserConfig())
output_path = demo_root / "parsed.json"
output_path.write_text(json.dumps(document.to_dict(), indent=2), encoding="utf-8")

summary = {
    "subject": document.subject,
    "sender_email": document.sender_email,
    "author": document.author,
    "asset_count": len(document.assets),
    "has_html": document.body_html is not None,
    "output_path": output_path.as_posix(),
}
print(json.dumps(summary, indent=2))
' "$fixture" "$demo_root"
