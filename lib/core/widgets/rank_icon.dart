import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yamtaz/core/constants/assets.dart';
import 'package:yamtaz/core/constants/colors.dart';

class RankIcon extends StatelessWidget {
  final String? imageUrl;
  final double size;

  const RankIcon({
    super.key,
    required this.imageUrl,
    this.size = 12.0,
  });

  @override
  Widget build(BuildContext context) {
    final url = imageUrl?.trim() ?? '';
    
    if (url.isEmpty) {
      return _buildLocalFallback();
    }

    if (url.toLowerCase().contains('.svg')) {
      return SvgPicture.network(
        url,
        width: size.w,
        height: size.h,
        placeholderBuilder: (context) => _buildLoading(),
        errorBuilder: (context, error, stackTrace) => _buildLocalFallback(),
      );
    }

    return CachedNetworkImage(
      imageUrl: url,
      width: size.w,
      height: size.h,
      placeholder: (context, url) => _buildLoading(),
      errorWidget: (context, url, error) => _buildLocalFallback(),
    );
  }

  Widget _buildLoading() {
    return SizedBox(
      width: size.w,
      height: size.h,
      child: const CircularProgressIndicator(strokeWidth: 2),
    );
  }

  Widget _buildLocalFallback() {
    return SvgPicture.asset(
      AppAssets.rank,
      width: size.w,
      height: size.h,
    );
  }
}
