import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yamtaz/core/constants/colors.dart';

class UsersImagesWidget extends StatelessWidget {
  final List<String> imageList;
  final int totalCount;
  final double imageRadius;
  final int imageCount;
  final double imageBorderWidth;
  final double overlapDistance;
  final TextDirection textDirection;

  const UsersImagesWidget({
    super.key,
    required this.imageList,
    this.totalCount = 0,
    this.imageRadius = 25.0,
    this.imageCount = 5,
    this.imageBorderWidth = 2.0,
    this.overlapDistance = 30.0,
    this.textDirection = TextDirection.rtl,
  });

  @override
  Widget build(BuildContext context) {
    final votersToShow = imageList.take(imageCount).toList();
    final extraVotersCount =
        totalCount > imageCount ? totalCount - imageCount : 0;

    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: votersToShow.map((imageUrl) {
          return Align(
            widthFactor: 0.8,
            child: CircleAvatar(
              radius: imageRadius.r + imageBorderWidth.r,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: imageRadius.r,
                backgroundImage: imageUrl.isEmpty
                    ? null
                    : CachedNetworkImageProvider(imageUrl),
                child: imageUrl.isEmpty
                    ? Icon(
                        Icons.person,
                        size: imageRadius.r,
                        color: appColors.blue100,
                      )
                    : null,
                onBackgroundImageError: (_, __) {
                  print('Failed to load image.');
                },
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
