#!/usr/bin/env bash

set -euo pipefail

script_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(cd -- "$script_dir/.." && pwd)"
cli_bin="${MAILATLAS_CLI:-}"

if [[ -z "$cli_bin" && -x "$ROOT/.venv/bin/mailatlas" ]]; then
  cli_bin="$ROOT/.venv/bin/mailatlas"
fi

if [[ -z "$cli_bin" ]]; then
  cli_bin="$(command -v mailatlas || true)"
fi

if [[ ! -x "$cli_bin" ]]; then
  echo "mailatlas CLI not found. Set MAILATLAS_CLI or install the package first." >&2
  exit 1
fi

email="${MAILATLAS_GMAIL_EMAIL:-}"
client_id="${MAILATLAS_GMAIL_CLIENT_ID:-}"
client_secret="${MAILATLAS_GMAIL_CLIENT_SECRET:-}"
to_email="${MAILATLAS_GMAIL_TO:-$email}"
subject="${MAILATLAS_GMAIL_SUBJECT:-MailAtlas Gmail OAuth example}"
body="${MAILATLAS_GMAIL_TEXT:-Sent by the MailAtlas Gmail OAuth example.}"
demo_root="${MAILATLAS_GMAIL_DEMO_ROOT:-/tmp/mailatlas-gmail-oauth-demo}"
token_file="${MAILATLAS_GMAIL_TOKEN_FILE:-$demo_root/gmail-token.json}"
idempotency_key="${MAILATLAS_GMAIL_IDEMPOTENCY_KEY:-gmail-oauth-send-demo}"

if [[ -z "$email" ]]; then
  echo "Set MAILATLAS_GMAIL_EMAIL to the Gmail address you want to send from." >&2
  exit 1
fi

if [[ -z "$client_id" ]]; then
  echo "Set MAILATLAS_GMAIL_CLIENT_ID to your Google OAuth desktop client id." >&2
  exit 1
fi

mkdir -p "$demo_root"

if [[ ! -s "$token_file" ]]; then
  auth_args=(
    auth gmail
    --client-id "$client_id"
    --email "$email"
    --token-file "$token_file"
  )

  if [[ -n "$client_secret" ]]; then
    auth_args+=(--client-secret "$client_secret")
  fi

  "$cli_bin" "${auth_args[@]}"
fi

"$cli_bin" auth status gmail \
  --token-file "$token_file"

"$cli_bin" send \
  --root "$demo_root/.mailatlas" \
  --provider gmail \
  --gmail-token-file "$token_file" \
  --from "$email" \
  --to "$to_email" \
  --subject "$subject" \
  --text "$body" \
  --idempotency-key "$idempotency_key"
