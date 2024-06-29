import 'package:flutter/material.dart';
import 'package:kita_video_player/kita_video_player.dart';
import 'package:synchronized/synchronized.dart';

import '../../widgets/fullscreen_inherited_widget.dart';
import '../../widgets/video_state_inherited_widget.dart';
import 'video_state.dart';

/// Makes the [KitaVideoPlayer] present in the current [BuildContext] enter fullscreen.
Future<void> enterFullscreen(BuildContext context) {
  return lock.synchronized(() async {
    if (!isFullscreen(context)) {
      if (context.mounted) {
        final stateValue = state(context);

        final controllerValue = controller(context);

        final screenSize = MediaQuery.of(context).size;
        final fullscrenAspectRatio = screenSize.width / screenSize.height;
        Navigator.of(context, rootNavigator: true).push(
          PageRouteBuilder(
            pageBuilder: (_, __, ___) => Material(
              child: VideoStateInheritedWidget(
                state: stateValue,
                disposeNotifiers: false,
                child: FullscreenInheritedWidget(
                  parent: stateValue,
                  // Another [VideoStateInheritedWidget] inside [FullscreenInheritedWidget] is important to notify about the fullscreen [BuildContext].
                  child: VideoStateInheritedWidget(
                    state: stateValue,
                    disposeNotifiers: false,
                    child: KitaVideoPlayer(
                      controller: controllerValue,
                      aspectRatio: fullscrenAspectRatio,
                      placeholder: CircularProgressIndicator.adaptive(),
                    ),
                  ),
                ),
              ),
            ),
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
        await onEnterFullscreen(context)?.call(false);
      }
    }
  });
}

/// Makes the [Video] present in the current [BuildContext] exit fullscreen.
Future<void> exitFullscreen(BuildContext context) {
  return lock.synchronized(() async {
    if (isFullscreen(context)) {
      if (context.mounted) {
        await Navigator.of(context).maybePop();
        // It is known that this [context] will have a [FullscreenInheritedWidget] above it.
        if (context.mounted) {
          FullscreenInheritedWidget.of(context).parent.refreshView();
        }
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
