import 'package:equatable/equatable.dart';

class AppSetting extends Equatable {
  final bool isDarkMode;
  final bool isAudioOn;

  const AppSetting({
    bool? isDarkMode,
    bool? isAudioOn,
  })  : isDarkMode = isDarkMode ?? false,
        isAudioOn = isAudioOn ?? true;

  AppSetting copyWith({
    bool? isDarkMode,
    bool? isAudioOn,
  }) {
    return AppSetting(
      isDarkMode: isDarkMode ?? this.isDarkMode,
      isAudioOn: isAudioOn ?? this.isAudioOn,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [isDarkMode, isAudioOn];
}
