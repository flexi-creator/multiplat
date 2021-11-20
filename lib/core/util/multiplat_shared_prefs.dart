import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MultiplatSharedPrefs {
  static final bool _useFileSystem =
      !kIsWeb && (Platform.isWindows || Platform.isLinux);

  static const String _selected_index_key = "selectedIndex";
  static const _prefsFile = 'multiplat_sharedprefs.txt';
  static String _prefsFullPath = '';

  Future<int> getSelectedItemIndex() async {
    if (_useFileSystem) {
      return _readFile();
    }

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.getInt(_selected_index_key) ?? 0;
  }

  Future<bool> setSelectedItemIndex(int index) async {
    if (_useFileSystem) {
      return _writeFile(index);
    }

    final SharedPreferences prefs = await SharedPreferences.getInstance();

    return prefs.setInt(_selected_index_key, index);
  }

  Future<int> _readFile() async {
    try {
      final file = File(_getFullPath());
      if (file.existsSync()) {
        final str = file.readAsStringSync();
        if (str.isNotEmpty) {
          return int.parse(str);
        }
      }
    } catch (e, s) {
      print('Error occurred trying to read $_prefsFile: $e');
      print('$s');
      // swallow error
    }
    return 0;
  }

  Future<bool> _writeFile(int selectedIndex) async {
    try {
      File(_getFullPath()).writeAsStringSync('$selectedIndex');
    } catch (e, s) {
      print('Error occurred trying to write to $_prefsFile: $e');
      print('$s');
      return false;
      // swallow error
    }
    return true;
  }

  String _getFullPath() {
    _prefsFullPath = Directory.systemTemp.path +
        (Platform.isWindows ? '\\' : '/') +
        _prefsFile;
    print('shared prefs file is $_prefsFullPath');
    return _prefsFullPath;
  }
}
