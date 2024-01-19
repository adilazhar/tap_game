import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'package:tap_game/src/tap/presentation/widgets/my_icon_button.dart';

class PauseMenu extends StatelessWidget {
  const PauseMenu({
    super.key,
    required this.resumeGame,
    required this.restartGame,
    required this.goToMainMenu,
  });

  final VoidCallback resumeGame;
  final VoidCallback restartGame;
  final VoidCallback goToMainMenu;

  @override
  Widget build(BuildContext context) {
    return Align(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          MyIconButton(
            onPressed: resumeGame,
            icon: Icons.play_arrow_rounded,
          ),
          const Gap(20),
          MyIconButton(
            onPressed: restartGame,
            icon: Icons.refresh_rounded,
          ),
          const Gap(20),
          MyIconButton(
            onPressed: goToMainMenu,
            icon: Icons.home_rounded,
          ),
        ],
      ),
    );
  }
}
