import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:tap_game/src/tap/application/red_height_service.dart';
import 'package:tap_game/src/tap/presentation/controllers/game_state_controller.dart';
import 'package:tap_game/src/tap/presentation/states/game_states.dart';

class TapWidget extends ConsumerWidget {
  const TapWidget({
    super.key,
    required this.gameState,
  });

  final GameState gameState;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final totalHeight = MediaQuery.sizeOf(context).height;
    final redHeightPercent = ref.watch(redHeightServiceProvider);
    final isGameOn = gameState is GameOn;
    final isGameWonByRed = gameState is GameWin && redHeightPercent == 100;
    final isGameWonByBlue = gameState is GameWin && redHeightPercent == 0;

    final redHeight = (redHeightPercent / 100) * totalHeight;
    final blueHeight = totalHeight - redHeight;

    return Column(
      children: [
        GestureDetector(
          onTap: isGameOn
              ? () => ref.read(gameStateControllerProvider.notifier).tapOn(true)
              : null,
          child: AnimatedContainer(
            duration: Durations.short4,
            width: double.infinity,
            height: redHeight,
            color: Colors.red,
            alignment: Alignment.bottomCenter,
            child: isGameWonByRed
                ? const Text(
                    'RED WON',
                    style: TextStyle(fontSize: 50, color: Colors.white),
                  )
                : null,
          ),
        ),
        GestureDetector(
          onTap: isGameOn
              ? () =>
                  ref.read(gameStateControllerProvider.notifier).tapOn(false)
              : null,
          child: AnimatedContainer(
            duration: Durations.short4,
            width: double.infinity,
            height: blueHeight,
            color: Colors.blue,
            alignment: Alignment.topCenter,
            child: isGameWonByBlue
                ? const Text(
                    'BLUE WON',
                    style: TextStyle(fontSize: 50, color: Colors.white),
                  )
                : null,
          ),
        ),
      ],
    );
  }
}
