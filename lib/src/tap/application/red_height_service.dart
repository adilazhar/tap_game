import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'red_height_service.g.dart';

@riverpod
class RedHeightService extends _$RedHeightService {
  @override
  int build() {
    return 50;
  }

  void tapOn(bool isRed) {
    isRed ? state = state + 5 : state = state - 5;
  }

  void reset() {
    state = 50;
  }
}
