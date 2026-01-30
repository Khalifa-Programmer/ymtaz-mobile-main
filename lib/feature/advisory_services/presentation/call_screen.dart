import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:stream_video_flutter/stream_video_flutter.dart';
import 'package:yamtaz/core/constants/colors.dart';

class CallScreen extends StatefulWidget {
  const CallScreen({
    Key? key,
    required this.call,
    // required this.channel,
  }) : super(key: key);

  final Call call;

  // final Channel channel;

  @override
  State<CallScreen> createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  var isChatPaneVisible = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: StreamCallContainer(

            call: widget.call,
            callContentBuilder: (context, call, callState) {
              return StreamCallContent(
                call: call,
                callState: callState,
                onBackPressed: () => _finishCall(context),
                callControlsBuilder: (context, call, callState) {
                  return StreamCallControls(

                    options: customCallControlOptions(
                      call: call,

                      // channel: widget.channel,
                      onLeaveCallTap: () => _finishCall(context),

                      onChatTap: () {
                        if (kIsWeb) {
                          // toggleChatPane();
                        } else {
                          // Navigator.of(context).push(
                          //   MaterialPageRoute(
                          //     builder: (context) {
                          //       return StreamChannel(
                          //         channel: widget.channel,
                          //         child: const ChatScreen(),
                          //       );
                          //     },
                          //     fullscreenDialog: true,
                          //   ),
                          // );
                        }
                      },
                    ),
                  );
                },
              );
            },
          ),
        ),
        // isChatPaneVisible
        //     ? Expanded(
        //   flex: 1,
        //   child: StreamChannel(
        //     channel: widget.channel,
        //     child: ChatScreen(onBackPressed: () => toggleChatPane()),
        //   ),
        // )
        //     : Container()
      ],
    );
  }

  void toggleChatPane() {
    isChatPaneVisible = !isChatPaneVisible;
    setState(() {});
  }

  Future<void> _finishCall(BuildContext context) async {
    await widget.call.end();
    // await widget.channel.stopWatching();

    Navigator.of(context).pop();
  }


}

List<Widget> customCallControlOptions({
  required Call call,
  required VoidCallback onLeaveCallTap,
  required VoidCallback onChatTap,
}) {
  final localParticipant = call.state.value.localParticipant;
  assert(localParticipant != null, 'The local participant is null.');
  call.startRecording();

  return [
    ToggleMicrophoneOption(call: call, localParticipant: localParticipant!),
    ToggleCameraOption(call: call, localParticipant: localParticipant ),
    FlipCameraOption(call: call, localParticipant: localParticipant),
    ToggleScreenShareOption(call: call, localParticipant: localParticipant),
    ToggleSpeakerphoneOption(call: call , enabledSpeakerphoneIcon: CupertinoIcons.speaker_3_fill,),
    LeaveCallOption(call: call, onLeaveCallTap: onLeaveCallTap),
  ];
}

// class ToggleChat extends StatelessWidget {
//   const ToggleChat({
//     Key? key,
//     required this.cid,
//     required this.onChatTap,
//   }) : super(key: key);
//
//   final VoidCallback onChatTap;
//
//   /// Channel cid used to retrieve unread count.
//   final String? cid;
//
//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         CallControlOption(
//           icon: const Icon(Icons.chat),
//           iconColor: Colors.black,
//           backgroundColor: Colors.white,
//           onPressed: onChatTap,
//         ),
//         // Positioned(
//         //   top: 0,
//         //   right: 0,
//         //   child: StreamUnreadIndicator(cid: cid),
//         // ),
//       ],
//     );
//   }
// }
