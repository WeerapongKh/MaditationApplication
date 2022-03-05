part of 'settings.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

extension AppStateCopyWithExtension on AppState {
  AppState copyWith({
    Duration? duration,
    bool? playSounds,
  }) {
    return AppState(
      duration: duration ?? this.duration,
      playSounds: playSounds ?? this.playSounds,
    );
  }
}
