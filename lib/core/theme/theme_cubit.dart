import 'package:car_care/core/local_storage/secure_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Cubit for managing app theme mode (Light / Dark / System)
class ThemeCubit extends Cubit<ThemeMode> {
  ThemeCubit(this._secureStorage) : super(ThemeMode.light) {
    _loadSavedTheme();
  }

  final SecureStorage _secureStorage;

  /// Load saved theme mode from storage
  Future<void> _loadSavedTheme() async {
    final saved = await _secureStorage.getThemeMode();
    if (saved != null && saved.isNotEmpty) {
      final mode = _fromString(saved);
      if (mode != null) emit(mode);
    }
    // If no saved value, keep Light as default (already set in super)
  }

  /// Change the app theme mode
  Future<void> setThemeMode(ThemeMode mode) async {
    await _secureStorage.setThemeMode(mode.name);
    emit(mode);
  }

  /// Toggle between Light and Dark (ignores System)
  Future<void> toggleTheme() async {
    final newMode = state == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    await setThemeMode(newMode);
  }

  bool get isDark => state == ThemeMode.dark;
  bool get isLight => state == ThemeMode.light;
  bool get isSystem => state == ThemeMode.system;

  ThemeMode? _fromString(String value) {
    switch (value) {
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      case 'system':
        return ThemeMode.system;
      default:
        return null;
    }
  }
}