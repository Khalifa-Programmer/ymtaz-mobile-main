// import 'dart:math' as math;
// import 'dart:io';
// import 'package:http/http.dart' as http;
// import 'package:path_provider/path_provider.dart';
// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
//
// class AudioState {
//   final bool isPlaying;
//   final Duration position;
//   final Duration duration;
//   final bool isLoading;
//
//   AudioState({
//     required this.isPlaying,
//     required this.position,
//     required this.duration,
//     required this.isLoading,
//   });
// }
//
// class AudioPlayerWidget extends StatefulWidget {
//   final String audioUrl;
//
//   const AudioPlayerWidget({super.key, required this.audioUrl});
//
//   @override
//   State<AudioPlayerWidget> createState() => _AudioPlayerWidgetState();
// }
//
// class _AudioPlayerWidgetState extends State<AudioPlayerWidget> {
//   final AudioPlayer audioPlayer = AudioPlayer();
//   bool hasError = false;
//   bool _isInitializing = false;
//   final ValueNotifier<AudioState> audioState = ValueNotifier(
//     AudioState(
//       isPlaying: false,
//       position: Duration.zero,
//       duration: Duration.zero,
//       isLoading: false,
//     ),
//   );
//
//   @override
//   void initState() {
//     super.initState();
//     _setupAudioPlayer();
//     _initAudio();
//   }
//
//   void _setupAudioPlayer() {
//     audioPlayer.onDurationChanged.listen((duration) {
//       audioState.value = AudioState(
//         isPlaying: audioState.value.isPlaying,
//         position: audioState.value.position,
//         duration: duration,
//         isLoading: audioState.value.isLoading,
//       );
//     });
//
//     audioPlayer.onPositionChanged.listen((position) {
//       audioState.value = AudioState(
//         isPlaying: audioState.value.isPlaying,
//         position: position,
//         duration: audioState.value.duration,
//         isLoading: audioState.value.isLoading,
//       );
//     });
//
//     audioPlayer.onPlayerComplete.listen((_) {
//       audioState.value = AudioState(
//         isPlaying: false,
//         position: Duration.zero,
//         duration: audioState.value.duration,
//         isLoading: false,
//       );
//     });
//
//     audioPlayer.onPlayerStateChanged.listen((state) {
//       audioState.value = AudioState(
//         isPlaying: state == PlayerState.playing,
//         position: audioState.value.position,
//         duration: audioState.value.duration,
//         isLoading: audioState.value.isLoading,
//       );
//     });
//   }
//
//   Future<void> _initAudio() async {
//     if (_isInitializing) return;
//
//     try {
//       setState(() {
//         _isInitializing = true;
//         hasError = false;
//       });
//
//       final audioUrl = widget.audioUrl.replaceAll('http://', 'https://');
//
//       await audioPlayer.setReleaseMode(ReleaseMode.release);
//       await audioPlayer.setSourceUrl(audioUrl);
//
//     } catch (e) {
//       print('Audio Init Error: $e');
//       setState(() => hasError = true);
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('خطأ في تحميل الملف الصوتي')),
//       );
//     } finally {
//       setState(() => _isInitializing = false);
//     }
//   }
//
//   Future<void> playPause() async {
//     try {
//       if (hasError) {
//         await _initAudio();
//         if (hasError) return;
//       }
//
//       if (audioState.value.isPlaying) {
//         await audioPlayer.pause();
//       } else {
//         await audioPlayer.resume();
//       }
//     } catch (e) {
//       print('Playback Error: $e');
//       setState(() => hasError = true);
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text('خطأ في تشغيل الملف الصوتي')),
//       );
//     }
//   }
//
//   String formatTime(Duration duration) {
//     String twoDigits(int n) => n.toString().padLeft(2, '0');
//     final minutes = twoDigits(duration.inMinutes.remainder(60));
//     final seconds = twoDigits(duration.inSeconds.remainder(60));
//     return '$minutes:$seconds';
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return ValueListenableBuilder<AudioState>(
//       valueListenable: audioState,
//       builder: (context, state, _) {
//         if (_isInitializing) {
//           return Center(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 CircularProgressIndicator(
//                   valueColor: AlwaysStoppedAnimation<Color>(
//                     Theme.of(context).primaryColor,
//                   ),
//                 ),
//                 SizedBox(height: 8.h),
//                 Text('جاري تحميل الملف الصوتي...'),
//               ],
//             ),
//           );
//         }
//
//         if (hasError) {
//           return Center(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Icon(Icons.error_outline, color: Colors.red, size: 32.sp),
//                 SizedBox(height: 8.h),
//                 Text(
//                   'حدث خطأ في تحميل الملف الصوتي',
//                   style: TextStyle(fontSize: 14.sp),
//                 ),
//                 TextButton(
//                   onPressed: _initAudio,
//                   child: Text('إعادة المحاولة'),
//                 ),
//               ],
//             ),
//           );
//         }
//
//         return Row(
//           children: [
//             IconButton(
//               icon: Icon(
//                 state.isPlaying ? Icons.pause_circle_filled : Icons.play_circle_filled,
//                 color: Theme.of(context).primaryColor,
//                 size: 32.sp,
//               ),
//               onPressed: playPause,
//             ),
//             Expanded(
//               child: Column(
//                 children: [
//                   SliderTheme(
//                     data: SliderThemeData(
//                       thumbShape:
//                           RoundSliderThumbShape(enabledThumbRadius: 8.r),
//                       trackHeight: 4.h,
//                       activeTrackColor: Theme.of(context).primaryColor,
//                       inactiveTrackColor: Colors.grey[300],
//                       thumbColor: Theme.of(context).primaryColor,
//                     ),
//                     child: Slider(
//                       min: 0,
//                       max: math.max(
//                           state.duration.inMilliseconds.toDouble(), 1.0),
//                       value: math.min(
//                         state.position.inMilliseconds.toDouble(),
//                         state.duration.inMilliseconds.toDouble(),
//                       ),
//                       onChanged: (value) async {
//                         final newPosition =
//                             Duration(milliseconds: value.toInt());
//                         await audioPlayer.seek(newPosition);
//                         audioState.value = AudioState(
//                           isPlaying: state.isPlaying,
//                           position: newPosition,
//                           duration: state.duration,
//                           isLoading: state.isLoading,
//                         );
//                       },
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 8.w),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         Text(
//                           formatTime(state.position),
//                           style: TextStyle(
//                               fontSize: 12.sp, color: Colors.grey[600]),
//                         ),
//                         Text(
//                           formatTime(state.duration),
//                           style: TextStyle(
//                               fontSize: 12.sp, color: Colors.grey[600]),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         );
//       },
//     );
//   }
//
//   @override
//   void dispose() {
//     audioPlayer.dispose();
//     super.dispose();
//   }
// }
