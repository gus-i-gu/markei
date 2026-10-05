# Marc languages

English, Brazilian Portuguese and Spanish are application presentation locales.
Settings stores the choice in the application support directory on this device;
`Device language` follows the OS and falls back to English for unsupported languages.
The preference is independent of Account membership and Sync. Changing language
does not recreate the app's page state or rewrite drafts, names, IDs or queued events.

Edit `strings_en.arb`, `strings_pt_BR.arb` and `strings_es.arb` for human review.
Keep the same keys and numbered placeholders in all files. From the client
directory run `dart run tool/generate_localizations.dart`, then `flutter analyze`
and `flutter test --concurrency=1`. The generator checks key and placeholder parity.

`MarcText` is for application-owned copy. Use plain `Text` for user names, product
labels, stores, emails, notes and identifiers. For mixed copy use
`context.message('Welcome, {p0}', [name])` to preserve the parameter verbatim.
`MarcMessages.display` supports the existing bounded English application status
templates; new dynamic copy should use explicit `message` arguments.

CSV column names and enum codes stay stable for machine use. PDF headings use
the selected language. Auth0-hosted pages are controlled by the authentication
provider, not by the app's local preference. Human wording review and physical
Android/Windows review remain required before the first official update.
