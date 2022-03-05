import 'package:copy_with_extension/copy_with_extension.dart';

part 'settings.g.dart';

/// This class holds the current state of the entire app
@CopyWith()
class AppState {
  bool playSounds;
  Duration duration;

  AppState({
    this.playSounds = false,
    this.duration = const Duration(minutes: 5),
  });

  void togglePlaySounds() {}
}

extension toggleBool on bool {
  bool toggle() {
    return !this;
  }
}
