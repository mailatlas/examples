# Gmail OAuth Send Example

This example sends a test email from a personal Gmail address through the Gmail API provider. It
uses OAuth and the `gmail.send` scope instead of a Gmail SMTP app password.

The script stores the Gmail token in `/tmp/mailatlas-gmail-oauth-demo/gmail-token.json` by default
so the example does not write credentials into this repository.

## Setup

Install MailAtlas first:

```bash
python3.12 -m venv .venv
source .venv/bin/activate
python -m pip install --upgrade pip
python -m pip install mailatlas
```

To test against a local core checkout instead:

```bash
python -m pip install -e /path/to/mailatlas
```

## Get Google OAuth credentials

1. Create or select a Google Cloud project.
2. Enable the Gmail API.
3. Configure the OAuth consent screen. For personal testing, choose an external app and add your
   Gmail address as a test user while the app is in testing mode.
4. Create an OAuth client ID with application type **Desktop app**.
5. Copy the client ID and client secret.

Export the values:

```bash
export MAILATLAS_GMAIL_CLIENT_ID="your-client-id.apps.googleusercontent.com"
export MAILATLAS_GMAIL_CLIENT_SECRET="your-client-secret"
export MAILATLAS_GMAIL_EMAIL="yourname@gmail.com"
```

Some desktop OAuth clients may not require a client secret. If Google does not issue one, omit
`MAILATLAS_GMAIL_CLIENT_SECRET`.

## Run

```bash
./demo_gmail_oauth_send.sh
```

The script will:

1. create `/tmp/mailatlas-gmail-oauth-demo`
2. run `mailatlas auth gmail` if the example token file does not exist yet
3. open the Google consent page in your browser
4. send a Gmail API test message to `MAILATLAS_GMAIL_TO` or back to `MAILATLAS_GMAIL_EMAIL`
5. print the MailAtlas send result JSON

The default idempotency key is `gmail-oauth-send-demo`, so running the script again returns the same
outbound record instead of sending a duplicate. Set `MAILATLAS_GMAIL_IDEMPOTENCY_KEY` to a new
value when you intentionally want another live test send.

## Optional settings

```bash
export MAILATLAS_GMAIL_TO="recipient@example.com"
export MAILATLAS_GMAIL_SUBJECT="MailAtlas Gmail OAuth example"
export MAILATLAS_GMAIL_TEXT="Sent by the MailAtlas Gmail OAuth example."
export MAILATLAS_GMAIL_DEMO_ROOT="/tmp/mailatlas-gmail-oauth-demo"
export MAILATLAS_GMAIL_TOKEN_FILE="/tmp/mailatlas-gmail-oauth-demo/gmail-token.json"
export MAILATLAS_CLI="/path/to/mailatlas"
```

## Clean up

Remove the local token used by this example:

```bash
mailatlas auth logout gmail \
  --token-file /tmp/mailatlas-gmail-oauth-demo/gmail-token.json
```

You can also revoke the app's access from your Google Account security settings.

## Notes

- Do not commit OAuth client secrets, access tokens, refresh tokens, or token files.
- MailAtlas does not write Gmail tokens to `store.db`, raw snapshots, logs, or JSON send results.
- Gmail API sends currently do not support BCC in MailAtlas. Use SMTP or Cloudflare for BCC tests.
