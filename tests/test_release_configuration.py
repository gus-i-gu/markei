from __future__ import annotations

import importlib
import sqlite3
import sys
import tempfile
import unittest
from unittest import mock
from pathlib import Path


class ReleaseConfigurationTests(unittest.TestCase):
    def test_spec_includes_schema_and_excludes_seed_and_transient_data(self):
        spec = Path("Markei.spec").read_text(encoding="utf-8")

        self.assertIn("app/database/schema.sql", spec)
        self.assertNotIn("app/database/seed.sql", spec)
        self.assertIn("upx=False", spec)
        self.assertIn("console=False", spec)
        self.assertIn("build/markei_version_info.txt", spec)
        self.assertNotIn("market.sqlite", spec)
        self.assertNotIn("sqlite-wal", spec)
        self.assertNotIn("sqlite-shm", spec)

    def test_installer_consumes_frozen_distribution_and_preserves_user_data(self):
        installer = Path("installer/Markei.iss").read_text(encoding="utf-8")

        self.assertIn('Source: "..\\dist\\Markei\\*"', installer)
        self.assertIn("PrivilegesRequired=lowest", installer)
        self.assertIn(
            "DefaultDirName={localappdata}\\Programs\\{#MyAppName}",
            installer,
        )
        self.assertIn("Name: \"{group}\\{#MyAppName}\"", installer)
        self.assertIn("Tasks: desktopicon", installer)
        self.assertIn("seed.sql", installer)
        self.assertIn("market.sqlite", installer)
        self.assertNotIn("RemoveFile", installer)
        self.assertNotIn("{localappdata}\\Markei", installer)

    def test_identity_versions_are_consistent(self):
        from app.core import config

        version_info = Path("build/markei_version_info.txt").read_text(
            encoding="utf-8"
        )
        installer = Path("installer/Markei.iss").read_text(encoding="utf-8")

        self.assertEqual(config.APP_NAME, "Markei")
        self.assertEqual(config.VERSION, "0.1.0")
        self.assertIn("StringStruct('ProductVersion', '0.1.0')", version_info)
        self.assertIn('#define MyAppVersion "0.1.0"', installer)
        self.assertIn('#define MyAppExeName "Markei.exe"', installer)

    def test_startup_diagnostics_write_to_local_app_data(self):
        with tempfile.TemporaryDirectory() as temp_dir:
            with mock.patch.dict("os.environ", {"LOCALAPPDATA": temp_dir}):
                from app.startup_diagnostics import write_startup_log

                try:
                    raise RuntimeError("diagnostic check")
                except RuntimeError as exc:
                    log_path = write_startup_log(exc)

                expected = Path(temp_dir) / "Markei" / "logs" / "startup.log"
                self.assertEqual(log_path, expected)
                content = log_path.read_text(encoding="utf-8")
                self.assertIn("exception_type: RuntimeError", content)
                self.assertIn("diagnostic check", content)
                self.assertIn("Traceback", content)

    def test_production_first_launch_without_seed_has_no_sample_rows(self):
        with tempfile.TemporaryDirectory() as temp_dir:
            temp_path = Path(temp_dir)
            resource_root = temp_path / "resource"
            database_dir = resource_root / "app" / "database"
            database_dir.mkdir(parents=True)
            database_dir.joinpath("schema.sql").write_text(
                Path("app/database/schema.sql").read_text(encoding="utf-8"),
                encoding="utf-8",
            )

            local_app_data = temp_path / "localappdata"

            with mock.patch.dict(
                "os.environ",
                {"LOCALAPPDATA": str(local_app_data)},
            ):
                previous_frozen = getattr(sys, "frozen", None)
                previous_meipass = getattr(sys, "_MEIPASS", None)
                sys.frozen = True
                sys._MEIPASS = str(resource_root)

                import app.core.database as database

                try:
                    database = importlib.reload(database)
                    connection = database.connect()
                    try:
                        counts = {
                            table: connection.execute(
                                f"SELECT COUNT(*) FROM {table}"
                            ).fetchone()[0]
                            for table in (
                                "categories",
                                "stores",
                                "products",
                                "purchases",
                            )
                        }
                        settings = connection.execute(
                            "SELECT key, value FROM settings ORDER BY key"
                        ).fetchall()
                        category = connection.execute(
                            "SELECT id, name FROM categories"
                        ).fetchone()
                        store = connection.execute(
                            "SELECT id, name FROM stores"
                        ).fetchone()
                    finally:
                        connection.close()

                    self.assertEqual(
                        counts,
                        {
                            "categories": 1,
                            "stores": 1,
                            "products": 0,
                            "purchases": 0,
                        },
                    )
                    self.assertTrue(settings)

                    self.assertEqual(tuple(category), ("F", "General"))
                    self.assertEqual(tuple(store), (1, "Default Store"))

                    connection = database.connect()
                    try:
                        connection.execute(
                            "UPDATE settings SET value = ? WHERE key = ?",
                            ("sunday", "history.week_boundary"),
                        )
                        connection.commit()
                        connection.close()

                        connection = database.connect()
                        value = connection.execute(
                            "SELECT value FROM settings WHERE key = ?",
                            ("history.week_boundary",),
                        ).fetchone()[0]
                    finally:
                        connection.close()

                    self.assertEqual(value, "sunday")
                finally:
                    if previous_frozen is None:
                        delattr(sys, "frozen")
                    else:
                        sys.frozen = previous_frozen

                    if previous_meipass is None:
                        delattr(sys, "_MEIPASS")
                    else:
                        sys._MEIPASS = previous_meipass

                    importlib.reload(database)


if __name__ == "__main__":
    unittest.main()
