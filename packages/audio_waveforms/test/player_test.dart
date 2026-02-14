import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:audio_waveforms/src/base/constants.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final List<MethodCall> methodCalls = <MethodCall>[];
  late PlayerController sut;
  String path = 'audio_file.mp3';
  int noOfSamples = 2;
  double volume = 1.0;
  int duration = 1000;
  bool shouldExtractWaveform = true;
  FinishMode finishMode = FinishMode.loop;

  setUp(() {
    sut = PlayerController();
    const MethodChannel(Constants.methodChannelName)
        .setMockMethodCallHandler((MethodCall call) async {
      methodCalls.add(call);
      switch (call.method) {
        case Constants.preparePlayer:
          return true;
        case Constants.getDuration:
          return duration;
        case Constants.extractWaveformData:
          return [0.0, 0.5];
        case Constants.startPlayer:
          return true;
        case Constants.pausePlayer:
          return true;
        case Constants.stopPlayer:
          return true;
        default:
          return null;
      }
    });
  });

  void clear() {
    methodCalls.clear();
  }

  tearDown(() {
    sut.dispose();
    clear();
  });

  // Test for initial state
  test(
    'Test initial state',
    () {
      expect(sut.waveformData, []);
      expect(sut.playerState, PlayerState.stopped);
      expect(sut.maxDuration, -1);
    },
  );

  // Test prepare player with extracting waveform
  test(
    'Test prepare player with waveform extraction',
    () async {
      await sut.preparePlayer(
        path: path,
        volume: volume,
        shouldExtractWaveform: shouldExtractWaveform,
        noOfSamples: noOfSamples,
      );
      expect(
        methodCalls,
        [
          isMethodCall(Constants.preparePlayer, arguments: {
            Constants.path: path,
            Constants.volume: volume,
            Constants.playerKey: sut.playerKey,
          }),
          isMethodCall(Constants.getDuration, arguments: {
            Constants.durationType: 1,
            Constants.playerKey: sut.playerKey,
          }),
          if (shouldExtractWaveform)
            isMethodCall(Constants.extractWaveformData, arguments: {
              Constants.playerKey: sut.playerKey,
              Constants.path: path,
              Constants.noOfSamples: noOfSamples,
            })
        ],
      );
      expect(sut.playerState, PlayerState.initialized);
    },
  );

  // Start player flow test
  test('should start player', () async {
    await sut.preparePlayer(
      path: path,
      volume: volume,
      shouldExtractWaveform: shouldExtractWaveform,
      noOfSamples: noOfSamples,
    );
    expect(sut.playerState, PlayerState.initialized);
    expect(sut.maxDuration, duration);
    clear();
    await sut.startPlayer(finishMode: finishMode);
    expect(sut.playerState, PlayerState.playing);
    expect(
      methodCalls,
      [
        isMethodCall(Constants.startPlayer, arguments: {
          Constants.playerKey: sut.playerKey,
          Constants.finishMode: finishMode.index,
        })
      ],
    );
  });

  // Pause player flow test
  test(
    'Test pause player',
    () async {
      await sut.preparePlayer(
        path: path,
        volume: volume,
        shouldExtractWaveform: shouldExtractWaveform,
        noOfSamples: noOfSamples,
      );
      expect(sut.playerState, PlayerState.initialized);
      expect(sut.maxDuration, duration);
      await sut.startPlayer(finishMode: finishMode);
      expect(sut.playerState, PlayerState.playing);
      clear();
      await sut.pausePlayer();
      expect(sut.playerState, PlayerState.paused);
      expect(methodCalls, [
        isMethodCall(Constants.pausePlayer, arguments: {
          Constants.playerKey: sut.playerKey,
        })
      ]);
    },
  );

  // Stop player flow test
  test('Test stop player', () async {
    await sut.preparePlayer(
      path: path,
      volume: volume,
      shouldExtractWaveform: shouldExtractWaveform,
      noOfSamples: noOfSamples,
    );
    await sut.startPlayer(finishMode: finishMode);
    clear();
    await sut.stopPlayer();
    expect(
      methodCalls,
      [
        isMethodCall(Constants.stopPlayer, arguments: {
          Constants.playerKey: sut.playerKey,
        })
      ],
    );
    expect(sut.playerState, PlayerState.stopped);
  });
}
