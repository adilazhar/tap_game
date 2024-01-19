import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tap_game/src/tap/presentation/states/game_states.dart';
import 'package:tap_game/src/tap/presentation/widgets/countdown_widget.dart';
import 'package:tap_game/src/tap/presentation/widgets/main_menu.dart';
import 'package:tap_game/src/tap/presentation/widgets/overlay_widget.dart';
import 'package:tap_game/src/tap/presentation/widgets/pause_menu.dart';
import 'package:tap_game/src/tap/presentation/controllers/game_state_controller.dart';
import 'package:tap_game/src/tap/presentation/widgets/tap_widget.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(gameStateControllerProvider);
    return Scaffold(
      body: Stack(
        children: [
          TapWidget(
            gameState: state,
          ),
          if (state is! PlayingState) const OverlayWidget(),
          if (state is MainMenuState)
            MainMenu(
              changeToCountdown: () => ref
                  .read(gameStateControllerProvider.notifier)
                  .changeStateTo(GameStates.countdown.name),
            ),
          if (state is CountdownState)
            CountDown(
              startGame: () => ref
                  .read(gameStateControllerProvider.notifier)
                  .changeStateTo(GameStates.gameon.name),
            ),
          if (state is PauseState)
            PauseMenu(
              resumeGame: () =>
                  ref.read(gameStateControllerProvider.notifier).resumeGame(),
              restartGame: () =>
                  ref.read(gameStateControllerProvider.notifier).restartGame(),
              goToMainMenu: () =>
                  ref.read(gameStateControllerProvider.notifier).resetGame(),
            ),
        ],
      ),
    );
  }
}
