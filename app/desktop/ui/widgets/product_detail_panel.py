"""
Read-only Product View detail panel.
"""

from PySide6.QtWidgets import (
    QGroupBox,
    QHeaderView,
    QLabel,
    QTableWidget,
    QTableWidgetItem,
    QVBoxLayout,
)


PLACEHOLDER = "-"


class ProductDetailPanel(QGroupBox):
    """
    Render the Product View read model prepared by ProductService.
    """

    def __init__(self):
        super().__init__("Product View")

        self.identity_label = QLabel(PLACEHOLDER)
        self.summary_label = QLabel(PLACEHOLDER)

        self.stores_table = QTableWidget()
        self.stores_table.setColumnCount(5)
        self.stores_table.setHorizontalHeaderLabels(
            [
                "Store",
                "Store ID",
                "Address",
                "Latest Price",
                "Latest Purchase",
            ]
        )
        self.configure_table(self.stores_table)

        self.purchases_table = QTableWidget()
        self.purchases_table.setColumnCount(4)
        self.purchases_table.setHorizontalHeaderLabels(
            [
                "Purchase Date",
                "Price",
                "Quantity",
                "Expiration Date",
            ]
        )
        self.configure_table(self.purchases_table)

        layout = QVBoxLayout(self)
        layout.addWidget(self.identity_label)
        layout.addWidget(self.summary_label)
        layout.addWidget(QLabel("Stores"))
        layout.addWidget(self.stores_table)
        layout.addWidget(QLabel("Last Purchases"))
        layout.addWidget(self.purchases_table)

        self.clear()

    def configure_table(self, table: QTableWidget) -> None:
        table.horizontalHeader().setSectionResizeMode(QHeaderView.Stretch)
        table.setAlternatingRowColors(True)
        table.setEditTriggers(QTableWidget.NoEditTriggers)
        table.setSelectionBehavior(QTableWidget.SelectRows)

    def clear(self) -> None:
        self.identity_label.setText(PLACEHOLDER)
        self.summary_label.setText(PLACEHOLDER)
        self.stores_table.setRowCount(0)
        self.purchases_table.setRowCount(0)

    def load(self, data: dict | None) -> None:
        if not data:
            self.clear()
            return

        self.identity_label.setText(
            f"{self.value(data.get('product_name'))}, "
            f"{self.value(data.get('brand'))}, "
            f"{self.value(data.get('product_id'))}"
        )
        self.summary_label.setText(
            "Average Price: "
            f"{self.format_money(data.get('average_price'))} | "
            "Average Shelf-Life: "
            f"{self.format_days(data.get('average_shelf_life_days'))} | "
            "Expected Expiration: "
            f"{self.value(data.get('expected_expiration_date'))}"
        )

        self.load_stores(data.get("stores", []))
        self.load_purchases(data.get("last_purchases", []))

    def load_stores(self, rows: list[dict]) -> None:
        self.stores_table.setRowCount(0)

        for row_data in rows:
            row = self.stores_table.rowCount()
            self.stores_table.insertRow(row)
            values = [
                self.value(row_data.get("store_name")),
                self.value(row_data.get("store_id")),
                self.value(row_data.get("store_address")),
                self.format_money(row_data.get("latest_unit_price")),
                self.value(row_data.get("latest_purchase_date")),
            ]
            self.set_row(self.stores_table, row, values)

    def load_purchases(self, rows: list[dict]) -> None:
        self.purchases_table.setRowCount(0)

        for row_data in rows:
            row = self.purchases_table.rowCount()
            self.purchases_table.insertRow(row)
            quantity = (
                f"{self.value(row_data.get('quantity'))} "
                f"{self.value(row_data.get('unit'))}"
            )
            values = [
                self.value(row_data.get("purchase_date")),
                self.format_money(row_data.get("unit_price")),
                quantity,
                self.value(row_data.get("expiration_date")),
            ]
            self.set_row(self.purchases_table, row, values)

    def set_row(
        self,
        table: QTableWidget,
        row: int,
        values: list[str],
    ) -> None:
        for column, value in enumerate(values):
            table.setItem(row, column, QTableWidgetItem(value))

    def value(self, value) -> str:
        if value is None or value == "":
            return PLACEHOLDER

        return str(value)

    def format_money(self, value) -> str:
        if value is None:
            return PLACEHOLDER

        return f"$ {value:.2f}"

    def format_days(self, value) -> str:
        if value is None:
            return PLACEHOLDER

        if value == 1:
            return "1 day"

        return f"{value} days"
