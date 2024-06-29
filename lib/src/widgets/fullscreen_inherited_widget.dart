import 'package:flutter/material.dart';
import 'package:kita_video_player/kita_video_player.dart';

import '../controls/methods/video_state.dart';

class FullscreenInheritedWidget extends InheritedWidget {
  final KitaVideoPlayerState parent;

  FullscreenInheritedWidget({
    super.key,
    required this.parent,
    required Widget child,
  }) : super(child: _FullscreenInheritedWidgetPopScope(child: child));

  static FullscreenInheritedWidget? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<FullscreenInheritedWidget>();
  }

  static FullscreenInheritedWidget of(BuildContext context) {
    final FullscreenInheritedWidget? result = maybeOf(context);
    assert(
      result != null,
      'No [FullscreenInheritedWidget] found in [context]',
    );
    return result!;
  }

  @override
  bool updateShouldNotify(FullscreenInheritedWidget oldWidget) =>
      identical(parent, oldWidget.parent);
}

/// {@template fullscreen_inherited_widget_pop_scope}
///
/// This widget is used to exit native fullscreen when this route is popped from the navigator.
///
/// {@endtemplate}
class _FullscreenInheritedWidgetPopScope extends StatefulWidget {
  final Widget child;
  const _FullscreenInheritedWidgetPopScope({
    required this.child,
  });

  @override
  State<_FullscreenInheritedWidgetPopScope> createState() =>
      _FullscreenInheritedWidgetPopScopeState();
}

class _FullscreenInheritedWidgetPopScopeState
    extends State<_FullscreenInheritedWidgetPopScope> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: true,
      onPopInvoked: (didPop) async {
        // Make sure to exit native fullscreen when this route is popped from the navigator.
        await onExitFullscreen(context)?.call(false);
      },
      child: widget.child,
    );
  }
}
