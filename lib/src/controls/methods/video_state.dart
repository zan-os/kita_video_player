import 'package:flutter/material.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:kita_video_player/kita_video_player.dart';

import '../../widgets/video_state_inherited_widget.dart';

/// Returns the [VlcPlayerController] associated with the [Video] present in the current [BuildContext].
VlcPlayerController controller(BuildContext context) =>
    VideoStateInheritedWidget.of(context).state.widget.controller;

/// Returns the [KitaVideoPlayerState] associated with the [KitaVideoPlayer] present in the current [BuildContext].
KitaVideoPlayerState state(BuildContext context) =>
    VideoStateInheritedWidget.of(context).state;

/// Returns the callback which must be invoked when the video enters fullscreen mode.
Future<void> Function(bool isFullscreen)? onEnterFullscreen(
        BuildContext context) =>
    VideoStateInheritedWidget.of(context).state.widget.onEnterFullscreen;

/// Returns the callback which must be invoked when the video exits fullscreen mode.
Future<void> Function(bool isFullscreen)? onExitFullscreen(
        BuildContext context) =>
    VideoStateInheritedWidget.of(context).state.widget.onExitFullscreen;
