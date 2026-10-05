const listNotesTableSql = '''
CREATE TABLE list_note_revisions (
 account_id TEXT NOT NULL REFERENCES local_accounts(id),
 event_id TEXT NOT NULL,
 product_id TEXT NOT NULL,
 note TEXT NOT NULL,
 tags_json TEXT NOT NULL,
 replaces_json TEXT NOT NULL,
 PRIMARY KEY (account_id, event_id)
)
''';
