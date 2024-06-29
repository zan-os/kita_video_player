import 'dart:async';

import 'package:flutter/material.dart';

import 'methods/video_state.dart';

/// [MaterialVideoControlsThemeData] available in this [context].
MaterialVideoControlsThemeData _theme(BuildContext context) =>
    MaterialVideoControlsTheme.maybeOf(context)?.normal ??
    kDefaultMaterialVideoControlsThemeData;

/// Default [MaterialVideoControlsThemeData].
const kDefaultMaterialVideoControlsThemeData = MaterialVideoControlsThemeData();

class KitaVideoControls extends StatefulWidget {
  const KitaVideoControls({super.key});

  @override
  State<KitaVideoControls> createState() => _KitaVideoControlsState();
}

class _KitaVideoControlsState extends State<KitaVideoControls> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [_PlayOrPauseButton(), MaterialFullscreenButton()],
      ),
    );
  }
}

class MaterialVideoControlsThemeData {
  // BEHAVIOR

  /// Whether to display seek bar.
  final bool displaySeekBar;

  /// Whether a skip next button should be displayed if there are more than one videos in the playlist.
  final bool automaticallyImplySkipNextButton;

  /// Whether a skip previous button should be displayed if there are more than one videos in the playlist.
  final bool automaticallyImplySkipPreviousButton;

  /// Whether to modify volume on vertical drag gesture on the right side of the screen.
  final bool volumeGesture;

  /// Whether to modify screen brightness on vertical drag gesture on the left side of the screen.
  final bool brightnessGesture;

  /// Whether to seek on horizontal drag gesture.
  final bool seekGesture;

  /// Whether to allow gesture controls to work while controls are visible.
  /// NOTE: This option is ignored when gestures are false.
  final bool gesturesEnabledWhileControlsVisible;

  /// Whether to enable double tap to seek on left or right side of the screen.
  final bool seekOnDoubleTap;

  /// Whether to allow double tap to seek on left or right side of the screen to work while controls are visible.
  /// NOTE: This option is ignored when [seekOnDoubleTap] is false.
  final bool seekOnDoubleTapEnabledWhileControlsVisible;

  /// `seekOnDoubleTapLayoutTapsRatios` defines the width proportions for the interactive areas
  /// responsible for seek actions (backward seek, instant tap, forward seek) when a double tap
  /// occurs on the video widget. This property divides the video widget into three segments
  /// horizontally. Each integer in the list represents the relative width of each segment.
  /// By default, the value `[1, 1, 1]` means that the video widget is equally divided into three
  /// segments: the left segment for backward seek, the middle segment for instant tap (usually show and hide controls),
  /// and the right segment for forward seek. Adjusting these values changes the width of the interactive areas
  /// for each double tap action.
  final List<int> seekOnDoubleTapLayoutTapsRatios;

  /// `seekOnDoubleTapLayoutWidgetRatios` defines the width proportions for the visual indicators or
  /// widgets that appear during the double tap actions (backward seek, instant tap, forward seek).
  /// Similar to `seekOnDoubleTapLayoutTapsRatios`, it divides the area where these indicators are
  /// displayed into three segments. Each integer in the list represents the relative width of each
  /// segment where the corresponding indicators will be shown. The default `[1, 1, 1]` equally divides
  /// the space for each indicator. Modifying these values can change the layout of the seek indicators,
  /// giving more or less space to each one based on the specified ratios.
  final List<int> seekOnDoubleTapLayoutWidgetRatios;

  /// Whether the controls are initially visible.
  final bool visibleOnMount;

  /// Whether to speed up on long press.
  final bool speedUpOnLongPress;

  /// Factor to speed up on long press.
  final double speedUpFactor;

  /// Gesture sensitivity on vertical drag gestures, the higher the value is the less sensitive the gesture.
  final double verticalGestureSensitivity;

  /// Gesture sensitivity on horizontal drag gestures, the higher the value is the less sensitive the gesture.
  final double horizontalGestureSensitivity;

  /// Color of backdrop that comes up when controls are visible.
  final Color? backdropColor;

  // GENERIC

  /// Padding around the controls.
  ///
  /// * Default: `EdgeInsets.zero`
  /// * FullScreen: `MediaQuery.of(context).padding`
  ///
  /// NOTE: In fullscreen, this will be safe area (set [padding] to [EdgeInsets.zero] to disable safe area)
  final EdgeInsets? padding;

  /// [Duration] after which the controls will be hidden when there is no mouse movement.
  final Duration controlsHoverDuration;

  /// [Duration] for which the controls will be animated when shown or hidden.
  final Duration controlsTransitionDuration;

  /// Builder for the buffering indicator.
  final Widget Function(BuildContext)? bufferingIndicatorBuilder;

  /// Custom builder for volume indicator.
  final Widget Function(BuildContext, double)? volumeIndicatorBuilder;

