# Flutter release packages

## Beta status and tentative release

Marc is an unfinished beta. Features are still under development, and
malfunctions may occur. High server load may cause slow responses, failed
sign-ins, or delayed or interrupted synchronization.

The official release is tentatively planned for around **October 21, 2026**.
This is an estimate, not a confirmed release date, and may change.

Build Android and Windows from `clients/markei_flutter`. The root Python build
and `installer/Markei.iss` belong to the legacy application.

## Configuration

Create an ignored `.markei_release_defines.json` in this client directory with
the following public application settings:

```json
{
  "MARKEI_AUTH0_DOMAIN": "your-tenant.auth0.com",
  "MARKEI_AUTH0_ANDROID_CLIENT_ID": "android-public-client-id",
  "MARKEI_AUTH0_WINDOWS_CLIENT_ID": "windows-public-client-id",
  "MARKEI_AUTH0_AUDIENCE": "https://your-api-audience",
  "MARKEI_HOSTED_HTTPS_ORIGIN": "https://your-api-host"
}
```

Do not put passwords, database URLs, client secrets or access tokens in Dart
defines. They are compiled into the app. The release script disables the
development Closure surface and passes the same Auth0 domain to Android Gradle.

Auth0 must allow `auth0flutter://callback` for the Windows native client and
`https://<domain>/android/com.gusigu.markei/callback` for Android. Validate the
Android app-link association using the release certificate fingerprint.

## Android signing

Use a durable private release keystore. `android/key.properties` and keystore
files are ignored by Git. The properties file contains:

```properties
storeFile=upload-keystore.jks
storePassword=YOUR_PRIVATE_PASSWORD
keyAlias=markei
keyPassword=YOUR_PRIVATE_PASSWORD
```

Paths are relative to `android/`, or use a forward-slash absolute path. Keep an
encrypted backup of the keystore and credentials: future APK updates need the
same signing key. Builds fail when release signing is missing.

From the repository root:

```powershell
.\scripts\build_flutter.ps1 -Target android `
  -DefinesPath .\clients\markei_flutter\.markei_release_defines.json `
  -AndroidSdkPath '<Android SDK path>' -FlutterCommand '<flutter.bat path>'
```

Output: `clients/markei_flutter/build/app/outputs/flutter-apk/app-release.apk`.
Verify its signing certificate with Android SDK `apksigner`, then install it on
a real phone. An existing debug-signed installation cannot be upgraded with a
different signing key; preserve its data before any replacement.

## Windows build and setup wizard

Requires a complete Visual Studio Desktop development with C++ workload,
Windows SDK, and vcpkg `cpprestsdk:x64-windows`.

```powershell
.\scripts\build_flutter.ps1 -Target windows `
  -DefinesPath .\clients\markei_flutter\.markei_release_defines.json `
  -VcpkgRoot '<vcpkg path>' -FlutterCommand '<flutter.bat path>'
.\scripts\build_flutter_installer.ps1 -ISCCPath '<Inno Setup 6 ISCC.exe path>'
```

The installer uses the version and build number from `pubspec.yaml`, requires a
matching Windows executable, packages the complete Flutter bundle plus the x64
Visual C++ runtime DLLs, and writes a SHA-256 checksum beside the setup file.
If Visual Studio is installed elsewhere, pass `-VCRuntimeDirectory` pointing to
its `VC/Redist/MSVC/<version>/x64/Microsoft.VC143.CRT` folder.

Setup installs per user, registers the browser login callback, and offers a
desktop shortcut and launch action. Its stable Flutter AppId and install folder
are separate from the legacy Python version. Uninstall removes the callback
only if it still points to this installation. App-private user data is retained.

## Acceptance before distribution

- Fresh Windows installation launches without development tools.
- Browser sign-in returns to Markei on both platforms.
- Device enrollment and sync work after restart, with the intended account.
- Purchases synchronize between Windows and a real Android device.
- A second account cannot read the first account's data.
- Windows upgrade and uninstall behave correctly; user data is preserved.

Installer compilation alone does not establish these runtime checks. The
Windows setup executable also needs a publisher signature for a signed release.

## Google Play beta bundle

Use the same release configuration and existing private keystore to produce an
Android App Bundle. The default Android output remains an APK for direct installs.

```powershell
.\scripts\build_flutter.ps1 -Target android -AndroidFormat appbundle `
  -DefinesPath .\clients\markei_flutter\.markei_release_defines.json `
  -AndroidSdkPath '<Android SDK path>' -FlutterCommand '<flutter.bat path>'
```

Output: `clients/markei_flutter/build/app/outputs/bundle/release/app-release.aab`.
Upload the AAB to a Google Play internal testing release first; it is not directly
installable. Keep `com.gusigu.markei`. Each subsequent uploaded version must use
a new, higher build number. Never upload key.properties or the private keystore
as a release asset.

Play App Signing controls the certificate on the APKs testers install. If it
differs from the direct-install certificate, add its public SHA-256 fingerprint
to Auth0's Android device settings alongside the existing fingerprint. Verify
sign-in and browser return on the Play-installed app before inviting beta users.
The AAB upload signature alone does not prove the installed app's association.

Internal testing does not establish production readiness. Complete initial
account/membership provisioning, device enrollment, restart, cross-device sync,
account isolation, privacy/deletion review and applicable Play Console checks
before broader beta distribution. Successful compilation is not a security audit.
