import 'dart:async';

import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tap_game/src/tap/application/red_height_service.dart';
import 'package:tap_game/src/tap/presentation/states/game_states.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:tap_game/src/utils/settings/application/app_setting_notifier.dart';

part 'game_state_controller.g.dart';

enum GameStates { mainmenu, countdown, pause, gameon, gamewin }

@riverpod
class GameStateController extends _$GameStateController
    with WidgetsBindingObserver {
  final Map<String, GameState> _gameStates = {
    GameStates.mainmenu.name: MainMenuState(),
    GameStates.countdown.name: CountdownState(),
    GameStates.pause.name: PauseState(),
    GameStates.gameon.name: GameOn(),
    GameStates.gamewin.name: GameWin(),
  };

  final AudioPlayer _audioPlayer = AudioPlayer();

  late bool _toPlayAudio;

  Timer? _timer;

  @override
  GameState build() {
    _toPlayAudio = ref
        .watch(appSettingNotifierProvider)
        .whenData((value) => value.isAudioOn)
        .value!;
    WidgetsBinding.instance.addObserver(this);
    _audioPlayer.setReleaseMode(ReleaseMode.loop);

    ref.listen(redHeightServiceProvider, (_, currentState) {
      if (currentState == 0 || currentState == 100) {
        changeStateTo(GameStates.gamewin.name);
      }
    });

    ref.listenSelf((_, currentState) {
      if (_toPlayAudio) {
        playAudio(currentState);
      } else {
        _audioPlayer.release();
      }
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

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      _audioPlayer.pause();
    } else if (state == AppLifecycleState.resumed) {
      _audioPlayer.resume();
    }
  }

  void _resetTimer() {
    _timer?.cancel();
    _timer = Timer(const Duration(seconds: 5), () {
      if (state is GameOn) {
        changeStateTo(GameStates.pause.name);
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
    changeStateTo(GameStates.mainmenu.name);
  }

  void resumeGame() {
    changeStateTo(GameStates.gameon.name);
  }

  void restartGame() {
    ref.read(redHeightServiceProvider.notifier).reset();
    changeStateTo(GameStates.countdown.name);
  }

  String _getAudioPathForState(GameState state) {
    if (state is MainMenuState || state is PauseState) {
      return "background.m4a";
    } else if (state is CountdownState) {
      return "123.m4a";
    } else if (state is GameOn) {
      return "gameon.m4a";
    } else if (state is GameWin) {
      return "win.m4a";
    } else {
      throw Exception("Invalid GameState");
    }
  }

  Future<void> playAudio(GameState state) async {
    await _audioPlayer.release();
    await _audioPlayer.play(
      AssetSource(_getAudioPathForState(state)),
    );
  }
}