  /// Custom builder for brightness indicator.
  final Widget Function(BuildContext, double)? brightnessIndicatorBuilder;

  /// Custom builder for seek indicator.
  final Widget Function(BuildContext, Duration)? seekIndicatorBuilder;

  /// Custom builder for seek indicator.
  final Widget Function(BuildContext, double)? speedUpIndicatorBuilder;

  /// Margin around the top button bar.
  final EdgeInsets topButtonBarMargin;

  /// Margin around the button bar.
  final EdgeInsets bottomButtonBarMargin;

  /// Height of the button bar.
  final double buttonBarHeight;

  /// Size of the button bar buttons.
  final double buttonBarButtonSize;

  /// Color of the button bar buttons.
  final Color buttonBarButtonColor;

  // SEEK BAR

  /// Margin around the seek bar.
  final EdgeInsets seekBarMargin;

  /// Height of the seek bar.
  final double seekBarHeight;

  /// Height of the seek bar [Container].
  final double seekBarContainerHeight;

  /// [Color] of the seek bar.
  final Color seekBarColor;

  /// [Color] of the playback position section in the seek bar.
  final Color seekBarPositionColor;

  /// [Color] of the playback buffer section in the seek bar.
  final Color seekBarBufferColor;

  /// Size of the seek bar thumb.
  final double seekBarThumbSize;

  /// [Color] of the seek bar thumb.
  final Color seekBarThumbColor;

  /// [Alignment] of seek bar inside the seek bar container.
  final Alignment seekBarAlignment;

  // SUBTITLE

  /// Whether to shift the subtitles upwards when the controls are visible.
  final bool shiftSubtitlesOnControlsVisibilityChange;

  /// {@macro material_video_controls_theme_data}
  const MaterialVideoControlsThemeData({
    this.displaySeekBar = true,
    this.automaticallyImplySkipNextButton = true,
    this.automaticallyImplySkipPreviousButton = true,
    this.volumeGesture = false,
    this.brightnessGesture = false,
    this.seekGesture = false,
    this.gesturesEnabledWhileControlsVisible = true,
    this.seekOnDoubleTap = false,
    this.seekOnDoubleTapEnabledWhileControlsVisible = true,
    this.seekOnDoubleTapLayoutTapsRatios = const [1, 1, 1],
    this.seekOnDoubleTapLayoutWidgetRatios = const [1, 1, 1],
    this.visibleOnMount = false,
    this.speedUpOnLongPress = false,
    this.speedUpFactor = 2.0,
    this.verticalGestureSensitivity = 100,
    this.horizontalGestureSensitivity = 1000,
    this.backdropColor = const Color(0x66000000),
    this.padding,
    this.controlsHoverDuration = const Duration(seconds: 3),
    this.controlsTransitionDuration = const Duration(milliseconds: 300),
    this.bufferingIndicatorBuilder,
    this.volumeIndicatorBuilder,
    this.brightnessIndicatorBuilder,
    this.seekIndicatorBuilder,
    this.speedUpIndicatorBuilder,
    this.topButtonBarMargin = const EdgeInsets.symmetric(horizontal: 16.0),
    this.bottomButtonBarMargin = const EdgeInsets.only(left: 16.0, right: 8.0),
    this.buttonBarHeight = 56.0,
    this.buttonBarButtonSize = 24.0,
    this.buttonBarButtonColor = const Color(0xFFFFFFFF),
    this.seekBarMargin = EdgeInsets.zero,
    this.seekBarHeight = 2.4,
    this.seekBarContainerHeight = 36.0,
    this.seekBarColor = const Color(0x3DFFFFFF),
    this.seekBarPositionColor = const Color(0xFFFF0000),
    this.seekBarBufferColor = const Color(0x3DFFFFFF),
    this.seekBarThumbSize = 12.8,
    this.seekBarThumbColor = const Color(0xFFFF0000),
    this.seekBarAlignment = Alignment.bottomCenter,
    this.shiftSubtitlesOnControlsVisibilityChange = false,
  });

