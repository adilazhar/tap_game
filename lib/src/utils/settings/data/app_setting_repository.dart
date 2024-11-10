import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tap_game/src/utils/providers/shared_preferences_provider.dart';
import 'package:tap_game/src/utils/settings/domain/app_setting.dart';
import 'package:tap_game/src/utils/settings/domain/app_setting_helper.dart';

part 'app_setting_repository.g.dart';

class AppSettingRepository {
  final SharedPreferences _prefs;

  AppSettingRepository(this._prefs);

  AppSetting loadSettings() {
    bool? isDarkMode = _prefs.getBool(AppSettingHelper.isDarkMode);
    bool? isAudioOn = _prefs.getBool(AppSettingHelper.isAudioOn);
    return AppSetting(
      isDarkMode: isDarkMode,
      isAudioOn: isAudioOn,
    );
  }

  // Future<void> saveSettings(AppSetting settings) async {
  //   await _prefs.setBool(AppSettingHelper.isDarkMode, settings.isDarkMode);
  //   await _prefs.setBool(AppSettingHelper.isAudioOn, settings.isAudioOn);
  // }

  // dynamic getData(String key) {
  //   return _prefs.get(key);
  // }

  Future<void> saveData(String key, dynamic value) async {
    if (value is bool) {
      await _prefs.setBool(key, value);
    } else if (value is int) {
      await _prefs.setInt(key, value);
    } else if (value is double) {
      await _prefs.setDouble(key, value);
    } else if (value is String) {
      await _prefs.setString(key, value);
    } else if (value is List<String>) {
      await _prefs.setStringList(key, value);
    } else {
      throw Exception(
          'Invalid data type. SharedPreferences can only store bool, int, double, String, and List<String>.');
    }
  }
}

@Riverpod(keepAlive: true)
AppSettingRepository appSettingRepository(AppSettingRepositoryRef ref) {
  final pref = ref.watch(sharedPreferencesProvider);
  return AppSettingRepository(pref);
}
