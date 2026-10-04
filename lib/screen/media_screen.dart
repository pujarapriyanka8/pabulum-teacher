import 'dart:async';

import 'package:audioplayers/audioplayers.dart' as audio;
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:pabulum_teacher/utils/app_color.dart';
import 'package:pabulum_teacher/utils/constants.dart';
import 'package:pabulum_teacher/utils/utils.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart' as yt;

class MediaScreen extends StatefulWidget {
  const MediaScreen({super.key,
    required this.type,
    required this.url,
  });

  final ClassworkMediaType type;
  final String url;

  @override
  State<MediaScreen> createState() => MediaScreenState();
}

class MediaScreenState extends State<MediaScreen>
    with WidgetsBindingObserver {
  VideoPlayerController? _videoController;
  ChewieController? _chewieController;
  yt.YoutubePlayerController? _youtubeController;

  String? _error;

  String get _title {
    switch (widget.type) {
      case ClassworkMediaType.image:
        return 'Classwork image';
      case ClassworkMediaType.video:
      case ClassworkMediaType.youtube:
        return 'Classwork video';
      case ClassworkMediaType.audio:
        return 'Classwork audio';
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    if (widget.type == ClassworkMediaType.video) {
      _loadVideo();
    } else if (widget.type == ClassworkMediaType.youtube) {
      final videoId = yt.YoutubePlayer.convertUrlToId(widget.url);

      if (videoId == null || videoId.isEmpty) {
        _error = 'Invalid YouTube link.';
      } else {
        _youtubeController = yt.YoutubePlayerController(
          initialVideoId: videoId,
          flags: const yt.YoutubePlayerFlags(
            autoPlay: false,
            mute: false,
          ),
        );
      }
    }
  }

  Future<void> _loadVideo() async {
    try {
      final controller = VideoPlayerController.networkUrl(
        Uri.parse(widget.url),
      );

      _videoController = controller;

      await controller.initialize();
      if (!mounted) return;

      _chewieController = ChewieController(
        videoPlayerController: controller,
        autoPlay: false,
        looping: false,
        allowFullScreen: true,
        allowMuting: true,
        showControls: true,
        materialProgressColors: ChewieProgressColors(
          playedColor: AppColors.colorPurple,
          handleColor: AppColors.colorPurple,
          bufferedColor: const Color(0xFFBDB2E4),
          backgroundColor: const Color(0xFFDFDAED),
        ),
        errorBuilder: (_, __) {
          return _buildMessage('Unable to play this video.');
        },
      );

      setState(() {});
    } catch (_) {
      if (!mounted) return;

      setState(() {
        _error = 'Unable to load this video.';
      });
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _pauseVideo();
      _youtubeController?.pause();
    }
  }

  Future<void> _pauseVideo() async {
    try {
      await _videoController?.pause();
    } catch (_) {
      // The controller may already be closing.
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    _chewieController?.dispose();
    _videoController?.dispose();
    _youtubeController?.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_youtubeController != null) {
      return yt.YoutubePlayerBuilder(
        player: yt.YoutubePlayer(
          controller: _youtubeController!,
          showVideoProgressIndicator: true,
          progressIndicatorColor: AppColors.colorPurple,
          progressColors:  yt.ProgressBarColors(
            playedColor: AppColors.colorPurple,
            handleColor: AppColors.colorPurple,
          ),
        ),
        builder: (_, player) {
          return _buildScaffold(_buildVideoBody(player));
        },
      );
    }

    return _buildScaffold(_buildBody());
  }

  Widget _buildScaffold(Widget child) {
    return Scaffold(
      backgroundColor: AppColors.navy,
      appBar: AppBar(
        backgroundColor: AppColors.navy,
        foregroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        title: Text(
          _title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SafeArea(
        top: false,
        child: child,
      ),
    );
  }

  Widget _buildBody() {
    if (_error != null) {
      return _buildMessage(_error!);
    }

    switch (widget.type) {
      case ClassworkMediaType.image:
        return _buildImage();



      case ClassworkMediaType.video:
        if (_chewieController == null) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        }

        return _buildVideoBody(
          AspectRatio(
            aspectRatio: _videoController!.value.aspectRatio,
            child: Chewie(
              controller: _chewieController!,
            ),
          ),
        );

      case ClassworkMediaType.youtube:
        return _buildMessage('Unable to open this YouTube video.');

      case ClassworkMediaType.audio:
        return const SizedBox.shrink();
    }
  }

  Widget _buildImage() {
    return Column(
      children: [
        Expanded(
          child: LayoutBuilder(
            builder: (_, constraints) {
              return InteractiveViewer(
                minScale: 1,
                maxScale: 5,
                child: SizedBox(
                  width: constraints.maxWidth,
                  height: constraints.maxHeight,
                  child: Image.network(
                    widget.url,
                    fit: BoxFit.contain,
                    loadingBuilder: (_, child, progress) {
                      if (progress == null) return child;

                      return const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      );
                    },
                    errorBuilder: (_, __, ___) {
                      return _buildMessage(
                        'Unable to load this image.',
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.zoom_in_rounded,
                color: Colors.white70,
                size: 21,
              ),
              SizedBox(width: 8),
              Text(
                'Pinch to zoom',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildVideoBody(Widget player) {
    final isYoutube = widget.type == ClassworkMediaType.youtube;

    return ColoredBox(
      color: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          ColoredBox(
            color: Colors.black,
            child: player,
          ),
          Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text(
                  'Supporting video',
                  style: TextStyle(
                    color: AppColors.navy,
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Icon(
                      isYoutube
                          ? Icons.smart_display_rounded
                          : Icons.video_library_outlined,
                      color: isYoutube ? Colors.red : AppColors.colorPurple,
                      size: 22,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      isYoutube ? 'YouTube' : 'Classwork video',
                      style:  TextStyle(
                        color: AppColors.colorMuted,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessage(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

// Audio bottom sheet.

class AudioSheet extends StatefulWidget {
  const AudioSheet({
    required this.url,
  });

  final String url;

  @override
  State<AudioSheet> createState() => AudioSheetState();
}

class AudioSheetState extends State<AudioSheet>
    with WidgetsBindingObserver {
  final audio.AudioPlayer _player = audio.AudioPlayer();

  final List<StreamSubscription<dynamic>> _subscriptions = [];

  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  bool _loading = true;
  bool _playing = false;
  bool _completed = false;

  double? _dragPosition;
  String? _error;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _subscriptions.add(
      _player.onDurationChanged.listen((value) {
        if (!mounted) return;
        setState(() => _duration = value);
      }),
    );

    _subscriptions.add(
      _player.onPositionChanged.listen((value) {
        if (!mounted) return;
        setState(() => _position = value);
      }),
    );

    _subscriptions.add(
      _player.onPlayerStateChanged.listen((value) {
        if (!mounted) return;

        setState(() {
          _playing = value == audio.PlayerState.playing;
        });
      }),
    );

    _subscriptions.add(
      _player.onPlayerComplete.listen((_) {
        if (!mounted) return;

        setState(() {
          _playing = false;
          _completed = true;
          _position = _duration;
        });
      }),
    );

    _loadAudio();
  }

  Future<void> _loadAudio() async {
    setState(() {
      _loading = true;
      _error = null;
      _completed = false;
      _position = Duration.zero;
      _duration = Duration.zero;
    });

    try {
      await _player.setReleaseMode(audio.ReleaseMode.stop);
      if (!mounted) return;

      await _player.setSource(
        audio.UrlSource(widget.url),
      );
      if (!mounted) return;

      final duration = await _player.getDuration();
      if (!mounted) return;

      setState(() {
        _duration = duration ?? Duration.zero;
        _loading = false;
      });
    } catch (_) {
      _handleError();
    }
  }

  Future<void> _togglePlayback() async {
    try {
      if (_playing) {
        await _player.pause();
      } else {
        if (_completed) {
          await _player.seek(Duration.zero);
          if (!mounted) return;

          setState(() {
            _completed = false;
            _position = Duration.zero;
          });
        }

        if (!mounted) return;
        await _player.resume();
      }
    } catch (_) {
      _handleError();
    }
  }

  Future<void> _seekTo(double milliseconds) async {
    final maximum = _duration.inMilliseconds;
    if (maximum <= 0) return;

    final target = milliseconds.clamp(0, maximum).round();

    try {
      await _player.seek(
        Duration(milliseconds: target),
      );
      if (!mounted) return;

      setState(() {
        _position = Duration(milliseconds: target);
        _completed = false;
        _dragPosition = null;
      });
    } catch (_) {
      _handleError();
    }
  }

  void _skip(int seconds) {
    _seekTo(
      (_position.inMilliseconds + seconds * 1000).toDouble(),
    );
  }

  void _handleError() {
    if (!mounted) return;

    setState(() {
      _loading = false;
      _playing = false;
      _dragPosition = null;
      _error = 'Unable to play this audio.';
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _pauseAudio();
    }
  }

  Future<void> _pauseAudio() async {
    try {
      await _player.pause();
    } catch (_) {
      // The player may already be closing.
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    for (final subscription in _subscriptions) {
      subscription.cancel();
    }

    _player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final maximum = _duration.inMilliseconds.toDouble();
    final sliderMaximum = maximum > 0 ? maximum : 1.0;

    final sliderValue = (_dragPosition ??
        _position.inMilliseconds.toDouble())
        .clamp(0.0, sliderMaximum)
        .toDouble();

    return SafeArea(
      top: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 38,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFFCBD0DA),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 20),
            _buildHeader(),
            const SizedBox(height: 24),

            if (_loading)
               Padding(
                padding: EdgeInsets.all(24),
                child: CircularProgressIndicator(
                  color: AppColors.colorPurple,
                ),
              )
            else if (_error != null) ...[
              Text(
                _error!,
                style:  TextStyle(color: AppColors.colorMuted),
              ),
              TextButton(
                onPressed: _loadAudio,
                child: const Text('Retry'),
              ),
            ] else ...[
              _buildSoundBars(
                maximum > 0 ? sliderValue / maximum : 0,
              ),
              const SizedBox(height: 16),
              Slider(
                min: 0,
                max: sliderMaximum,
                value: sliderValue,
                activeColor: AppColors.colorPurple,
                inactiveColor: const Color(0xFFE1DAF4),
                onChanged: maximum > 0
                    ? (value) {
                  setState(() => _dragPosition = value);
                }
                    : null,
                onChangeEnd: maximum > 0 ? _seekTo : null,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      Utils.durationText(
                        Duration(
                          milliseconds: sliderValue.round(),
                        ),
                      ),
                      style:  TextStyle(
                        color: AppColors.colorMuted,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      maximum > 0
                          ? Utils.durationText(_duration)
                          : '--:--',
                      style:  TextStyle(
                        color: AppColors.colorMuted,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              _buildControls(maximum > 0),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: const BoxDecoration(
            color: Color(0xFFDFF3E9),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.music_note_rounded,
            color: Color(0xFF178564),
            size: 27,
          ),
        ),
        const SizedBox(width: 12),
         Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Classwork audio',
                style: TextStyle(
                  color: AppColors.navy,
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: 4),
              Text(
                'Audio attachment',
                style: TextStyle(
                  color: AppColors.colorMuted,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          tooltip: 'Close audio',
          onPressed: () => Navigator.of(context).pop(),
          icon:  Icon(
            Icons.close_rounded,
            color: AppColors.navy,
          ),
        ),
      ],
    );
  }

  Widget _buildControls(bool canSeek) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          tooltip: 'Back 10 seconds',
          onPressed: canSeek ? () => _skip(-10) : null,
          iconSize: 31,
          color: AppColors.navy,
          icon: const Icon(Icons.replay_10_rounded),
        ),
        const SizedBox(width: 28),
        Material(
          color: AppColors.colorPurple,
          shape: const CircleBorder(),
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: _togglePlayback,
            child: SizedBox(
              width: 62,
              height: 62,
              child: Icon(
                _playing
                    ? Icons.pause_rounded
                    : _completed
                    ? Icons.replay_rounded
                    : Icons.play_arrow_rounded,
                color: Colors.white,
                size: 34,
                semanticLabel: _playing
                    ? 'Pause'
                    : _completed
                    ? 'Replay'
                    : 'Play',
              ),
            ),
          ),
        ),
        const SizedBox(width: 28),
        IconButton(
          tooltip: 'Forward 10 seconds',
          onPressed: canSeek ? () => _skip(10) : null,
          iconSize: 31,
          color: AppColors.navy,
          icon: const Icon(Icons.forward_10_rounded),
        ),
      ],
    );
  }

  Widget _buildSoundBars(double progress) {
    // Decorative bars, not the audio's actual waveform.
    const heights = <double>[10, 18, 27, 15, 33, 22, 37];

    return ExcludeSemantics(
      child: SizedBox(
        height: 38,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(35, (index) {
            return Expanded(
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 2),
                height: heights[index % heights.length],
                decoration: BoxDecoration(
                  color: index / 35 < progress
                      ? AppColors.colorPurple
                      : const Color(0xFFE1DAF4),
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}