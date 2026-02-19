import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yamtaz/feature/ymtaz_elite/data/model/elite_my_requests_model.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/widgets/audio_player_widget.dart';

class AttachmentItemWidget extends StatelessWidget {
  final FileElement file;

  const AttachmentItemWidget({super.key, required this.file});

  @override
  Widget build(BuildContext context) {
    final isVoice = file.isVoice == 1;
    final fileUrl = file.file ?? '';

    if (isVoice) {
      return Container(
        margin: EdgeInsets.only(bottom: 8.h),
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: AudioPlayerWidget(
          audioUrl: file.file.toString(),
          backgroundColor: appColors.white,
          activeWaveColor: appColors.primaryColorYellow,
          playButtonColor: appColors.primaryColorYellow,
          indicatorColor: appColors.blue100.withOpacity(0.7),
        ),
      );
    }

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: Colors.red[50],
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Icon(Icons.picture_as_pdf, color: Colors.red, size: 24.sp),
      ),
      title: Text(
        'ملفات القضية.PDF',
        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
      ),
      trailing: Icon(
        Icons.download,
        color: Theme.of(context).primaryColor,
        size: 24.sp,
      ),
      onTap: () async {
        final url = Uri.parse(fileUrl);
        if (await canLaunchUrl(url)) {
          await launchUrl(url);
        }
      },
    );
  }
}
