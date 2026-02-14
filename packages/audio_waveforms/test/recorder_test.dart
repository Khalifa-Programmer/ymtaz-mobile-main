import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:audio_waveforms/src/base/constants.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final List<MethodCall> methodCalls = <MethodCall>[];
  late RecorderController sut;
  void clear() {
    methodCalls.clear();
  }

  setUp(() {
    sut = RecorderController();
    const MethodChannel(Constants.methodChannelName)
        .setMockMethodCallHandler((MethodCall call) async {
      methodCalls.add(call);
      switch (call.method) {
        case Constants.startRecording:
          return true;
        case Constants.checkPermission:
          return true;
        default:
          return null;
      }
    });
  });

  tearDown(() {
    sut.dispose();
    clear();
  });

  // Test for initial state
  test('Test initial state', () {
    expect(sut.recorderState, RecorderState.stopped);
    expect(sut.waveData, []);
  });

  // Test record function
  test('Test record audio', () {
    sut.record();
    expect(methodCalls, [
      isMethodCall(Constants.checkPermission, arguments: null),
      // isMethodCall(Constants.startRecording, arguments: null),
    ]);
    expect(sut.recorderState, RecorderState.initialized);
    // expect(sut.recorderState, RecorderState.recording);
  });
}
