import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/widgets/spacing.dart';

class AudioPlayerWidget extends StatefulWidget {
  final String audioUrl;
  
  final Color? backgroundColor;
  
  final Color? activeWaveColor;
  
  final Color? inactiveWaveColor;
  
  final Color? playButtonColor;
  
  final Color? indicatorColor;

  const AudioPlayerWidget({
    Key? key,
    required this.audioUrl,
    this.backgroundColor,
    this.activeWaveColor,
    this.inactiveWaveColor,
    this.playButtonColor,
    this.indicatorColor,
  }) : super(key: key);

  @override
  State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
}

class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  final ValueNotifier<Duration> _duration = ValueNotifier<Duration>(Duration.zero);
  final ValueNotifier<Duration> _position = ValueNotifier<Duration>(Duration.zero);
  final ValueNotifier<PlayerState> _playerState = ValueNotifier<PlayerState>(PlayerState.stopped);
  final ValueNotifier<bool> _isLoading = ValueNotifier<bool>(false);
  
  // إضافة متغيرات للاشتراكات لإلغائها لاحقاً
  StreamSubscription<Duration>? _durationSubscription;
  StreamSubscription<Duration>? _positionSubscription;
  StreamSubscription<PlayerState>? _playerStateSubscription;
  bool _isDisposed = false;

  @override
  void initState() {
    super.initState();
    _setupAudioPlayer();
  }

  void _setupAudioPlayer() {
    // استخدام متغيرات الاشتراك لتخزين الاشتراكات
    _durationSubscription = _audioPlayer.onDurationChanged.listen((Duration d) {
      if (!_isDisposed) {
        _duration.value = d;
      }
    });

    _positionSubscription = _audioPlayer.onPositionChanged.listen((Duration p) {
      if (!_isDisposed) {
        _position.value = p;
      }
    });

    _playerStateSubscription = _audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      if (!_isDisposed) {
        _playerState.value = state;
      }
    });
  }

  @override
  void dispose() {
    // تعيين المتغير للإشارة إلى أن الـ widget تم التخلص منه
    _isDisposed = true;
    
    // إلغاء الاشتراكات
    _durationSubscription?.cancel();
    _positionSubscription?.cancel();
    _playerStateSubscription?.cancel();
    
    // إيقاف المشغل
    _audioPlayer.stop();
    _audioPlayer.dispose();
    
    // التخلص من الـ ValueNotifier
    _duration.dispose();
    _position.dispose();
    _playerState.dispose();
    _isLoading.dispose();
    
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.h),
      child: ValueListenableBuilder<PlayerState>(
        valueListenable: _playerState,
        builder: (context, state, _) {
          return ValueListenableBuilder<Duration>(
            valueListenable: _position,
            builder: (context, positionValue, _) {
              return ValueListenableBuilder<Duration>(
                valueListenable: _duration,
                builder: (context, durationValue, _) {
                  return ValueListenableBuilder<bool>(
                    valueListenable: _isLoading,
                    builder: (context, isLoadingValue, _) {
                      final double progress = durationValue.inMilliseconds > 0
                          ? positionValue.inMilliseconds / durationValue.inMilliseconds
                          : 0.0;
                      
                      return Container(
                        decoration: BoxDecoration(
                          color: widget.backgroundColor ?? appColors.white,
                          borderRadius: BorderRadius.circular(8.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.08),
                              spreadRadius: 0.5,
                              blurRadius: 2,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
                        child: Row(
                          children: [
                            _buildPlayButton(state, isLoadingValue),
                            horizontalSpace(6.w),
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  _buildWaveformProgress(progress, positionValue, durationValue),
                                  verticalSpace(3.h),
                                  _buildTimeInfo(positionValue, durationValue),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildPlayButton(PlayerState state, bool isLoading) {
    return Container(
      width: 32.w,
      height: 32.h,
      decoration: BoxDecoration(
        color: widget.playButtonColor ?? appColors.primaryColorYellow,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: (widget.playButtonColor ?? appColors.primaryColorYellow).withOpacity(0.2),
            spreadRadius: 0.5,
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16.r),
          onTap: _handlePlayButtonTap,
          child: Center(
            child: isLoading
                ? SizedBox(
                    width: 16.w,
                    height: 16.h,
                    child: CircularProgressIndicator(
                      color: appColors.white,
                      strokeWidth: 2,
                    ),
                  )
                : Icon(
                    state == PlayerState.playing
                        ? Icons.pause
                        : Icons.play_arrow,
                    color: appColors.white,
                    size: 18.sp,
                  ),
          ),
        ),
      ),
    );
  }

  Future<void> _handlePlayButtonTap() async {
    if (_isDisposed) return;
    
    if (_playerState.value == PlayerState.playing) {
      await _audioPlayer.pause();
    } else if (_playerState.value == PlayerState.paused) {
      await _audioPlayer.resume();
    } else {
      _isLoading.value = true;
      try {
        await _audioPlayer.play(UrlSource(widget.audioUrl));
      } catch (e) {
        debugPrint('Error playing audio: $e');
      } finally {
        if (!_isDisposed) {
          _isLoading.value = false;
        }
      }
    }
  }

  Widget _buildTimeInfo(Duration position, Duration duration) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          _formatDuration(position),
          style: TextStyles.cairo_10_regular.copyWith(color: appColors.grey15, fontSize: 8.sp),
        ),
        Text(
          " / ",
          style: TextStyles.cairo_10_regular.copyWith(color: appColors.grey15, fontSize: 8.sp),
        ),
        Text(
          _formatDuration(duration),
          style: TextStyles.cairo_10_regular.copyWith(color: appColors.grey15, fontSize: 8.sp),
        ),
      ],
    );
  }

  Widget _buildWaveformProgress(
      double progress, Duration position, Duration duration) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          onTapDown: (details) => _handleProgressTap(details, constraints, duration),
          onHorizontalDragUpdate: (details) => _handleProgressDrag(details, constraints, duration),
          child: Container(
            height: 24.h,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4.r),
              color: (widget.inactiveWaveColor ?? appColors.lightYellow10).withOpacity(0.15),
            ),
            child: Stack(
              children: [
                // الموجات الصوتية
                CustomPaint(
                  size: Size(constraints.maxWidth, 24.h),
                  painter: WhatsAppStyleWaveformPainter(
                    progress: progress,
                    activeColor: widget.activeWaveColor ?? appColors.primaryColorYellow,
                    inactiveColor: widget.inactiveWaveColor ?? appColors.grey15.withOpacity(0.2),
                  ),
                ),
                // المؤشر المتحرك
                Positioned(
                  left: constraints.maxWidth * progress - 0.5.w,
                  top: 0,
                  bottom: 0,
                  child: Container(
                    width: 1.w,
                    decoration: BoxDecoration(
                      color: widget.indicatorColor ?? appColors.blue100.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(0.5.r),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _handleProgressTap(TapDownDetails details, BoxConstraints constraints, Duration duration) {
    if (_isDisposed) return;
    
    if (duration.inMilliseconds > 0) {
      final double touchProgress = (details.localPosition.dx / constraints.maxWidth).clamp(0.0, 1.0);
      final int newPositionMs = (touchProgress * duration.inMilliseconds).round();
      _audioPlayer.seek(Duration(milliseconds: newPositionMs));
    }
  }

  void _handleProgressDrag(DragUpdateDetails details, BoxConstraints constraints, Duration duration) {
    if (_isDisposed) return;
    
    if (duration.inMilliseconds > 0) {
      final double touchProgress = (details.localPosition.dx / constraints.maxWidth).clamp(0.0, 1.0);
      final int newPositionMs = (touchProgress * duration.inMilliseconds).round();
      _audioPlayer.seek(Duration(milliseconds: newPositionMs));
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }
}

class WhatsAppStyleWaveformPainter extends CustomPainter {
  final double progress;
  final Color activeColor;
  final Color inactiveColor;

  WhatsAppStyleWaveformPainter({
    required this.progress,
    required this.activeColor,
    required this.inactiveColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final Paint activePaint = Paint()
      ..color = activeColor
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2;

    final Paint inactivePaint = Paint()
      ..color = inactiveColor
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 2;

    final double width = size.width;
    final double height = size.height;
    final double centerY = height / 2;
    
    final int barCount = 60;
    final double barWidth = width / barCount;
    final int progressIndex = (barCount * progress).floor();

    for (int i = 0; i < barCount; i++) {
      double barHeight;
      
      if (i % 4 == 0) {
        barHeight = height * 0.7;
      } else if (i % 3 == 0) {
        barHeight = height * 0.5;
      } else if (i % 2 == 0) {
        barHeight = height * 0.3;
      } else {
        barHeight = height * 0.2;
      }
      
      final double randomFactor = (i % 5) * 0.05;
      barHeight = barHeight * (0.8 + randomFactor);
      
      final double barX = i * barWidth + barWidth / 2;
      final double topY = centerY - barHeight / 2;
      final double bottomY = centerY + barHeight / 2;

      canvas.drawLine(
        Offset(barX, topY),
        Offset(barX, bottomY),
        i <= progressIndex ? activePaint : inactivePaint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant WhatsAppStyleWaveformPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
} 