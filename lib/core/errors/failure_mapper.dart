import 'package:flutter_template/core/errors/failure.dart';

/// Maps a [Failure] to a human-readable message for display in the UI.
///
/// Centralises failure-to-message conversion so BLoCs don't each
/// reimplement their own switch over [Failure] subtypes.
String mapFailureToMessage(Failure failure) {
  if (failure is APIFailure) {
    return 'API error: ${failure.message}';
  }
  return 'An unexpected error occurred';
}
