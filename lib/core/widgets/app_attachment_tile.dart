import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:yamtaz/config/themes/styles.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/core/widgets/webview_pdf.dart';

class AppAttachmentTile extends StatelessWidget {
  final String? url;
  final String title;

  const AppAttachmentTile({
    super.key,
    required this.url,
    this.title = "تم إرفاق ملف",
  });

  bool _isImage(String path) {
    final lower = path.toLowerCase();
    return lower.endsWith('.jpg') ||
        lower.endsWith('.jpeg') ||
        lower.endsWith('.png') ||
        lower.endsWith('.gif') ||
        lower.endsWith('.webp');
  }

  bool _isPdf(String path) {
    return path.toLowerCase().endsWith('.pdf');
  }

  @override
  Widget build(BuildContext context) {
    if (url == null || url!.isEmpty) return const SizedBox.shrink();

    final isImg = _isImage(url!);
    final isPdfFile = _isPdf(url!);

    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      decoration: BoxDecoration(
        color: appColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: appColors.grey3),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8.r),
          child: Container(
            width: 50.w,
            height: 50.h,
            color: appColors.grey3,
            child: isImg
                ? CachedNetworkImage(
                    imageUrl: url!,
                    fit: BoxFit.cover,
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  )
                : Icon(
                    isPdfFile ? Icons.picture_as_pdf : Icons.attach_file,
                    color: isPdfFile ? Colors.red : appColors.blue100,
                  ),
          ),
        ),
        title: Text(
          title,
          style: TextStyles.cairo_12_bold.copyWith(color: appColors.blue100),
        ),
        trailing: TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PdfWebView(link: url!),
              ),
            );
          },
          child: Text(
            "عرض",
            style: TextStyles.cairo_14_bold.copyWith(color: appColors.primaryColorYellow),
          ),
        ),
      ),
    );
  }
}
