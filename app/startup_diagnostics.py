"""Startup diagnostics for failures before normal UI operation."""

from __future__ import annotations

import os
import sys
import traceback
from datetime import datetime
from pathlib import Path


def user_log_dir() -> Path:
    """Return the writable per-user Markei log directory."""

    local_app_data = os.environ.get("LOCALAPPDATA")

    if local_app_data:
        return Path(local_app_data) / "Markei" / "logs"

    return Path.home() / "AppData" / "Local" / "Markei" / "logs"


def startup_log_path() -> Path:
    """Return the startup diagnostic log path."""

    return user_log_dir() / "startup.log"


def write_startup_log(exc: BaseException) -> Path:
    """Write startup exception details and return the log path."""

    path = startup_log_path()
    path.parent.mkdir(parents=True, exist_ok=True)

    timestamp = datetime.now().isoformat(timespec="seconds")
    details = "".join(
        traceback.format_exception(type(exc), exc, exc.__traceback__)
    )

    path.write_text(
        "\n".join(
            (
                f"timestamp: {timestamp}",
                f"exception_type: {type(exc).__name__}",
                f"message: {exc}",
                "",
                details,
            )
        ),
        encoding="utf-8",
    )

    return path


def report_startup_exception(exc: BaseException) -> Path:
    """Persist startup diagnostics and show a concise user-visible error."""

    path = write_startup_log(exc)

    try:
        from PySide6.QtWidgets import QApplication, QMessageBox

        app = QApplication.instance() or QApplication(sys.argv[:1])
        QMessageBox.critical(
            None,
            "Markei startup error",
            f"Markei could not start. Details were written to:\n{path}",
        )
        app.quit()
    except Exception:
        print(
            f"Markei could not start. Details were written to: {path}",
            file=sys.stderr,
        )

    return path
