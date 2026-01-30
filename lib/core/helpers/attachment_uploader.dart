import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../config/themes/styles.dart';
import '../constants/assets.dart';
import '../constants/colors.dart';
import '../widgets/spacing.dart';
class AttachmentPicker extends StatefulWidget {
  final bool condition;
  final String title;
  final String uploadText;
  final String attachedText;
  final Function() onTap; // Only passing onTap function
  final Function() onRemoveFile;
  final File? attachment;
  final bool isNetworkAttachment;
  final String networkAttachmentText;
  final bool showPreview;

  const AttachmentPicker({
    super.key,
    required this.condition,
    required this.title,
    required this.uploadText,
    required this.attachedText,
    required this.onTap, // Required onTap function
    required this.onRemoveFile,
    this.attachment,
    this.isNetworkAttachment = false,
    this.networkAttachmentText = "يوجد مرفق سابق مرفوع",
    this.showPreview = true,
  });

  @override
  _AttachmentPickerState createState() => _AttachmentPickerState();
}

class _AttachmentPickerState extends State<AttachmentPicker> {
  @override
  Widget build(BuildContext context) {
    if (widget.isNetworkAttachment) {
      return _buildNetworkAttachment();
    } else if (widget.condition) {
      return Column(
        children: [
          if (widget.attachment == null) _buildAttachmentPicker(),
          if (widget.attachment != null && widget.showPreview)
            _buildFilePreview(),
        ],
      );
    } else {
      return const SizedBox();
    }
  }

  Widget _buildAttachmentPicker() {
    return Animate(
      effects: [FadeEffect(delay: 200.ms)],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            " مرفق ${widget.title}",
            style:
                TextStyles.cairo_12_medium.copyWith(color: appColors.blue100),
          ),
          verticalSpace(10.h),
          GestureDetector(
            onTap: widget.onTap,
            child: _buildPickerContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildNetworkAttachment() {
    return Animate(
      effects: [FadeEffect(delay: 200.ms)],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            " مرفق ${widget.title}",
            style:
                TextStyles.cairo_12_medium.copyWith(color: appColors.blue100),
          ),
          verticalSpace(10.h),
          ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.sp),
            ),
            leading: const Icon(
              Icons.file_copy,
              color: appColors.blue90,
            ),
            title: Text(
              widget.networkAttachmentText,
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
                color: appColors.black,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "اضغط لرفع ملف جديد",
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    color: appColors.grey5,
                  ),
                ),
              ],
            ),
            onTap: widget.onTap,
            trailing: GestureDetector(
              onTap: widget.onRemoveFile,
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: appColors.red5,
                ),
                padding: const EdgeInsets.all(8.0),
                child: const Icon(
                  Icons.delete,
                  color: appColors.red,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPickerContent() {
    return Container(
      height: 150.h,
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: widget.attachment != null ? appColors.blue100 : appColors.grey3,
        borderRadius: BorderRadius.circular(12.sp),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(AppAssets.upload),
          verticalSpace(20.h),
          Text(
            widget.uploadText,
            style: TextStyle(
              fontFamily: 'Cairo',
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
              color: appColors.blue100,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilePreview() {
    return Animate(
      effects: [FadeEffect(delay: 200.ms)],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            " مرفق ${widget.title}",
            style:
                TextStyles.cairo_12_medium.copyWith(color: appColors.blue100),
          ),
          verticalSpace(10.h),
          ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.sp),
            ),
            leading: const Icon(
              Icons.file_copy,
              color: appColors.blue90,
            ),
            title: Text(
              widget.attachment!.path.split('/').last,
              style: TextStyle(
                fontFamily: 'Cairo',
                fontSize: 13.sp,
                fontWeight: FontWeight.w400,
                color: appColors.black,
              ),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "حجم الملف: ${(widget.attachment!.lengthSync() / 1024).toStringAsFixed(2)} KB",
                  style: TextStyle(
                    fontFamily: 'Cairo',
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    color: appColors.grey5,
                  ),
                ),
                if (!widget.attachment!.path.toLowerCase().endsWith('.pdf'))
                  Text(
                    "اضغط للعرض",
                    style: TextStyle(
                      fontFamily: 'Cairo',
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w400,
                      color: appColors.grey5,
                    ),
                  ),
              ],
            ),
            onTap: () {
              if (widget.attachment!.path.toLowerCase().endsWith('.pdf')) {
                // Handle PDF display logic here
              } else {
                viewImage(context, widget.attachment!);
              }
            },
            trailing: GestureDetector(
              onTap: widget.onRemoveFile,
              child: Container(
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: appColors.red5,
                ),
                padding: const EdgeInsets.all(8.0),
                child: const Icon(
                  Icons.delete,
                  color: appColors.red,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _handleLongPress() {
    widget.onRemoveFile();
    setState(() {});
  }

  void viewImage(BuildContext context, File? image) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.file(
                  image!,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                  child: const Text('X'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
