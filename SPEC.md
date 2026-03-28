# OneTap Links - Specification Document

## 1. Project Overview

**Project Name:** OneTap Links  
**Project Type:** Flutter Android Application  
**Core Functionality:** A bookmark manager app that allows users to save website links as quick-access buttons, enabling one-tap access to frequently visited websites without browser searching.

---

## 2. Technology Stack & Choices

| Component | Choice |
|-----------|--------|
| Framework | Flutter 3.x |
| Language | Dart |
| State Management | Provider (lightweight, simple) |
| Local Storage | SharedPreferences (JSON serialization) |
| URL Launching | url_launcher package |
| Architecture | Clean Architecture (models, services, screens, widgets) |

### Dependencies (pubspec.yaml)
- `provider: ^6.1.1` - State management
- `url_launcher: ^6.2.4` - Open URLs in browser
- `shared_preferences: ^2.2.2` - Local data persistence
- `uuid: ^4.3.3` - Unique ID generation for links

---

## 3. Feature List

### Core Features
1. **Add Link** - FAB opens dialog with URL and short name inputs
2. **Display Links** - GridView of link cards with short names
3. **Open Link** - Tap button opens URL in external browser
4. **Edit Link** - Long press opens edit dialog
5. **Delete Link** - Confirmation dialog before deletion

### Navigation
6. **Bottom Navigation Bar** - Home tab and Settings/About tab
7. **App Drawer** - App name, About section, Clear all bookmarks option

### UI/UX Features
8. **Snackbar Feedback** - Confirmations for add/edit/delete actions
9. **Tap Animations** - Scale animation on button tap
10. **Stack Widget Usage** - Floating elements over content

### Data Management
11. **Persistent Storage** - Links survive app restart
12. **Clear All** - Option to delete all bookmarks at once

---

## 4. UI/UX Design Direction

### Visual Style
- **Design System:** Material Design 3
- **Theme:** Light theme with accent color (deep purple/teal)
- **Style:** Clean, modern, minimal with rounded corners

### Color Scheme
- Primary: Deep Purple (#673AB7)
- Secondary: Teal Accent (#64FFDA)
- Background: White/Light Grey
- Card Background: White with subtle shadows
- Text: Dark grey for readability

### Layout Approach
- **Home Screen:** Scaffold with AppBar, GridView body, FAB, Drawer, BottomNav
- **Grid Layout:** 2-column grid for link cards
- **Cards:** Rounded rectangles with icon, name, and subtle elevation
- **FAB:** Bottom-right positioned, primary color
- **Dialogs:** Rounded Material dialogs for add/edit/delete

### Components
- **Link Card:** Icon + Name, long-press for options
- **Input Dialog:** Two TextFields (URL, Name) + Save button
- **Delete Dialog:** Confirmation message + Yes/No buttons
- **Bottom Nav:** Home icon, Settings icon
- **Drawer:** Header with app name, menu items below

---

## 5. Folder Structure

```
lib/
├── main.dart
├── models/
│   └── link_model.dart
├── services/
│   └── storage_service.dart
├── providers/
│   └── link_provider.dart
├── screens/
│   ├── home_screen.dart
│   └── settings_screen.dart
├── widgets/
│   ├── link_card.dart
│   ├── add_link_dialog.dart
│   ├── edit_link_dialog.dart
│   └── delete_dialog.dart
└── utils/
    └── constants.dart
```
