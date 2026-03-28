# OneTap Links

A quick-access bookmark manager app built with Flutter.

## Features

- **Add Links**: Save website URLs with custom short names using the FAB button
- **Display Links**: View all saved links in a clean grid layout
- **Open Links**: One-tap to open any saved URL in your browser
- **Edit Links**: Long-press or use menu to edit existing links
- **Delete Links**: Remove links with confirmation dialog
- **Clear All**: Option to delete all bookmarks at once
- **Persistent Storage**: Data persists between app restarts
- **Modern UI**: Material Design 3 with clean, minimal aesthetics

## Project Structure

```
lib/
├── main.dart                 # App entry point with navigation
├── models/
│   └── link_model.dart       # Link data model
├── providers/
│   └── link_provider.dart    # State management with Provider
├── screens/
│   ├── home_screen.dart      # Main links grid screen
│   └── settings_screen.dart # Settings and about screen
├── services/
│   └── storage_service.dart  # SharedPreferences storage
├── utils/
│   └── constants.dart        # Colors, strings, and constants
└── widgets/
    ├── add_link_dialog.dart  # Dialog for adding new links
    ├── delete_dialog.dart    # Confirmation dialog for deletion
    ├── edit_link_dialog.dart # Dialog for editing links
    └── link_card.dart        # Individual link card widget
```

## Dependencies

- `provider: ^6.1.1` - State management
- `url_launcher: ^6.2.4` - Open URLs in browser
- `shared_preferences: ^2.2.2` - Local data persistence
- `uuid: ^4.3.3` - Unique ID generation

## How to Run

### Prerequisites
- Flutter SDK (3.x or higher)
- Android SDK
- An Android device or emulator

### Steps

1. **Navigate to the project directory:**
   ```bash
   cd one_tap_links
   ```

2. **Get dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run the app (debug mode):**
   ```bash
   flutter run
   ```

4. **Build release APK:**
   ```bash
   flutter build apk --release
   ```

5. **Build debug APK:**
   ```bash
   flutter build apk --debug
   ```

## Usage

### Adding a Link
1. Tap the **+** floating action button
2. Enter the website URL (e.g., `https://google.com`)
3. Enter a short name (e.g., "Google")
4. Tap **Save**

### Opening a Link
- Simply **tap** on any link card to open it in your browser

### Editing a Link
- **Long-press** on a link card, or
- Use the bottom sheet menu (appears on long-press) and select "Edit"

### Deleting a Link
- **Long-press** on a link card
- Select "Delete" from the menu
- Confirm the deletion

### Clearing All Bookmarks
1. Open the **Drawer** (hamburger menu)
2. Go to **Settings**
3. Tap **Clear All Bookmarks**
4. Confirm the action

## Architecture

The app follows **Clean Architecture** principles:

- **Models**: Data classes for type safety
- **Services**: Data persistence logic
- **Providers**: State management and business logic
- **Screens**: UI screens/pages
- **Widgets**: Reusable UI components

## Tech Stack

- **Framework**: Flutter 3.x
- **Language**: Dart
- **State Management**: Provider
- **Storage**: SharedPreferences
- **Architecture**: Clean Architecture with Provider
