import 'dart:async';

import 'package:flutter/material.dart';
import 'package:yamtaz/core/constants/colors.dart';

class TimeRemainingProgress extends StatefulWidget {
  final DateTime startDate;
  final DateTime endDate;

  const TimeRemainingProgress({super.key, required this.startDate, required this.endDate});

  @override
  _TimeRemainingProgressState createState() => _TimeRemainingProgressState();
}

class _TimeRemainingProgressState extends State<TimeRemainingProgress> {
  double _progress = 0.0;

  @override
  void initState() {
    super.initState();
    _updateProgress();
    Timer.periodic(Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _updateProgress();
        });
      } else {
        timer.cancel();
      }
    });
  }

  void _updateProgress() {
    final totalDuration = widget.endDate.difference(widget.startDate).inSeconds;
    final remainingDuration = widget.endDate.difference(DateTime.now()).inSeconds;
    _progress = remainingDuration / totalDuration;
    if (_progress < 0) {
      _progress = 0; // الوقت انتهى
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TweenAnimationBuilder(
        tween: Tween<double>(begin: 0.0, end: _progress),
        duration: Duration(seconds: 1),
        builder: (context, value, child) {
          return Stack(
            alignment: Alignment.center,
            children: [
              CircularProgressIndicator(
                value: value,
                strokeWidth: 4,
                backgroundColor: Colors.grey[300],
                // grident color

                color: appColors.primaryColorYellow,
              ),
              Text(
                "${(_progress * 100).toStringAsFixed(1)}%", // النسبة المئوية المتبقية
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold),
              ),
            ],
          );
        },
      ),
    );
  }
}
