# College Hub

Flutter frontend prototype for the college study app. The project is cross-platform from the start and keeps the same Arabic RTL UI/UX across Android and iOS using Flutter's shared Material 3 widgets. No Android-only Flutter packages or platform APIs are used.

## Current scope

- Home dashboard
- Subjects
- Subject details
- Exams
- Exam details
- More/settings
- News and tasks cards
- Search UI
- Smooth page transitions
- Arabic RTL UI with English course/file names where useful
- Mock data only
- Shared app artwork in `assets/app_icon.png`
- Native Android and iOS app icons generated from the supplied artwork

## Platforms

The repository includes both `android/` and `ios/` platform folders. The shared Dart code uses Flutter Material APIs that run on both platforms without Android-specific dependencies. Platform-native launch and icon assets are kept in their respective folders.

## Run locally

1. Install Flutter 3.35.6 or a compatible stable release.
2. Open this folder in Android Studio or VS Code.
3. Run `flutter pub get`.
4. Run `flutter run` on an Android or iOS device/simulator.

## CI builds

The workflow at `.github/workflows/build-apk.yml` builds both artifacts on every push to `main` and can also be started manually from GitHub Actions:

- `college-hub-apk`: Android release APK.
- `college-hub-ios-archive`: unsigned iOS `Runner.xcarchive` built on `macos-latest` with `--no-codesign`. Apple signing and provisioning are intentionally left for a deployment environment with the required Apple credentials.

No backend is connected yet. Supabase, storage, notifications, and the Telegram admin bot can be added after the UI is approved.
