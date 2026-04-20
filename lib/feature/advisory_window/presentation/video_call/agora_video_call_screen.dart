import 'dart:async';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/constants/colors.dart';
import '../../../../config/themes/styles.dart';
import 'rating_screen.dart';

import '../../../../core/DI/dependency_injection.dart' as import_di;
import '../../../../feature/ymtaz_elite/logic/call_cubit.dart' as import_call_cubit;

const appId = "0d6fe83ed45142488b70a9d477fbcb6b";
const token =
    "007eJxTYDhzhMnllCuLYmD4izX35UxvflryYZuLTJ7oy3mr7r4qFdyqwGCQYpaWamGcmmJiamhiZGJhkWRukGiZYmJunpaUnGSWNP/O9syGQEaGpMPpjIwMEAjiszJE5pYkVjEwAADQ2SHJ";
const channelName = "Ymtaz";

class AgoraVideoCallScreen extends StatefulWidget {
  final String? customToken;
  final String? customChannelName;
  final String? callId;

  const AgoraVideoCallScreen(
      {Key? key, this.customToken, this.customChannelName, this.callId})
      : super(key: key);

  @override
  State<AgoraVideoCallScreen> createState() => _AgoraVideoCallScreenState();
}

class _AgoraVideoCallScreenState extends State<AgoraVideoCallScreen>
    with WidgetsBindingObserver {
  int? _remoteUid;
  bool _localUserJoined = false;
  bool _muted = false;
  bool _videoDisabled = false;

  late RtcEngine _engine;

  /// True only after [_engine] has been fully initialised and preview started.
  /// Guards every engine call that may fire before init completes (e.g. lifecycle callbacks).
  bool _engineInitialized = false;

  /// Prevents rapid successive switchCamera calls that cause BufferQueue abandoned.
  bool _isSwitchingCamera = false;

  /// Incremented after each camera switch to force AgoraVideoView rebuild,
  /// binding to the new SurfaceTexture after the old one is abandoned.
  int _localVideoKey = 0;

  // ─── Lifecycle ────────────────────────────────────────────────────────────

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    initAgora();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (!_engineInitialized) return;

    if (state == AppLifecycleState.paused) {
      // Only stop the camera capture — do NOT call disableVideo() as it
      // destroys the entire video pipeline and AgoraVideoView loses its surface.
      _engine.muteLocalVideoStream(true);
      _engine.stopPreview();
    } else if (state == AppLifecycleState.resumed) {
      if (!_videoDisabled) {
        _engine.startPreview();
        _engine.muteLocalVideoStream(false);
      }
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    if (_engineInitialized) {
      _engine.stopPreview();
      _engine.leaveChannel();
      _engine.release();
    }
    super.dispose();
  }

  // ─── Agora Init ───────────────────────────────────────────────────────────

  Future<void> initAgora() async {
    try {
      await [Permission.microphone, Permission.camera].request();

      _engine = createAgoraRtcEngine();
      await _engine.initialize(const RtcEngineContext(
        appId: appId,
        channelProfile: ChannelProfileType.channelProfileCommunication,
      ));

      _engine.registerEventHandler(
        RtcEngineEventHandler(
          onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
            debugPrint("=== local user ${connection.localUid} joined ===");
            if (mounted) setState(() => _localUserJoined = true);
          },
          onUserJoined:
              (RtcConnection connection, int remoteUid, int elapsed) {
            debugPrint("remote user $remoteUid joined");
            if (mounted) setState(() => _remoteUid = remoteUid);
          },
          onUserOffline: (RtcConnection connection, int remoteUid,
              UserOfflineReasonType reason) {
            debugPrint("remote user $remoteUid left channel");
            if (!mounted) return;
            setState(() => _remoteUid = null);
            // Defer navigation — engine events fire on a native thread;
            // calling Navigator directly here can crash.
            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted) _onCallEnd(context);
            });
          },
          onTokenPrivilegeWillExpire:
              (RtcConnection connection, String token) {
            debugPrint(
                '[onTokenPrivilegeWillExpire] connection: ${connection.toJson()}, token: $token');
          },
        ),
      );

      await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
      await _engine.enableVideo();
      await _engine.startPreview();

      // Mark engine ready and rebuild — this shows the local camera preview.
      if (mounted) setState(() => _engineInitialized = true);

      await _engine.joinChannel(
        token: widget.customToken ?? token,
        channelId: widget.customChannelName ?? channelName,
        uid: 0,
        options: const ChannelMediaOptions(
          clientRoleType: ClientRoleType.clientRoleBroadcaster,
          publishCameraTrack: true,
          publishMicrophoneTrack: true,
        ),
      );
    } catch (e) {
      debugPrint("Error initializing Agora: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("حدث خطأ أثناء الانضمام للمكالمة: $e")),
        );
      }
    }
  }

  // ─── Controls ─────────────────────────────────────────────────────────────

  void _onToggleMute() {
    setState(() => _muted = !_muted);
    _engine.muteLocalAudioStream(_muted);
  }

  void _onToggleVideo() {
    setState(() => _videoDisabled = !_videoDisabled);
    _engine.muteLocalVideoStream(_videoDisabled);
  }

  /// Debounced camera switch — waits 800 ms for the surface texture to settle
  /// before allowing another switch, preventing BufferQueue abandoned errors.
  Future<void> _onSwitchCamera() async {
    if (_isSwitchingCamera || !_engineInitialized) return;
    if (mounted) setState(() => _isSwitchingCamera = true);
    try {
      await _engine.switchCamera();
      // Force rebuild AgoraVideoView to bind to the new SurfaceTexture
      await Future.delayed(const Duration(milliseconds: 300));
      if (mounted) setState(() => _localVideoKey++);
    } catch (e) {
      debugPrint("switchCamera error: $e");
    } finally {
      await Future.delayed(const Duration(milliseconds: 500));
      if (mounted) setState(() => _isSwitchingCamera = false);
    }
  }

  Future<void> _onCallEnd(BuildContext context) async {
    debugPrint("ON CALL END TRIGGRED. callId is: ${widget.callId}");
    if (widget.callId != null) {
      try {
        debugPrint("Calling endCall from API...");
        import_di.getit<import_call_cubit.CallCubit>().endCall(widget.callId!);
      } catch (e) {
        debugPrint("endCall API error: $e");
      }
    } else {
        debugPrint("WARNING: callId is NULL, cannot call endCall API");
    }
    
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const AdvisoryRatingDialog(),
    );
    if (mounted) Navigator.pop(context);
  }

  // ─── Build ────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            _remoteVideo(),
            _localVideoSplit(),
            _toolbar(),
          ],
        ),
      ),
    );
  }

  Widget _remoteVideo() {
    if (_remoteUid != null) {
      return Expanded(
        flex: 1,
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20.r),
            bottomRight: Radius.circular(20.r),
          ),
          child: AgoraVideoView(
            controller: VideoViewController.remote(
              rtcEngine: _engine,
              canvas: VideoCanvas(uid: _remoteUid),
              connection: RtcConnection(
                  channelId: widget.customChannelName ?? channelName),
              useFlutterTexture: true,
            ),
          ),
        ),
      );
    } else {
      return Expanded(
        flex: 1,
        child: Container(
          color: Colors.grey[900],
          child: const Center(
            child: Text(
              'في انتظار انضمام الطرف الآخر...',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      );
    }
  }

  Widget _localVideoSplit() {
    return Expanded(
      flex: 1,
      child: Stack(
        children: [
          Container(
            color: Colors.black,
            child: _engineInitialized && !_videoDisabled
                ? AgoraVideoView(
                    key: ValueKey('local_video_$_localVideoKey'),
                    controller: VideoViewController(
                      rtcEngine: _engine,
                      canvas: VideoCanvas(
                        uid: 0,
                        renderMode: RenderModeType.renderModeHidden,
                      ),
                      useFlutterTexture: true,
                    ),
                  )
                : const Center(
                    child:
                        Icon(Icons.videocam_off, color: Colors.white, size: 50),
                  ),
          ),
          Positioned(
            top: 20.h,
            right: 20.w,
            child: Container(
              padding:
                  EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Row(
                children: [
                  Icon(Icons.circle, color: Colors.red, size: 10.sp),
                  SizedBox(width: 5.w),
                  StreamBuilder<int>(
                    stream: Stream.periodic(
                        const Duration(seconds: 1), (i) => i),
                    builder: (context, snapshot) {
                      final seconds = snapshot.data ?? 0;
                      final h = (seconds / 3600).floor();
                      final m = ((seconds % 3600) / 60).floor();
                      final s = seconds % 60;
                      final timeStr =
                          "${h > 0 ? '$h:' : ''}${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}";
                      return Text(
                        timeStr,
                        style: TextStyles.cairo_14_bold
                            .copyWith(color: Colors.white),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _toolbar() {
    return Container(
      margin: EdgeInsets.all(20.w),
      padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 20.w),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.7),
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _controlButton(
            icon: Icons.cameraswitch,
            // Grey-out the button while a switch is already in progress
            onPressed: _isSwitchingCamera ? null : _onSwitchCamera,
          ),
          _controlButton(
            icon: _videoDisabled ? Icons.videocam_off : Icons.videocam,
            onPressed: _onToggleVideo,
          ),
          _controlButton(
            icon: _muted ? Icons.mic_off : Icons.mic,
            onPressed: _onToggleMute,
          ),
          _controlButton(
            icon: Icons.call_end,
            color: Colors.red,
            onPressed: () => _onCallEnd(context),
          ),
        ],
      ),
    );
  }

  Widget _controlButton({
    required IconData icon,
    required VoidCallback? onPressed,
    Color color = Colors.white24,
  }) {
    final isDisabled = onPressed == null;
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: isDisabled ? Colors.white10 : color,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: isDisabled ? Colors.white38 : Colors.white,
          size: 24.sp,
        ),
      ),
    );
  }
}
