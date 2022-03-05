import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'settings.dart';

class AppStateNotifier extends StateNotifier<AppState> {
  AppStateNotifier([AppState? appState]) : super(appState ?? AppState());

  void togglePlaySounds() {
    state = state.copyWith(playSounds: !state.playSounds);
  }
}

final StateNotifierProvider<AppStateNotifier, AppState> appStateProvider =
    StateNotifierProvider((ref) => AppStateNotifier());
