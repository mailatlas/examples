from __future__ import annotations

import os
import sys
import tempfile
import unittest
from pathlib import Path

DEMO_DIR = Path(__file__).resolve().parent
sys.path.insert(0, str(DEMO_DIR))

from app import IngestEmlRequest, api, document, documents, export, ingest_paths  # noqa: E402


class FastApiDemoTests(unittest.TestCase):
    def test_ingest_list_get_and_export(self) -> None:
        sample_data_dir = Path(os.environ["MAILATLAS_SAMPLE_DATA_DIR"])
        fixture = sample_data_dir / "fixtures" / "eml" / "atlas-inline-chart.eml"

        with tempfile.TemporaryDirectory() as temporary_directory:
            workspace = Path(temporary_directory) / ".mailatlas"
            db_path = str(workspace / "store.db")
            workspace_path = str(workspace)
            payload = IngestEmlRequest(
                db_path=db_path,
                workspace_path=workspace_path,
                paths=[str(fixture)],
            )

            routes = {route.path for route in api.routes}
            self.assertTrue(
                {"/documents", "/documents/{document_id}", "/documents/{document_id}/export", "/ingest/eml"}
                <= routes
            )

            ingested = ingest_paths(payload)
            document_id = ingested[0]["id"]

            listed = documents(db_path=db_path, workspace_path=workspace_path)
            self.assertEqual(listed[0]["id"], document_id)

            stored = document(document_id, db_path=db_path, workspace_path=workspace_path)
            self.assertEqual(stored["id"], document_id)

            exported = export(document_id, format="json", db_path=db_path, workspace_path=workspace_path)
            self.assertIn(document_id, exported["content"])


if __name__ == "__main__":
    unittest.main()
