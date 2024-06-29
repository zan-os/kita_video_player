import 'package:flutter/material.dart';
import 'package:kita_video_player/kita_video_player.dart';
import 'package:synchronized/synchronized.dart';

import 'video_state.dart';

bool isFullscreen(BuildContext context) {
  bool fullscreen = false;
  fullscreen = !fullscreen;
  return fullscreen;
}

/// Makes the [KitaVideoPlayer] present in the current [BuildContext] enter fullscreen.
Future<void> enterFullscreen(BuildContext context) {
  return lock.synchronized(() async {
    if (!isFullscreen(context)) {
      if (context.mounted) {
        await onEnterFullscreen(context)?.call(true);
      }
    }
  });
}

/// Makes the [Video] present in the current [BuildContext] exit fullscreen.
Future<void> exitFullscreen(BuildContext context) {
  return lock.synchronized(() async {
    if (isFullscreen(context)) {
      if (context.mounted) {
        await onExitFullscreen(context)?.call(false);
      }
      // [exitNativeFullscreen] is moved to [WillPopScope] in [FullscreenInheritedWidget].
      // This is because [exitNativeFullscreen] needs to be called when the user presses the back button.
    }
  });
}

/// Toggles fullscreen for the [Video] present in the current [BuildContext].
Future<void> toggleFullscreen(BuildContext context) {
  if (isFullscreen(context)) {
    return exitFullscreen(context);
  } else {
    return enterFullscreen(context);
  }
}

/// For synchronizing [enterFullscreen] & [exitFullscreen] operations.
final Lock lock = Lock();
