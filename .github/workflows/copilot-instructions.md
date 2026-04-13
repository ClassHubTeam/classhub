# ClassHub - Copilot Instructions

## Project
Flutter mobile app for ISIMM university students. GitHub meets Google Classroom concept.
Students can organize course materials locally with a professional file-management workspace.

## Stack
- Flutter + Dart (SDK ^3.11.0)
- Material Design 3 with `dynamic_color` (device-adaptive color schemes, indigo fallback)
- `file_picker` for folder/file picking
- `permission_handler` for Android storage permission
- `shared_preferences` for persisting the root path
- `path` package for cross-platform path manipulation
- Debug banner disabled (`debugShowCheckedModeBanner: false`)

## File Structure
We enforce a strict separation of concerns across features:
- `models/`: Only data types (classes holding data, no logic).
- `services/`: Backend functions and business logic (no widgets). Separates frontend from backend.
- `screens/`: Frontend UI widgets.

lib/
├── main.dart
├── core/
│   └── services/
│       ├── classhub_path_service.dart
│       └── storage_permission_service.dart
├── file_explorer/
│   ├── models/
│   │   ├── file_type_info.dart
│   │   └── trash_item.dart
│   ├── screens/
│   │   ├── main_screen.dart
│   │   ├── search_screen.dart
│   │   ├── settings_screen.dart
│   │   ├── trash_screen.dart
│   │   ├── support_screen.dart
│   │   └── about_screen.dart
│   └── services/
│       ├── file_explorer_service.dart
│       ├── search_service.dart
│       └── trash_service.dart
├── onboarding/
│   ├── screens/
│   │   ├── landing_page.dart
│   │   └── onboarding_screen.dart
│   └── services/
│       └── onboarding_service.dart
└── share/
    ├── models/
    ├── screens/
    └── services/

## App Flow
1. **First launch:** `LandingPage` → (Get Started) → `OnboardingScreen` (folder selection) → `MainScreen`
2. **Returning user (path saved & permission granted):** `MainScreen` directly

`main.dart` checks `hasPermission && pathExists` to decide the entry point.
`OnboardingScreen.onComplete` passes the selected `rootPath` through to `MainScreen`.

## Screens Status
- **LandingPage** (`lib/onboarding/screens/landing_page.dart`): Hero page with branding, "Get Started" button, "View Documentation" scroll, feature cards (Local Repo Sync, Instant Indexing, Offline First, Privacy Guaranteed). Navigates to `OnboardingScreen`.
- **OnboardingScreen** (`lib/onboarding/screens/onboarding_screen.dart`): Folder picker with permission handling. Passes selected `rootPath` to `MainScreen` via `onComplete(String path)` callback.
- **MainScreen** (`lib/file_explorer/screens/main_screen.dart`): File explorer with drawer menu (Settings, Trash, Support, About). Expandable FAB (Folder, Upload, Source). Multi-select via long-press for bulk delete-to-trash. 3-dot menu per item (Rename, Copy Path). Contains nested `_InsideFolderScreen` for viewing folder contents with file upload, rename, and bulk trash.
- **SearchScreen** (`lib/file_explorer/screens/search_screen.dart`): Live search with filter chips (All / Folders / Files), recent searches persistence, result navigation back to main screen.
- **TrashScreen** (`lib/file_explorer/screens/trash_screen.dart`): Selection, restore, permanent delete, 30-day auto-purge with days-remaining badge. Trash dir safety checks to prevent `FileSystemException` on missing `.classhub_trash`.
- **SettingsScreen** (`lib/file_explorer/screens/settings_screen.dart`): Empty shell.
- **SupportScreen** (`lib/file_explorer/screens/support_screen.dart`): Empty shell.
- **AboutScreen** (`lib/file_explorer/screens/about_screen.dart`): Empty shell.

## Services
- **ClasshubPathService**: Read/write/clear the user-chosen root path via `SharedPreferences`.
- **StoragePermissionService**: Android `manageExternalStorage` permission check/request; auto-returns `true` on non-Android.
- **OnboardingService**: Loads saved path, opens folder picker, validates directory existence.
- **FileExplorerService**: List/sort entries, create folders, upload folders (rejects nested sub-folders), upload files, rename, count children, format size.
- **SearchService**: Recursive file/folder search with query filter, recent-searches CRUD stored in `.classhub_recent_searches.json`.
- **TrashService**: Move-to-trash with manifest (`.trash_manifest.json`), restore, permanent delete, 30-day auto-purge, size calculation. Guards against missing trash directory.

## Models
- **TrashItem**: `originalPath`, `trashPath`, `isDirectory`, `deletedAt`; JSON serialization; 30-day expiry logic.
- **FileTypeInfo**: Classifies files by extension into labeled icon types (PDF, Video, Spreadsheet, Archive, Markdown, Image, Presentation, Document, generic File, Folder).

## Design
- Dark blue-black background palette (`#090C14`) with light blue accents (`#80A3FF`)
- Card color `#111827`, drawer `#0F1420`
- Material Design 3 components
- Dynamic color via `dynamic_color` package (falls back to indigo seed)
- No custom font currently applied (uses system default via Material theme)

## Pending Tasks
- Implement Settings screen content (e.g., change root path, theme toggle).
- Implement Support screen content.
- Implement About screen content.
- Implement "Source" FAB action in MainScreen.
- Structure models and screens for `share` feature.
- Add Geist font asset files if desired (not currently bundled or referenced).
- Remove `// home: HomeScreen(),` leftover comment in main.dart.

## Copilot Instruction
After every change we make together, update this file to reflect the new state of the project.
Update screen statuses, pending tasks, and any new decisions made about design or implementation.