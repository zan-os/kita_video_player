import 'dart:collection';

import 'package:flutter/widgets.dart';

import '../../kita_video_player.dart';

class VideoStateInheritedWidget extends InheritedWidget {
  final KitaVideoPlayerState state;

  final bool disposeNotifiers;
  VideoStateInheritedWidget({
    super.key,
    required this.state,
    required Widget child,
    this.disposeNotifiers = true,
  }) : super(
          child: VideoStateInheritedWidgetContextNotifier(
            state: state,
            disposeNotifiers: disposeNotifiers,
            child: child,
          ),
        );

  static VideoStateInheritedWidget? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<VideoStateInheritedWidget>();
  }

  static VideoStateInheritedWidget of(BuildContext context) {
    final VideoStateInheritedWidget? result = maybeOf(context);
    assert(
      result != null,
      'No [VideoStateInheritedWidget] found in [context]',
    );
    return result!;
  }

  @override
  bool updateShouldNotify(VideoStateInheritedWidget oldWidget) =>
      identical(state, oldWidget.state);
}

class VideoStateInheritedWidgetContextNotifier extends StatefulWidget {
  final KitaVideoPlayerState state;
  final bool disposeNotifiers;
  final Widget child;

  const VideoStateInheritedWidgetContextNotifier({
    super.key,
    required this.state,
    required this.disposeNotifiers,
    required this.child,
  });

  @override
  State<VideoStateInheritedWidgetContextNotifier> createState() =>
      VideoStateInheritedWidgetContextNotifierState();
}

class VideoStateInheritedWidgetContextNotifierState
    extends State<VideoStateInheritedWidgetContextNotifier> {
  static final fallback =
      HashMap<KitaVideoPlayerState, BuildContext>.identity();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Only update the [BuildContext] associated with this [Video] widget if it is not already set or if the [Video] widget is in fullscreen mode.
    // This is being done because the [Video] widget is rebuilt when it enters/exits fullscreen mode... & things don't work properly if we let [BuildContext] update in every rebuild.

    return widget.child;
  }
}
