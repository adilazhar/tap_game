import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:tap_game/src/tap/presentation/widgets/my_icon_button.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({
    super.key,
    required this.changeToCountdown,
  });

  final VoidCallback changeToCountdown;

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          MyIconButton(
            onPressed: changeToCountdown,
            icon: Icons.play_arrow_rounded,
          ),
          const Gap(20),
          MyIconButton(
            onPressed: () {},
            icon: Icons.volume_up_rounded,
          ),
        ],
      ),
    );
  }
}
