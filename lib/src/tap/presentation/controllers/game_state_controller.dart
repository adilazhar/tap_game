import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tap_game/src/tap/application/red_height_service.dart';
import 'package:tap_game/src/tap/presentation/states/game_states.dart';

part 'game_state_controller.g.dart';

enum GameStates { mainmenu, countdown, pause, gameon, gamewin }

@riverpod
class GameStateController extends _$GameStateController {
  final Map<String, GameState> _gameStates = {
    GameStates.mainmenu.name: MainMenuState(),
    GameStates.countdown.name: CountdownState(),
    GameStates.pause.name: PauseState(),
    GameStates.gameon.name: GameOn(),
    GameStates.gamewin.name: GameWin(),
  };

  Timer? _timer;

  @override
  GameState build() {
    ref.listen(redHeightServiceProvider, (_, currentState) {
      if (currentState == 0 || currentState == 100) {
        state = GameWin();
      }
    });

    ref.listenSelf((_, currentState) {
      if (currentState is GameWin) {
        Timer(const Duration(seconds: 3), () => resetGame());
      }
      if (currentState is GameOn) {
        _resetTimer();
      } else {
        _timer?.cancel();
      }
    });

    return MainMenuState();
  }

  void _resetTimer() {
    _timer?.cancel();
    _timer = Timer(const Duration(seconds: 5), () {
      if (state is GameOn) {
        state = PauseState();
      }
    });
  }

  void changeStateTo(String stateName) {
    state = _gameStates[stateName]!;
  }

  void tapOn(bool isRed) {
    ref.read(redHeightServiceProvider.notifier).tapOn(isRed);
    if (state is GameOn) {
      _resetTimer();
    }
  }

  void resetGame() {
    ref.read(redHeightServiceProvider.notifier).reset();
    state = MainMenuState();
  }

  void resumeGame() {
    state = GameOn();
  }

  void restartGame() {
    ref.read(redHeightServiceProvider.notifier).reset();
    state = CountdownState();
  }
}
