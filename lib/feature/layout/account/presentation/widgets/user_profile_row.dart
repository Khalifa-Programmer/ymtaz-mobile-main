import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';
import 'package:yamtaz/core/constants/colors.dart';
import 'package:yamtaz/l10n/locale_keys.g.dart';

import '../../../../../config/themes/styles.dart';
import '../../../../../core/network/local/cache_helper.dart';

class UserProfileColumn extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String image;
  final String? isVerified;
  final Color color;

  const UserProfileColumn({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.image,
    this.isVerified,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0.sp),
      child: Column(
        children: [
          Stack(
            children: [
              CircleAvatar(
                backgroundColor: color,
                radius: 53.0.sp,
                child: CachedNetworkImage(
                  imageUrl: imageUrl.isEmpty
                      ? "https://api.ymtaz.sa/uploads/person.png"
                      : imageUrl,
                  imageBuilder: (context, imageProvider) => Container(
                    width: 100.0.w,
                    height: 100.0.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover),
                    ),
                  ),
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      imageShimmer(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              Positioned(
                bottom: 0.0.h,
                left: 0,
                right: 60.w,
                child: Align(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    radius: 10.sp,
                    backgroundColor: appColors.white,
                    child: SvgPicture.network(
                      image,
                      width: 12.0.w, // Adjust width according to your design
                      height: 12.0.h,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: 14.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      name,
                      style: TextStyles.cairo_16_semiBold,
                    ),
                    if (isVerified != null)
                      isVerified == "blue"
                          ? Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.w),
                              child: Icon(
                                Icons.verified,
                                color: CupertinoColors.activeBlue,
                                size: 16.sp,
                              ),
                            )
                          : Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.w),
                              child: Icon(
                                Icons.verified,
                                color: Color(0xffd0b101),
                                size: 16.sp,
                              ),
                            ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class UserProfileRow extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String? isVerified;
  final double paddingTop;
  final Color color;
  final String image;

  const UserProfileRow({
    super.key,
    required this.imageUrl,
    required this.name,
    this.paddingTop = 10.0,
    this.isVerified,
    required this.image,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    var userType = CacheHelper.getData(key: 'userType');

    return Padding(
      padding: EdgeInsets.only(
        top: paddingTop.h,
        bottom: 10.0.sp,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            clipBehavior: Clip.none,
            // Allows the SVG to extend outside the Stack
            children: [
              CircleAvatar(
                backgroundColor: color,
                radius: 26.0.sp,
                child: CachedNetworkImage(
                  imageUrl: imageUrl.isEmpty
                      ? "https://api.ymtaz.sa/uploads/person.png"
                      : imageUrl,
                  imageBuilder: (context, imageProvider) => Container(
                    width: 48.0.w,
                    height: 48.0.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover),
                    ),
                  ),
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      imageShimmer(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),

              // SVG positioned at the bottom center, half outside the CircleAvatar
              Positioned(
                bottom: -8.0,
                // Adjust to position half of the SVG outside the avatar
                left: 0,
                right: 35.w,
                child: Align(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    radius: 10.sp,
                    backgroundColor: appColors.white,
                    child: SvgPicture.network(
                      image,
                      width: 12.0.w, // Adjust width according to your design
                      height: 12.0.h,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(right: 8.w, left: 8.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      LocaleKeys.welcome.tr(),
                      style: TextStyles.cairo_16_medium
                          .copyWith(color: appColors.grey10),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(name, style: TextStyles.cairo_16_bold),
                    if (isVerified != null)
                      isVerified == "blue"
                          ? Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.w),
                              child: Icon(
                                Icons.verified,
                                color: CupertinoColors.activeBlue,
                                size: 16.sp,
                              ),
                            )
                          : Padding(
                              padding: EdgeInsets.symmetric(horizontal: 5.w),
                              child: Icon(
                                Icons.verified,
                                // gold color
                                color: Color(0xffd0b101),
                                size: 16.sp,
                              ),
                            ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

Widget imageShimmer() {
  return Padding(
    padding: EdgeInsets.all(8.0.sp),
    child: Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15.sp),
        ),
      ),
    ),
  );
}
