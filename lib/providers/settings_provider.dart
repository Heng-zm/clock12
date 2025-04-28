import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Enum for Time Format
enum TimeFormatOption { hour12, hour24 }

class SettingsProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  TimeFormatOption _timeFormat = TimeFormatOption.hour24; // Default to 24-hour

  ThemeMode get themeMode => _themeMode;
  TimeFormatOption get timeFormat => _timeFormat;

  // --- Keys for SharedPreferences ---
  static const String _themeKey = 'themeMode';
  static const String _timeFormatKey = 'timeFormat';

  SettingsProvider() {
    _loadSettings(); // Load saved settings when the provider is created
  }

  // --- Load Settings ---
  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();

    // Load Theme
    final themeString =
        prefs.getString(_themeKey) ?? ThemeMode.system.toString();
    _themeMode = ThemeMode.values.firstWhere(
      (e) => e.toString() == themeString,
      orElse: () => ThemeMode.system,
    );

    // Load Time Format
    final timeFormatString =
        prefs.getString(_timeFormatKey) ?? TimeFormatOption.hour24.toString();
    _timeFormat = TimeFormatOption.values.firstWhere(
      (e) => e.toString() == timeFormatString,
      orElse: () => TimeFormatOption.hour24,
    );

    notifyListeners(); // Notify listeners after loading
  }

  // --- Save Settings ---
  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeKey, _themeMode.toString());
    await prefs.setString(_timeFormatKey, _timeFormat.toString());
  }

  // --- Update Methods ---
  void updateThemeMode(ThemeMode? newThemeMode) {
    if (newThemeMode == null || newThemeMode == _themeMode) return;
    _themeMode = newThemeMode;
    notifyListeners();
    _saveSettings(); // Save the change
  }

  void updateTimeFormat(TimeFormatOption? newTimeFormat) {
    if (newTimeFormat == null || newTimeFormat == _timeFormat) return;
    _timeFormat = newTimeFormat;
    notifyListeners();
    _saveSettings(); // Save the change
  }

  // Helper to get intl format string based on setting
  String get intlTimeFormat {
    return _timeFormat == TimeFormatOption.hour12 ? 'hh:mm:ss a' : 'HH:mm:ss';
  }

  String get intlShortTimeFormat {
    return _timeFormat == TimeFormatOption.hour12 ? 'hh:mm a' : 'HH:mm';
  }
}
