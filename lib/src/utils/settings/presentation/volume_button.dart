import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tap_game/src/tap/presentation/widgets/my_icon_button.dart';
import 'package:tap_game/src/utils/settings/application/app_setting_notifier.dart';

class VolumeButton extends ConsumerWidget {
  const VolumeButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAudioOn = ref
        .watch(appSettingNotifierProvider.select((value) => value.isAudioOn));

    return MyIconButton(
      onPressed: () => ref
          .read(appSettingNotifierProvider.notifier)
          .updateAudioOn(!isAudioOn),
      icon: isAudioOn ? Icons.volume_up_rounded : Icons.volume_off_rounded,
    );
  }
}
