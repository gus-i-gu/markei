"""Project entry point for Markei."""

from app.main import main
from app.startup_diagnostics import report_startup_exception


if __name__ == "__main__":
    try:
        main()
    except Exception as exc:
        report_startup_exception(exc)
        raise SystemExit(1) from exc
