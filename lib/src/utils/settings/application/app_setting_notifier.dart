import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tap_game/src/utils/settings/data/app_setting_repository.dart';
import 'package:tap_game/src/utils/settings/domain/app_setting.dart';
import 'package:tap_game/src/utils/settings/domain/app_setting_helper.dart';

part 'app_setting_notifier.g.dart';

@Riverpod(keepAlive: true)
class AppSettingNotifier extends _$AppSettingNotifier {
  late final AppSettingRepository _appSettingRepo;

  @override
  FutureOr<AppSetting> build() async {
    _appSettingRepo = await ref.watch(appSettingRepositoryProvider.future);
    return await loadSettings();
  }

  Future<AppSetting> loadSettings() async {
    return await _appSettingRepo.loadSettings();
  }

  Future<void> updateDarkMode(
    bool value,
  ) async {
    state = AsyncValue.data(state.value!.copyWith(isDarkMode: value));
    await _appSettingRepo.saveData(AppSettingHelper.isDarkMode, value);
  }

  Future<void> updateAudioOn(bool value) async {
    state = AsyncValue.data(state.value!.copyWith(isAudioOn: value));
    await _appSettingRepo.saveData(AppSettingHelper.isAudioOn, value);
  }
}