  /// Creates a copy of this [MaterialVideoControlsThemeData] with the given fields replaced by the non-null parameter values.
  MaterialVideoControlsThemeData copyWith({
    bool? displaySeekBar,
    bool? automaticallyImplySkipNextButton,
    bool? automaticallyImplySkipPreviousButton,
    bool? volumeGesture,
    bool? brightnessGesture,
    bool? seekGesture,
    bool? gesturesEnabledWhileControlsVisible,
    bool? seekOnDoubleTap,
    bool? seekOnDoubleTapEnabledWhileControlsVisible,
    List<int>? seekOnDoubleTapLayoutTapsRatios,
    List<int>? seekOnDoubleTapLayoutWidgetRatios,
    bool? visibleOnMount,
    bool? speedUpOnLongPress,
    double? speedUpFactor,
    double? verticalGestureSensitivity,
    double? horizontalGestureSensitivity,
    Color? backdropColor,
    Duration? controlsHoverDuration,
    Duration? controlsTransitionDuration,
    Widget Function(BuildContext)? bufferingIndicatorBuilder,
    Widget Function(BuildContext, double)? volumeIndicatorBuilder,
    Widget Function(BuildContext, double)? brightnessIndicatorBuilder,
    Widget Function(BuildContext, Duration)? seekIndicatorBuilder,
    Widget Function(BuildContext, double)? speedUpIndicatorBuilder,
    List<Widget>? primaryButtonBar,
    List<Widget>? topButtonBar,
    EdgeInsets? topButtonBarMargin,
    List<Widget>? bottomButtonBar,
    EdgeInsets? bottomButtonBarMargin,
    double? buttonBarHeight,
    double? buttonBarButtonSize,
    Color? buttonBarButtonColor,
    EdgeInsets? seekBarMargin,
    double? seekBarHeight,
    double? seekBarContainerHeight,
    Color? seekBarColor,
    Color? seekBarPositionColor,
    Color? seekBarBufferColor,
    double? seekBarThumbSize,
    Color? seekBarThumbColor,
    Alignment? seekBarAlignment,
    bool? shiftSubtitlesOnControlsVisibilityChange,
  }) {
    return MaterialVideoControlsThemeData(
      displaySeekBar: displaySeekBar ?? this.displaySeekBar,
      automaticallyImplySkipNextButton: automaticallyImplySkipNextButton ??
          this.automaticallyImplySkipNextButton,
      automaticallyImplySkipPreviousButton:
          automaticallyImplySkipPreviousButton ??
              this.automaticallyImplySkipPreviousButton,
      volumeGesture: volumeGesture ?? this.volumeGesture,
      brightnessGesture: brightnessGesture ?? this.brightnessGesture,
      seekGesture: seekGesture ?? this.seekGesture,
      gesturesEnabledWhileControlsVisible:
          gesturesEnabledWhileControlsVisible ??
              this.gesturesEnabledWhileControlsVisible,
      seekOnDoubleTap: seekOnDoubleTap ?? this.seekOnDoubleTap,
      seekOnDoubleTapEnabledWhileControlsVisible:
          seekOnDoubleTapEnabledWhileControlsVisible ??
              this.seekOnDoubleTapEnabledWhileControlsVisible,
      seekOnDoubleTapLayoutTapsRatios: seekOnDoubleTapLayoutTapsRatios ??
          this.seekOnDoubleTapLayoutTapsRatios,
      seekOnDoubleTapLayoutWidgetRatios: seekOnDoubleTapLayoutWidgetRatios ??
          this.seekOnDoubleTapLayoutWidgetRatios,
      visibleOnMount: visibleOnMount ?? this.visibleOnMount,
      speedUpOnLongPress: speedUpOnLongPress ?? this.speedUpOnLongPress,
      speedUpFactor: speedUpFactor ?? this.speedUpFactor,
      verticalGestureSensitivity:
          verticalGestureSensitivity ?? this.verticalGestureSensitivity,
      horizontalGestureSensitivity:
          horizontalGestureSensitivity ?? this.horizontalGestureSensitivity,
      backdropColor: backdropColor ?? this.backdropColor,
      controlsHoverDuration:
          controlsHoverDuration ?? this.controlsHoverDuration,
      controlsTransitionDuration:
          controlsTransitionDuration ?? this.controlsTransitionDuration,
      bufferingIndicatorBuilder:
          bufferingIndicatorBuilder ?? this.bufferingIndicatorBuilder,
      volumeIndicatorBuilder:
          volumeIndicatorBuilder ?? this.volumeIndicatorBuilder,
      brightnessIndicatorBuilder:
          brightnessIndicatorBuilder ?? this.brightnessIndicatorBuilder,
      seekIndicatorBuilder: seekIndicatorBuilder ?? this.seekIndicatorBuilder,
      speedUpIndicatorBuilder:
          speedUpIndicatorBuilder ?? this.speedUpIndicatorBuilder,
      topButtonBarMargin: topButtonBarMargin ?? this.topButtonBarMargin,
      bottomButtonBarMargin:
          bottomButtonBarMargin ?? this.bottomButtonBarMargin,
      buttonBarHeight: buttonBarHeight ?? this.buttonBarHeight,
      buttonBarButtonSize: buttonBarButtonSize ?? this.buttonBarButtonSize,
      buttonBarButtonColor: buttonBarButtonColor ?? this.buttonBarButtonColor,
      seekBarMargin: seekBarMargin ?? this.seekBarMargin,
      seekBarHeight: seekBarHeight ?? this.seekBarHeight,
      seekBarContainerHeight:
          seekBarContainerHeight ?? this.seekBarContainerHeight,
      seekBarColor: seekBarColor ?? this.seekBarColor,
      seekBarPositionColor: seekBarPositionColor ?? this.seekBarPositionColor,
      seekBarBufferColor: seekBarBufferColor ?? this.seekBarBufferColor,
      seekBarThumbSize: seekBarThumbSize ?? this.seekBarThumbSize,
      seekBarThumbColor: seekBarThumbColor ?? this.seekBarThumbColor,
      seekBarAlignment: seekBarAlignment ?? this.seekBarAlignment,
      shiftSubtitlesOnControlsVisibilityChange:
          shiftSubtitlesOnControlsVisibilityChange ??
              this.shiftSubtitlesOnControlsVisibilityChange,
    );
  }
}

