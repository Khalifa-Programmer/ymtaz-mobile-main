import 'dart:async';
import 'package:flutter/material.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'dart:io';

import 'package:yamtaz/core/constants/colors.dart';

enum RecordingState { idle, recording, recorded }

class RecorderPlayerWidget extends StatefulWidget {
  final Function(String?) onRecordingComplete;
  final RecorderController recorderController;
  final PlayerController playerController;

  const RecorderPlayerWidget({super.key, 
    required this.onRecordingComplete,
    required this.recorderController,
    required this.playerController,
  });

  @override
  _RecorderPlayerWidgetState createState() => _RecorderPlayerWidgetState();
}

class _RecorderPlayerWidgetState extends State<RecorderPlayerWidget> {
  final StopWatchTimer _stopWatchTimer = StopWatchTimer();
  static const int _maxRecordingDuration =
      3 * 60 * 1000; // 3 minutes in milliseconds

  String? path;
  bool isRecoded = false;
  bool isRecording = false;
  bool isRecordingCompleted = false;
  bool isLoading = true;
  bool isPlaybackInProgress = false;
  String recordingTime = "00:00";
  late Directory appDirectory;

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
    setState(() {});
  }

  void _initialiseControllers() {
    widget.recorderController
      ..androidEncoder = AndroidEncoder.aac
      ..androidOutputFormat = AndroidOutputFormat.mpeg4
      ..iosEncoder = IosEncoder.kAudioFormatMPEG4AAC
      ..sampleRate = 44100;

    // Listen to recording duration updates
    widget.recorderController.onCurrentDuration.listen((duration) {
      setState(() {
        recordingTime = _formatDuration(duration);
      });
    });
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "$twoDigitMinutes:$twoDigitSeconds";
  }

  void _deleteRecording() {
    setState(() {
      isRecording = false;
      isRecoded = false;
      isRecordingCompleted = false;
      isPlaybackInProgress = false;
      recordingTime = "00:00";
      widget.playerController.stopPlayer();
      widget.recorderController.reset();
    });
  }

  void startTimer() {
    _startOrStopRecording();
    Timer(Duration(seconds: 180), () {
      _startOrStopRecording();
    });
  }

  Future<void> _playOrPauseRecording() async {
    try {
      if (path == null) return;

      if (widget.playerController.playerState.isPlaying) {
        await widget.playerController.pausePlayer();
        setState(() {
          isPlaybackInProgress = false;
        });
      } else {
        if (widget.playerController.playerState == PlayerState.stopped ||
            widget.playerController.playerState == PlayerState.initialized) {
          await widget.playerController.preparePlayer(path: path!);
        }
        await widget.playerController.startPlayer();
        setState(() {
          isPlaybackInProgress = true;
        });
      }
    } catch (e) {
      debugPrint("Error during playback: $e");
    }
  }

  Future<void> _startOrStopRecording() async {
    isRecoded = true;
    try {
      if (isRecording) {
        widget.recorderController.reset();
        path = await widget.recorderController.stop(false);

        if (path != null) {
          isRecordingCompleted = true;
          setState(() => _recordingState = RecordingState.recorded);
          widget.onRecordingComplete(path);
        }
      } else {
        await widget.recorderController.record(path: path);
        setState(() => _recordingState = RecordingState.recording);
      }
    } catch (e) {
      debugPrint(e.toString());
    } finally {
      setState(() {
        isRecording = !isRecording;
      });
    }
  }

  @override
  void dispose() {
    widget.recorderController.dispose();
    widget.playerController.dispose();
    _stopWatchTimer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (isRecordingCompleted)
          Container(
            decoration: BoxDecoration(
              color: appColors.lightYellow10,
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: appColors.primaryColorYellow),
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: _deleteRecording,
                  icon: Icon(Icons.delete, color: Colors.red),
                ),
                Expanded(
                  child: AudioFileWaveforms(
                    size: Size(MediaQuery.of(context).size.width / 2, 30),
                    playerController: widget.playerController,
                    waveformType: WaveformType.long,
                    playerWaveStyle: PlayerWaveStyle(
                      fixedWaveColor:
                          appColors.primaryColorYellow.withOpacity(0.5),
                      liveWaveColor: appColors.primaryColorYellow,
                      seekLineColor: appColors.red,
                    ),
                  ),
                ),
                Text(recordingTime,
                    style: TextStyle(fontWeight: FontWeight.bold)),
                IconButton(
                  onPressed: _playOrPauseRecording,
                  icon: Icon(
                    isPlaybackInProgress ? Icons.pause : Icons.play_arrow,
                    color: appColors.primaryColorYellow,
                  ),
                ),
              ],
            ),
          )
        else
          Row(
            children: [
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 200),
                  child: isRecording
                      ? Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: appColors.lightYellow10,
                            borderRadius: BorderRadius.circular(12.0),
                            border:
                                Border.all(color: appColors.primaryColorYellow),
                          ),
                          child: Row(
                            children: [
                              Text(recordingTime,
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              SizedBox(width: 10),
                              Expanded(
                                child: AudioWaveforms(
                                  enableGesture: true,
                                  size: Size(
                                      MediaQuery.of(context).size.width / 2,
                                      30),
                                  recorderController: widget.recorderController,
                                  waveStyle: WaveStyle(
                                    waveColor: appColors.primaryColorYellow,
                                    waveCap: StrokeCap.round,
                                    waveThickness: 4.0,
                                    extendWaveform: true,
                                    showMiddleLine: false,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      : GestureDetector(
                          onTap: startTimer,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: appColors.lightYellow10,
                              borderRadius: BorderRadius.circular(12.0),
                              border: Border.all(
                                  color: appColors.primaryColorYellow),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.mic,
                                    color: appColors.primaryColorYellow),
                                SizedBox(width: 10),
                                Text("تسجيل صوتي",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ),
                        ),
                ),
              ),
              if (isRecording)
                IconButton(
                  onPressed: _startOrStopRecording,
                  icon: Icon(Icons.stop),
                  color: appColors.primaryColorYellow,
                ),
            ],
          ),
      ],
    );
  }
}
