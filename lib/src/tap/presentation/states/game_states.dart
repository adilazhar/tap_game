sealed class GameState {
  const GameState();
}

final class MainMenuState extends GameState {}

final class CountdownState extends GameState {}

final class PauseState extends GameState {}

sealed class PlayingState extends GameState {}

final class GameOn extends PlayingState {}

final class GameWin extends PlayingState {}
