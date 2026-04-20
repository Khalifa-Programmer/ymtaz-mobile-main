import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yamtaz/feature/ymtaz_elite/logic/call_cubit.dart';
import 'package:yamtaz/feature/ymtaz_elite/presentation/video_call/incoming_call_screen.dart';
import 'package:yamtaz/feature/advisory_window/presentation/video_call/agora_video_call_screen.dart';

class CallListener extends StatelessWidget {
  final Widget child;
  final GlobalKey<NavigatorState> navigatorKey;

  const CallListener({
    super.key,
    required this.child,
    required this.navigatorKey,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<CallCubit, CallState>(
      listener: (context, state) {
        if (state is CallStarted) {
          // If I started the call, I might want to show a calling screen or go straight to Agora
          // For now, let's go straight to Agora
          navigatorKey.currentState?.push(
            MaterialPageRoute(
              builder: (context) => AgoraVideoCallScreen(
                customToken: state.call.token,
                customChannelName: state.call.channelName,
                callId: state.call.id.toString(),
              ),
            ),
          );
        } else if (state is CallAccepted) {
          // If I accepted, navigate to Agora (if not already there)
           navigatorKey.currentState?.push(
            MaterialPageRoute(
              builder: (context) => AgoraVideoCallScreen(
                customToken: state.call.token,
                customChannelName: state.call.channelName,
                callId: state.call.id.toString(),
              ),
            ),
          );
        } else if (state is CallInitial) {
           // Poll for active calls or handle incoming via notifications
        }
      },
      child: child,
    );
  }
}
