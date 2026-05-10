import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'dart:io';

import 'package:yamtaz/core/constants/colors.dart';

enum RecordingState { idle, recording, recorded }

class RecorderPlayerWidget extends StatefulWidget {
  final Function(String?) onRecordingComplete;
  final RecorderController recorderController;
  final PlayerController playerController;
  final bool isDark;

  const RecorderPlayerWidget({super.key, 
    required this.onRecordingComplete,
    required this.recorderController,
    required this.playerController,
    this.isDark = false,
  });

  @override
  _RecorderPlayerWidgetState createState() => _RecorderPlayerWidgetState();
}

class _RecorderPlayerWidgetState extends State<RecorderPlayerWidget> {
  final StopWatchTimer _stopWatchTimer = StopWatchTimer();
  static const int _maxRecordingDuration =
      2 * 60 * 1000; // 2 minutes in milliseconds

  String? path;
  bool isRecoded = false;
  bool isRecording = false;
  bool isRecordingCompleted = false;
  bool isLoading = true;
  bool isPlaybackInProgress = false;
  String recordingTime = "00:00";
  late Directory appDirectory;

  Timer? _maxDurationTimer;
  RecordingState _recordingState = RecordingState.idle;

  @override
  void initState() {
    super.initState();
    _getDir();
    _initialiseControllers();
  }

  void _getDir() async {
    appDirectory = await getApplicationDocumentsDirectory();
    path = "${appDirectory.path}/recording.m4a";
    isLoading = false;
    if (mounted) {
      setState(() {});
    }
  }

  void _initialiseControllers() {
    widget.recorderController
      ..androidEncoder = AndroidEncoder.aac
      ..androidOutputFormat = AndroidOutputFormat.mpeg4
      ..iosEncoder = IosEncoder.kAudioFormatMPEG4AAC
      ..sampleRate = 44100;

    widget.recorderController.onCurrentDuration.listen((duration) {
      if (mounted) {
        setState(() {
          recordingTime = _formatDuration(duration);
        });
      }
    });

    widget.playerController.onPlayerStateChanged.listen((state) {
        if(mounted){
            setState(() {
                isPlaybackInProgress = state.isPlaying;
            });
        }
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  void _deleteRecording() {
    if (mounted) {
      setState(() {
        isRecording = false;
        isRecoded = false;
        isRecordingCompleted = false;
        isPlaybackInProgress = false;
        recordingTime = "00:00";
        widget.playerController.stopPlayer();
        widget.recorderController.reset();
      });
      widget.onRecordingComplete(null);
    }
  }

  void startTimer() {
    _startOrStopRecording();
    _maxDurationTimer?.cancel();
    _maxDurationTimer = Timer(const Duration(seconds: 120), () {
      if (isRecording) {
        _startOrStopRecording();
      }
    });
  }

  Future<void> _playOrPauseRecording() async {
    try {
      if (path == null) return;

      if (widget.playerController.playerState.isPlaying) {
        await widget.playerController.pausePlayer();
      } else {
        if (widget.playerController.playerState == PlayerState.stopped ||
            widget.playerController.playerState == PlayerState.initialized) {
          await widget.playerController.preparePlayer(path: path!);
        }
        await widget.playerController.startPlayer();
      }
    } catch (e) {
      debugPrint("Error during playback: $e");
    }
  }

  Future<void> _startOrStopRecording() async {
    isRecoded = true;
    try {
      if (isRecording) {
        path = await widget.recorderController.stop(false);

        if (path != null) {
          isRecordingCompleted = true;
          if (mounted) setState(() => _recordingState = RecordingState.recorded);
          widget.onRecordingComplete(path);
        }
      } else {
        await widget.recorderController.record(path: path);
        if (mounted) setState(() => _recordingState = RecordingState.recording);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      if (mounted) {
        setState(() {
          isRecording = !isRecording;
        });
      }
    }
  }

  @override
  void dispose() {
    _maxDurationTimer?.cancel();
    _stopWatchTimer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (isRecordingCompleted) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: widget.isDark ? const Color(0xFF0F2D37) : const Color(0xFF042029), 
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            // Delete (Trash) button with red circle background
            GestureDetector(
              onTap: _deleteRecording,
              child: Container(
                padding: EdgeInsets.all(6.w),
                decoration: const BoxDecoration(
                  color: Color(0xFF421212), // Dark Red/Brown background
                  shape: BoxShape.circle,
                ),
                child: Icon(CupertinoIcons.trash_fill, color: const Color(0xFFD32F2F), size: 18.sp),
              ),
            ),
            SizedBox(width: 12.w),
            Text(
              recordingTime,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.sp,
                fontFamily: 'Cairo',
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: AudioFileWaveforms(
                size: Size(double.infinity, 30.h),
                playerController: widget.playerController,
                waveformType: WaveformType.long,
                playerWaveStyle: PlayerWaveStyle(
                  fixedWaveColor: widget.isDark ? Colors.white.withOpacity(0.3) : const Color(0xFFD4AF37).withOpacity(0.3),
                  liveWaveColor: widget.isDark ? Colors.white : const Color(0xFFD4AF37),
                  spacing: 4,
                  waveThickness: 2,
                ),
              ),
            ),
            IconButton(
              onPressed: _playOrPauseRecording,
              icon: Icon(
                isPlaybackInProgress ? CupertinoIcons.pause_fill : CupertinoIcons.play_fill,
                color: widget.isDark ? Colors.white : const Color(0xFFD4AF37),
              ),
            ),
          ],
        ),
      );
    }

    if (isRecording) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        decoration: BoxDecoration(
          color: const Color(0xFF042029),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          children: [
            Text(
              recordingTime,
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.sp,
                fontFamily: 'Cairo',
              ),
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: AudioWaveforms(
                enableGesture: true,
                size: Size(double.infinity, 30.h),
                recorderController: widget.recorderController,
                waveStyle: WaveStyle(
                  waveColor: const Color(0xFFD4AF37),
                  waveCap: StrokeCap.round,
                  waveThickness: 4.0,
                  extendWaveform: true,
                  showMiddleLine: false,
                ),
              ),
            ),
            IconButton(
              onPressed: _startOrStopRecording,
              icon: Icon(CupertinoIcons.stop_fill, color: const Color(0xFFD4AF37)),
            ),
          ],
        ),
      );
    }

    return GestureDetector(
      onTap: startTimer,
      child: Container(
        padding: EdgeInsets.all(16.h),
        decoration: BoxDecoration(
          color: const Color(0xFFFAF6E9),
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(color: const Color(0xFFD4AF37).withOpacity(0.3)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(CupertinoIcons.mic_fill, color: const Color(0xFFD4AF37)),
            SizedBox(width: 8.w),
            Text(
              "تسجيل صوتي",
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFFD4AF37),
                fontFamily: 'Cairo',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
