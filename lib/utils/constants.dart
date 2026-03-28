import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF673AB7);
  static const Color primaryDark = Color(0xFF512DA8);
  static const Color primaryLight = Color(0xFFD1C4E9);
  static const Color accent = Color(0xFF64FFDA);
  static const Color background = Color(0xFFF5F5F5);
  static const Color surface = Colors.white;
  static const Color error = Color(0xFFD32F2F);
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
}

class AppStrings {
  static const String appName = 'OneTap Links';
  static const String home = 'Home';
  static const String settings = 'Settings';
  static const String about = 'About';
  static const String addLink = 'Add Link';
  static const String editLink = 'Edit Link';
  static const String url = 'URL';
  static const String shortName = 'Short Name';
  static const String save = 'Save';
  static const String cancel = 'Cancel';
  static const String delete = 'Delete';
  static const String yes = 'Yes';
  static const String no = 'No';
  static const String deleteConfirmation =
      'Are you sure you want to delete this link?';
  static const String clearAllConfirmation =
      'Are you sure you want to delete all bookmarks?';
  static const String linkAdded = 'Link added successfully';
  static const String linkUpdated = 'Link updated successfully';
  static const String linkDeleted = 'Link deleted successfully';
  static const String linksCleared = 'All links cleared';
  static const String noLinksYet =
      'No links yet!\nTap + to add your first link';
  static const String clearAllBookmarks = 'Clear All Bookmarks';
  static const String aboutDescription =
      'OneTap Links helps you save and access your favorite websites with just one tap. No more searching through Chrome - your links are always just a tap away!';
  static const String version = 'Version 1.0.0';
  static const String enterUrl = 'Enter website URL';
  static const String enterName = 'Enter a short name';
  static const String invalidUrl = 'Please enter a valid URL';
  static const String invalidName = 'Please enter a name';
  static const String appDescription = 'Your quick-access bookmark manager';
}

class AppDurations {
  static const Duration animationDuration = Duration(milliseconds: 200);
  static const Duration snackbarDuration = Duration(seconds: 2);
}
