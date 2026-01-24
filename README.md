 (cd "$(git rev-parse --show-toplevel)" && git apply --3way <<'EOF' 
diff --git a/README.md b/README.md
index 799e8bbc79300c71b4e4909ea1ee8a65b548b447..7b87cbc4ee1525a8044364000cfbb738b873fba6 100644
--- a/README.md
+++ b/README.md
@@ -1,16 +1,106 @@
-# jutc_smartride
+# JUTC SmartRide (Flutter)
 
-A new Flutter project.
+A production-ready Flutter implementation of the JUTC SmartRide web app, with Material 3 expressive motion, local-only storage, and the same screens/features as the HTML source.
 
-## Getting Started
+## Setup
 
-This project is a starting point for a Flutter application.
+```bash
+flutter pub get
+```
 
-A few resources to get you started if this is your first Flutter project:
+### Run (Android)
 
-- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
-- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)
+```bash
+flutter run
+```
+
+### Run (iOS)
+
+```bash
+cd ios
+pod install
+cd ..
+flutter run
+```
+
+## Architecture
+
+Feature-based layout with shared services:
+
+```
+lib/
+  data/                # Route data and constants
+  models/              # App models
+  screens/             # Screens (home, routes, track, saved, settings, onboarding)
+  services/            # Storage service
+  state/               # Riverpod state
+  theme/               # App theme
+  widgets/             # Shared widgets
+```
+
+State management: **Riverpod** (single system used throughout).
+
+## Local Storage
+
+All data is stored locally using **Hive**:
+
+- User name
+- Cards (masked display)
+- Settings (theme, style, motion, text size)
+- Saved routes
+
+Storage location: Hive box `jutc` in the device’s app data directory (see `StorageService`).
+
+## QR Scanning
+
+QR scanning uses **mobile_scanner** with a required rationale screen before permission request. The flow is:
+
+1. Rationale screen (explains camera usage)
+2. Permission request on user tap
+3. Scan QR code
+4. Confirmation dialog (“Is this your card number?”)
+5. Autofill card number or allow manual edit
+
+If permission is denied, the app explains why and offers “Open system settings.”
+
+## Map
+
+Map uses **flutter_map** with OpenStreetMap tiles and centers on Jamaica by default. Location access is requested only when the user taps “Use my location.” Demo bus marker uses a local timer for movement (no live feed required).
+
+## PDF Viewer
+
+Schedules open in-app with **pdfx** (pinch-to-zoom). If a PDF fails to load, the user is prompted to open it externally via the system browser or PDF app.
+
+## Feature Mapping (HTML → Flutter)
+
+- **Home** → `HomeScreen`: hero banner, quick actions, saved count
+- **Routes** → `RoutesScreen`: search + filters, route list, route detail sheet
+- **Track** → `TrackScreen`: map view, demo bus, quick schedule open
+- **Saved** → `SavedScreen`: saved routes list
+- **Settings** → `SettingsScreen`: appearance controls, card management
+- **Terms/Credits** → `TermsScreen`
+- **Onboarding** → `OnboardingScreen`: required first-launch setup flow
+
+## Key Dependencies
+
+- `flutter_riverpod`: app state management
+- `hive` + `hive_flutter`: local storage
+- `mobile_scanner`: QR scanning
+- `permission_handler`: permission gating
+- `flutter_map` + `latlong2`: map view
+- `geolocator`: device location
+- `pdfx`: PDF viewer
+- `url_launcher`: open external links
+- `animations`: Material 3 expressive transitions
+- `share_plus`: share schedule links
+
+## Platform Notes
+
+- Android permissions are defined in `AndroidManifest.xml` (camera + location).
+- iOS permission descriptions are in `Info.plist` (camera + location).
+
+## Build Requirements
+
+- Flutter stable (null-safety enabled)
+- Android supported; iOS is supported when CocoaPods is available
 
-For help getting started with Flutter development, view the
-[online documentation](https://docs.flutter.dev/), which offers tutorials,
-samples, guidance on mobile development, and a full API reference.
 
EOF
)