/// {@template material_video_controls_theme}
///
/// Inherited widget which provides [MaterialVideoControlsThemeData] to descendant widgets.
///
/// {@endtemplate}
class MaterialVideoControlsTheme extends InheritedWidget {
  final MaterialVideoControlsThemeData normal;
  final MaterialVideoControlsThemeData fullscreen;
  const MaterialVideoControlsTheme({
    super.key,
    required this.normal,
    required this.fullscreen,
    required super.child,
  });

  static MaterialVideoControlsTheme? maybeOf(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<MaterialVideoControlsTheme>();
  }

  static MaterialVideoControlsTheme of(BuildContext context) {
    final MaterialVideoControlsTheme? result = maybeOf(context);
    assert(
      result != null,
      'No [MaterialVideoControlsTheme] found in [context]',
    );
    return result!;
  }

  @override
  bool updateShouldNotify(MaterialVideoControlsTheme oldWidget) =>
      identical(normal, oldWidget.normal) &&
      identical(fullscreen, oldWidget.fullscreen);
}

class _PlayOrPauseButton extends StatefulWidget {
  /// Overriden icon size for [MaterialSkipPreviousButton].
  final double? iconSize;

  /// Overriden icon color for [MaterialSkipPreviousButton].
  final Color? iconColor;

  const _PlayOrPauseButton({this.iconSize, this.iconColor});

  @override
  State<_PlayOrPauseButton> createState() => _PlayOrPauseButtonState();
}

class _PlayOrPauseButtonState extends State<_PlayOrPauseButton>
    with SingleTickerProviderStateMixin {
  late final animation = AnimationController(
    vsync: this,
    value: controller(context).value.isPlaying ? 1 : 0,
    duration: const Duration(milliseconds: 200),
  );

  @override
  void setState(VoidCallback fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    controller(context).addListener(
      _playOrPauseAnimation,
    );
  }

  @override
  void dispose() {
    animation.dispose();
    // controller(context).removeListener(_playOrPauseAnimation);
    super.dispose();
  }

  void _playOrPauseAnimation() {
    if (controller(context).value.isPlaying) {
      animation.forward();
    } else {
      animation.reverse();
    }
  }

  void playOrPause() {
    if (controller(context).value.isPlaying) {
      controller(context).pause();
      return;
    }
    controller(context).play();
    return;
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => playOrPause(),
      iconSize: widget.iconSize ?? _theme(context).buttonBarButtonSize,
      color: widget.iconColor ?? _theme(context).buttonBarButtonColor,
      icon: IgnorePointer(
        child: AnimatedIcon(
          progress: animation,
          icon: AnimatedIcons.play_pause,
          size: widget.iconSize ?? _theme(context).buttonBarButtonSize,
          color: widget.iconColor ?? _theme(context).buttonBarButtonColor,
        ),
      ),
    );
  }
}

// BUTTON: FULL SCREEN

/// Material design fullscreen button.
class MaterialFullscreenButton extends StatelessWidget {
  /// Icon for [MaterialFullscreenButton].
  final Widget? icon;

  /// Overriden icon size for [MaterialFullscreenButton].
  final double? iconSize;

  /// Overriden icon color for [MaterialFullscreenButton].
  final Color? iconColor;

  const MaterialFullscreenButton({
    super.key,
    this.icon,
    this.iconSize,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => toggleFullscreen(context),
      icon: icon ??
          (isFullscreen(context)
              ? const Icon(Icons.fullscreen_exit)
              : const Icon(Icons.fullscreen)),
      iconSize: iconSize ?? _theme(context).buttonBarButtonSize,
      color: iconColor ?? _theme(context).buttonBarButtonColor,
    );
  }
}

/// Toggles fullscreen for the [Video] present in the current [BuildContext].
Future<void> toggleFullscreen(BuildContext context) {
  if (isFullscreen(context)) {
    return state(context).defaultExitNativeFullscreen(false);
  } else {
    return state(context).defaultExitNativeFullscreen(true);
  }
}
