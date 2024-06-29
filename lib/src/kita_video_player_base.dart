// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:kita_video_player/src/controls/kita_video_controls.dart';
import 'package:kita_video_player/src/widgets/video_state_inherited_widget.dart';

class KitaVideoPlayer extends StatefulWidget {
  final VlcPlayerController controller;
  final double aspectRatio;
  final Widget? placeholder;
  final bool virtualDisplay;

  /// The callback invoked when the [Video] enters fullscreen.
  final Future<void> Function(bool isFullscreen)? onEnterFullscreen;

  /// The callback invoked when the [Video] exits fullscreen.
  final Future<void> Function(bool isFullscreen)? onExitFullscreen;

  const KitaVideoPlayer({
    super.key,
    required this.controller,
    required this.aspectRatio,
    this.placeholder,
    this.virtualDisplay = true,
    this.onEnterFullscreen,
    this.onExitFullscreen,
  });

  @override
  State<KitaVideoPlayer> createState() => KitaVideoPlayerState();
}

class KitaVideoPlayerState extends State<KitaVideoPlayer>
    with WidgetsBindingObserver {
  bool isFullscreen = false;

  @override
  void initState() {
    super.initState();
  }

  void refreshView() {}

  @override
  Widget build(BuildContext context) {
    return VideoStateInheritedWidget(
      state: this as dynamic,
      child: Stack(
        fit: StackFit.passthrough,
        children: [
          VlcPlayer(
            controller: widget.controller,
            aspectRatio: widget.aspectRatio,
            placeholder: widget.placeholder,
            virtualDisplay: widget.virtualDisplay,
          ),
          Positioned.fill(
            child: KitaVideoControls(),
          )
        ],
      ),
    );
  }

// --------------------------------------------------

  /// Makes the native window enter fullscreen.
  Future<void> defaultEnterNativeFullscreen(bool isFullscreen) async {
    try {
      if (Platform.isAndroid || Platform.isIOS) {
        setState(() {
          isFullscreen = true;
        });
        await Future.wait(
          [
            SystemChrome.setEnabledSystemUIMode(
              SystemUiMode.immersiveSticky,
              overlays: [],
            ),
            SystemChrome.setPreferredOrientations(
              [
                DeviceOrientation.landscapeLeft,
                DeviceOrientation.landscapeRight,
              ],
            ),
          ],
        );
      } else if (Platform.isMacOS || Platform.isWindows || Platform.isLinux) {
        await const MethodChannel('com.alexmercerind/media_kit_video')
            .invokeMethod(
          'Utils.EnterNativeFullscreen',
        );
      }
    } catch (exception, stacktrace) {
      debugPrint(exception.toString());
      debugPrint(stacktrace.toString());
    }
  }

  /// Makes the native window exit fullscreen.
  Future<void> defaultExitNativeFullscreen(bool isFullscreen) async {
    try {
      if (Platform.isAndroid || Platform.isIOS) {
        setState(() {
          isFullscreen = false;
        });
        await Future.wait(
          [
            SystemChrome.setEnabledSystemUIMode(
              SystemUiMode.manual,
              overlays: SystemUiOverlay.values,
            ),
            SystemChrome.setPreferredOrientations(
              [DeviceOrientation.portraitUp],
            ),
          ],
        );
      } else if (Platform.isMacOS || Platform.isWindows || Platform.isLinux) {
        await const MethodChannel('com.alexmercerind/media_kit_video')
            .invokeMethod(
          'Utils.ExitNativeFullscreen',
        );
      }
    } catch (exception, stacktrace) {
      debugPrint(exception.toString());
      debugPrint(stacktrace.toString());
    }
  }
// --------------------------------------------------
}
