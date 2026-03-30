import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../core/constants/colors.dart';
import '../../../../config/themes/styles.dart';
import 'rating_screen.dart';

const appId = "0d6fe83ed45142488b70a9d477fbcb6b";
const token = "007eJxTYDhzhMnllCuLYmD4izX35UxvflryYZuLTJ7oy3mr7r4qFdyqwGCQYpaWamGcmmJiamhiZGJhkWRukGiZYmJunpaUnGSWNP/O9syGQEaGpMPpjIwMEAjiszJE5pYkVjEwAADQ2SHJ";
const channelName = "Ymtaz";

class AgoraVideoCallScreen extends StatefulWidget {
  final String? customToken;
  final String? customChannelName;

  const AgoraVideoCallScreen({Key? key, this.customToken, this.customChannelName}) : super(key: key);

  @override
  State<AgoraVideoCallScreen> createState() => _AgoraVideoCallScreenState();
}

class _AgoraVideoCallScreenState extends State<AgoraVideoCallScreen> {
  int? _remoteUid;
  bool _localUserJoined = false;
  bool _muted = false;
  bool _videoDisabled = false;
  late RtcEngine _engine;

  @override
  void initState() {
    super.initState();
    initAgora();
  }

  Future<void> initAgora() async {
    // retrieve permissions
    await [Permission.microphone, Permission.camera].request();

    // create the engine
    _engine = createAgoraRtcEngine();
    await _engine.initialize(const RtcEngineContext(
      appId: appId,
      channelProfile: ChannelProfileType.channelProfileCommunication,
    ));

    _engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          debugPrint("local user \${connection.localUid} joined");
          setState(() {
            _localUserJoined = true;
          });
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          debugPrint("remote user \$remoteUid joined");
          setState(() {
            _remoteUid = remoteUid;
          });
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          debugPrint("remote user \$remoteUid left channel");
          setState(() {
            _remoteUid = null;
          });
          // End call if remote user leaves
          _onCallEnd(context);
        },
        onTokenPrivilegeWillExpire: (RtcConnection connection, String token) {
          debugPrint('[onTokenPrivilegeWillExpire] connection: \${connection.toJson()}, token: \$token');
        },
      ),
    );

    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);
    await _engine.enableVideo();
    await _engine.startPreview();

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
  }

  @override
  void dispose() {
    _engine.leaveChannel();
    _engine.release();
    super.dispose();
  }

  void _onToggleMute() {
    setState(() {
      _muted = !_muted;
    });
    _engine.muteLocalAudioStream(_muted);
  }

  void _onToggleVideo() {
    setState(() {
      _videoDisabled = !_videoDisabled;
    });
    _engine.muteLocalVideoStream(_videoDisabled);
  }

  void _onSwitchCamera() {
    _engine.switchCamera();
  }

  void _onCallEnd(BuildContext context) async {
    final result = await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const AdvisoryRatingDialog(),
    );
    
    // Once dialog returns result, we pop to the previous screen (lobby or details)
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Background/Remote Video
          Center(
            child: _remoteVideo(),
          ),
          
          // Local Video (PiP or split view, here we use Split as per design)
          SafeArea(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  _localVideoSplit(),
                  _toolbar(),
                ],
              ),
            ),
          ),
        ],
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
              connection: RtcConnection(channelId: widget.customChannelName ?? channelName),
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
            child: _localUserJoined && !_videoDisabled
                ? AgoraVideoView(
                    controller: VideoViewController(
                      rtcEngine: _engine,
                      canvas: const VideoCanvas(uid: 0),
                    ),
                  )
                : const Center(
                    child: Icon(Icons.videocam_off, color: Colors.white, size: 50),
                  ),
          ),
          Positioned(
            top: 20.h,
            right: 20.w,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Row(
                children: [
                  Icon(Icons.circle, color: Colors.red, size: 10.sp),
                  SizedBox(width: 5.w),
                  Text(
                    "14:59", // Dummy timer for now
                    style: TextStyles.cairo_14_bold.copyWith(color: Colors.white),
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
            onPressed: _onSwitchCamera,
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
    required VoidCallback onPressed,
    Color color = Colors.white24,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 24.sp,
        ),
      ),
    );
  }
}
